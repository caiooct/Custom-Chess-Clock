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

class MainViewModel extends ChangeNotifier {
  final ValueNotifier<GameState> gameState = ValueNotifier(GameState.initial);
  late final ValueNotifier<Duration> _whiteTimer;
  late final ValueNotifier<Duration> _blackTimer;
  final ValueNotifier<int> _countMovesWhite = ValueNotifier(0);
  final ValueNotifier<int> _countMovesBlack = ValueNotifier(0);
  late Timer _timer;

  bool _isWhiteTurn = false;
  bool _isBlackTurn = false;
  final bool _isBottomTimerWhite = true;

  ValueNotifier<Duration> get whiteTimer => _whiteTimer;
  ValueNotifier<Duration> get blackTimer => _blackTimer;
  ValueNotifier<int> get countMovesWhite => _countMovesWhite;
  ValueNotifier<int> get countMovesBlack => _countMovesBlack;
  bool get isWhiteTurn => _isWhiteTurn;
  bool get isBlackTurn => _isBlackTurn;
  bool get isBottomTimerWhite => _isBottomTimerWhite;

  MainViewModel(TimeControl timeControlWhite, TimeControl timeControlBlack)
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
    _isWhiteTurn = true;
    _isBlackTurn = false;
    _setUpTimer();
  }

  void pauseGame() {
    gameState.value = GameState.paused;
    _timer.cancel();
  }

  void resumeGame() {
    gameState.value = GameState.running;
    _setUpTimer();
  }

  void endGame() {
    gameState.value = GameState.ended;
    _isWhiteTurn = false;
    _isBlackTurn = false;
    _timer.cancel();
  }

  void _setUpTimer() {
    _timer = Timer.periodic(
      _decrement.ms,
      (_) {
        if (whiteTimer.value == Duration.zero ||
            blackTimer.value == Duration.zero) {
          endGame();
        } else if (gameState.value.isNotPaused) {
          isWhiteTurn ? _decrementWhiteTime() : _decrementBlackTime();
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
    if (isWhiteTurn) {
      _switchTurns();
    }
  }

  void _onPressedBlack() {
    if (isBlackTurn) {
      _switchTurns();
    }
  }

  void _switchTurns() {
    if (isWhiteTurn) {
      countMovesWhite.value++;
      _isWhiteTurn = false;
      _isBlackTurn = true;
    } else {
      countMovesBlack.value++;
      _isWhiteTurn = true;
      _isBlackTurn = false;
    }
  }

  static const int _decrement = 100;
}
