import 'dart:async';

import 'package:flutter/material.dart';

class MainViewModel extends ChangeNotifier {
  late final ValueNotifier<Duration> _whiteTimer;
  late final ValueNotifier<Duration> _blackTimer;
  final ValueNotifier<int> _countMovesWhite = ValueNotifier(0);
  final ValueNotifier<int> _countMovesBlack = ValueNotifier(0);
  late Timer _timer;

  bool _hasStarted = false;
  ValueNotifier<bool> isPaused = ValueNotifier(true);
  bool _isWhiteTurn = false;
  bool _isBlackTurn = false;
  final bool _isBottomTimerWhite = true;

  ValueNotifier<Duration> get whiteTimer => _whiteTimer;

  ValueNotifier<Duration> get blackTimer => _blackTimer;

  ValueNotifier<int> get countMovesWhite => _countMovesWhite;

  ValueNotifier<int> get countMovesBlack => _countMovesBlack;

  bool get hasStarted => _hasStarted;

  bool get isWhiteTurn => _isWhiteTurn;

  bool get isBlackTurn => _isBlackTurn;

  bool get isBottomTimerWhite => _isBottomTimerWhite;

  bool get isFirstMove =>
      countMovesWhite.value == 0 && countMovesBlack.value == 0;

  MainViewModel(timeControlWhite, timeControlBlack)
      : _whiteTimer = ValueNotifier(
          Duration(seconds: timeControlWhite.timeInSeconds),
        ),
        _blackTimer = ValueNotifier(
          Duration(seconds: timeControlBlack.timeInSeconds),
        );

  void _decrementWhiteTime() {
    whiteTimer.value =
        whiteTimer.value - const Duration(milliseconds: _decrement);
    notifyListeners();
  }

  void _decrementBlackTime() {
    blackTimer.value =
        blackTimer.value - const Duration(milliseconds: _decrement);
    notifyListeners();
  }

  void startGame() {
    _hasStarted = true;
    isPaused.value = false;
    _isWhiteTurn = true;
    _isBlackTurn = false;
    _setUpTimer();
  }

  void pause() {
    isPaused.value = true;
    _timer.cancel();
  }

  void resume() {
    isPaused.value = false;
    _setUpTimer();
  }

  void _setUpTimer() {
    _timer = Timer.periodic(
      const Duration(milliseconds: _decrement),
      (_) {
        if (whiteTimer.value == Duration.zero ||
            blackTimer.value == Duration.zero) {
          _timer.cancel();
          return;
        }
        if (isPaused.value) return;
        isWhiteTurn ? _decrementWhiteTime() : _decrementBlackTime();
      },
    );
  }

  void onPressedTimerButton(bool isBottomButton) {
    if (!hasStarted) startGame();
    if (!isPaused.value) {
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
