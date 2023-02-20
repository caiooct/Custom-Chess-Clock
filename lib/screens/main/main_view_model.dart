import 'dart:async';

import 'package:flutter/material.dart';

import '../../common/extensions/on_int.dart';
import '../../data/time_control.dart';
import '../../data/timing_methods_enum.dart';

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
  final ValueNotifier<GameState> _gameStateNotifier =
      ValueNotifier(GameState.initial);
  late final ValueNotifier<Duration> _whiteTimerNotifier;
  late final ValueNotifier<Duration> _blackTimerNotifier;
  final ValueNotifier<int> _countMovesWhiteNotifier = ValueNotifier(0);
  final ValueNotifier<int> _countMovesBlackNotifier = ValueNotifier(0);
  final ValueNotifier<Player> _turnNotifier = ValueNotifier(Player.none);
  @visibleForTesting
  late Timer timer;

  final bool _isBottomTimerWhite = true;

  ValueNotifier<GameState> get gameState => _gameStateNotifier;
  ValueNotifier<Duration> get whiteTimer => _whiteTimerNotifier;
  ValueNotifier<Duration> get blackTimer => _blackTimerNotifier;
  ValueNotifier<int> get countMovesWhite => _countMovesWhiteNotifier;
  ValueNotifier<int> get countMovesBlack => _countMovesBlackNotifier;
  bool get isBottomTimerWhite => _isBottomTimerWhite;
  ValueNotifier<Player> get turnNotifier => _turnNotifier;
  Player get turn => turnNotifier.value;

  @visibleForTesting
  TimeControl timeControlWhite, timeControlBlack;

  MainViewModel(this.timeControlWhite, this.timeControlBlack)
      : _whiteTimerNotifier = ValueNotifier(timeControlWhite.timeInSeconds.s),
        _blackTimerNotifier = ValueNotifier(timeControlBlack.timeInSeconds.s);

  void _decrementWhiteTime() {
    whiteTimer.value -= _decrement.ms;
  }

  void _incrementWhiteTime() {
    if (timeControlWhite.timingMethod == TimingMethodEnum.delay) {
      // todo
    }
    if (timeControlWhite.timingMethod == TimingMethodEnum.bronstein) {
      // todo
    } else if (timeControlWhite.timingMethod == TimingMethodEnum.fischer) {
      whiteTimer.value += timeControlWhite.incrementInSeconds.s;
    }
  }

  void _decrementBlackTime() {
    blackTimer.value -= _decrement.ms;
  }

  void _incrementBlackTime() {
    if (timeControlWhite.timingMethod == TimingMethodEnum.delay) {
      // todo
    }
    if (timeControlWhite.timingMethod == TimingMethodEnum.bronstein) {
      // todo
    } else if (timeControlWhite.timingMethod == TimingMethodEnum.fischer) {
      blackTimer.value += timeControlBlack.incrementInSeconds.s;
    }
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
    _whiteTimerNotifier.value = timeControlWhite.timeInSeconds.s;
    _blackTimerNotifier.value = timeControlBlack.timeInSeconds.s;
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
      _incrementWhiteTime();
      _switchTurns();
    }
  }

  void _onPressedBlack() {
    if (turn.isBlack) {
      _incrementBlackTime();
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
