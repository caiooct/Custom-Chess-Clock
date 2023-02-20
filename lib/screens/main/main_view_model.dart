import 'dart:async';

import 'package:flutter/material.dart';

import '../../common/extensions/on_int.dart';
import '../../data/game_state_enum.dart';
import '../../data/player_enum.dart';
import '../../data/time_control.dart';
import '../../data/timing_methods_enum.dart';

class MainViewModel extends ChangeNotifier {
  late final ValueNotifier<Duration> whiteTimerNotifier;
  late final ValueNotifier<Duration> blackTimerNotifier;
  final gameStateNotifier = ValueNotifier(GameState.initial);
  final countMovesWhiteNotifier = ValueNotifier(0);
  final countMovesBlackNotifier = ValueNotifier(0);
  final turnNotifier = ValueNotifier(PlayerEnum.none);
  @visibleForTesting
  late Timer timer;

  Duration get whiteTimer => whiteTimerNotifier.value;

  Duration get blackTimer => blackTimerNotifier.value;

  GameState get gameState => gameStateNotifier.value;

  int get countMovesWhite => countMovesWhiteNotifier.value;

  int get countMovesBlack => countMovesBlackNotifier.value;

  PlayerEnum get turn => turnNotifier.value;

  @visibleForTesting
  TimeControl timeControlWhite, timeControlBlack;

  MainViewModel(this.timeControlWhite, this.timeControlBlack)
      : whiteTimerNotifier = ValueNotifier(timeControlWhite.timeInSeconds.s),
        blackTimerNotifier = ValueNotifier(timeControlBlack.timeInSeconds.s);

  void _decrementWhiteTime() {
    whiteTimerNotifier.value -= _decrement.ms;
  }

  void _incrementWhiteTime() {
    if (timeControlWhite.timingMethod == TimingMethodEnum.delay) {
      // todo
    }
    if (timeControlWhite.timingMethod == TimingMethodEnum.bronstein) {
      // todo
    } else if (timeControlWhite.timingMethod == TimingMethodEnum.fischer) {
      whiteTimerNotifier.value += timeControlWhite.incrementInSeconds.s;
    }
  }

  void _decrementBlackTime() {
    blackTimerNotifier.value -= _decrement.ms;
  }

  void _incrementBlackTime() {
    if (timeControlWhite.timingMethod == TimingMethodEnum.delay) {
      // todo
    }
    if (timeControlWhite.timingMethod == TimingMethodEnum.bronstein) {
      // todo
    } else if (timeControlWhite.timingMethod == TimingMethodEnum.fischer) {
      blackTimerNotifier.value += timeControlBlack.incrementInSeconds.s;
    }
  }

  void startGame() {
    gameStateNotifier.value = GameState.running;
    turnNotifier.value = PlayerEnum.white;
    _setUpTimer();
  }

  void pauseGame() {
    gameStateNotifier.value = GameState.paused;
    timer.cancel();
  }

  void resumeGame() {
    gameStateNotifier.value = GameState.running;
    _setUpTimer();
  }

  void endGame() {
    gameStateNotifier.value = GameState.ended;
    turnNotifier.value = PlayerEnum.none;
    timer.cancel();
  }

  void restartGame() {
    gameStateNotifier.value = GameState.initial;
    countMovesWhiteNotifier.value = 0;
    countMovesBlackNotifier.value = 0;
    whiteTimerNotifier.value = timeControlWhite.timeInSeconds.s;
    blackTimerNotifier.value = timeControlBlack.timeInSeconds.s;
    timer.cancel();
  }

  void _setUpTimer() {
    timer = Timer.periodic(
      _decrement.ms,
      (_) {
        if (whiteTimer == Duration.zero || blackTimer == Duration.zero) {
          endGame();
        } else if (gameState.isNotPaused) {
          turn.isWhite ? _decrementWhiteTime() : _decrementBlackTime();
        }
      },
    );
  }

  void onPressedTimerButton(bool isBottomButton) {
    if (gameState.isInitial) startGame();
    if (gameState.isRunning) {
      isBottomButton ? _onPressedWhite() : _onPressedBlack();
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
      countMovesWhiteNotifier.value++;
      turnNotifier.value = PlayerEnum.black;
    } else {
      countMovesBlackNotifier.value++;
      turnNotifier.value = PlayerEnum.white;
    }
  }

  static const int _decrement = 100;
}
