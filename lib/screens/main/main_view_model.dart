import 'dart:async';

import 'package:flutter/material.dart';

import '../../common/extensions/on_int.dart';
import '../../data/time_control.dart';

enum GameState {
  initial,
  started,
  paused,
  running,
  ended;

  bool get isInitial => this == initial;
  bool get isStarted => this == started;
  bool get isPaused => this == paused;
  bool get isRunning => this == running;
  bool get isEnded => this == ended;
  bool get isNotPaused => this != paused;
  bool get isNotRunning => this != running;
  bool get isNotEnded => this != ended;
}

enum Player {
  none,
  white,
  black;

  bool get isNone => this == none;
  bool get isWhite => this == white;
  bool get isBlack => this == black;
}

class MainViewModel extends ChangeNotifier {
  final ValueNotifier<GameState> gameState = ValueNotifier(GameState.initial);
  late final ValueNotifier<Duration> _whiteTimer;
  late final ValueNotifier<Duration> _blackTimer;
  final ValueNotifier<int> _countMovesWhite = ValueNotifier(0);
  final ValueNotifier<int> _countMovesBlack = ValueNotifier(0);
  final ValueNotifier<Player> turnNotifier = ValueNotifier(Player.none);
  @visibleForTesting
  late Timer timer;


  final bool _isBottomTimerWhite = true;

  ValueNotifier<Duration> get whiteTimer => _whiteTimer;
  ValueNotifier<Duration> get blackTimer => _blackTimer;
  ValueNotifier<int> get countMovesWhite => _countMovesWhite;
  ValueNotifier<int> get countMovesBlack => _countMovesBlack;
  bool get isBottomTimerWhite => _isBottomTimerWhite;
  Player get turn => turnNotifier.value;

  @visibleForTesting
  TimeControl timeControlWhite, timeControlBlack;
  MainViewModel(this.timeControlWhite, this.timeControlBlack)
      : _whiteTimer = ValueNotifier(timeControlWhite.timeInSeconds.s),
        _blackTimer = ValueNotifier(timeControlBlack.timeInSeconds.s);

  void _decrementWhiteTime() {
    whiteTimer.value -= _decrement.ms;
  }

  void _decrementBlackTime() {
    blackTimer.value -= _decrement.ms;
  }

  void startGame() {
    gameState.value = GameState.running;
    turnNotifier.value = Player.white;
    _setUpTimer();
  }

  void pauseGame() {
    gameState.value = GameState.paused;
    timer.cancel();
  }

  void resumeGame() {
    gameState.value = GameState.running;
    _setUpTimer();
  }

  void endGame() {
    gameState.value = GameState.ended;
    turnNotifier.value = Player.none;
    timer.cancel();
  }

  void restartGame() {
    gameState.value = GameState.initial;
    countMovesWhite.value = 0;
    countMovesBlack.value = 0;
    _whiteTimer.value = timeControlWhite.timeInSeconds.s;
    _blackTimer.value = timeControlBlack.timeInSeconds.s;
    timer.cancel();
  }

  void _setUpTimer() {
    timer = Timer.periodic(
      _decrement.ms,
      (_) {
        if (whiteTimer.value == Duration.zero ||
            blackTimer.value == Duration.zero) {
          endGame();
        } else if (gameState.value.isNotPaused) {
          turn.isWhite ? _decrementWhiteTime() : _decrementBlackTime();
        }
      },
    );
  }

  void onPressedTimerButton(bool isBottomButton) {
    if (gameState.value.isInitial) startGame();
    if (gameState.value.isRunning) {
      isBottomButton && isBottomTimerWhite
          ? _onPressedWhite()
          : _onPressedBlack();
    }
  }

  void _onPressedWhite() {
    if (turn.isWhite) {
      _switchTurns();
    }
  }

  void _onPressedBlack() {
    if (turn.isBlack) {
      _switchTurns();
    }
  }

  void _switchTurns() {
    if (turn.isWhite) {
      countMovesWhite.value++;
      turnNotifier.value = Player.black;
    } else {
      countMovesBlack.value++;
      turnNotifier.value = Player.white;
    }
  }

  static const int _decrement = 100;
}
