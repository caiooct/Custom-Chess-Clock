// ignore_for_file: require_trailing_commas

import 'package:custom_chess_clock/common/extensions/on_int.dart';
import 'package:custom_chess_clock/data/game_state_enum.dart';
import 'package:custom_chess_clock/data/time_control.dart';
import 'package:custom_chess_clock/data/timing_methods_enum.dart';
import 'package:custom_chess_clock/screens/main/main_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late MainViewModel viewModel;
  const int whiteTimeInSeconds = 3;
  const int blackTimeInSeconds = 3;
  setUp(() {
    viewModel = MainViewModel(
      const TimeControl(
        timeInSeconds: whiteTimeInSeconds,
        timingMethod: TimingMethodEnum.fischer,
        incrementInSeconds: 5,
      ),
      const TimeControl(
        timeInSeconds: blackTimeInSeconds,
        timingMethod: TimingMethodEnum.fischer,
        incrementInSeconds: 5,
      ),
    );
  });

  test("should start the game and White's timer", () {
    viewModel.startGame();
    expect(viewModel.gameState, GameState.running);
    expect(viewModel.turn.isWhite, isTrue);
    expect(viewModel.turn.isBlack, isFalse);
    expect(viewModel.timer.isActive, isTrue);
  });

  test('should restart to initial state', () {
    viewModel.startGame();
    viewModel.restartGame();
    expect(viewModel.gameState, equals(GameState.initial));
    expect(viewModel.countMovesWhite, equals(0));
    expect(viewModel.countMovesBlack, equals(0));
    expect(viewModel.whiteTimer,
        equals(viewModel.timeControlWhite.timeInSeconds.s));
    expect(viewModel.blackTimer,
        equals(viewModel.timeControlBlack.timeInSeconds.s));
    expect(viewModel.timer.isActive, isFalse);
  });

  group("Given White's turn", () {
    group("Game is running", () {
      setUp(() {
        viewModel.startGame();
      });
      test(
          "should switch from White to Black's turn when White presses the button",
          () {
        int countBeforeMove = viewModel.countMovesWhite;
        viewModel.onPressedTimerButton(true);
        expect(viewModel.countMovesWhite, equals(countBeforeMove + 1));
        expect(viewModel.turn.isWhite, isFalse);
        expect(viewModel.turn.isBlack, isTrue);
      });

      test("should pause", () async {
        var whiteTimeBeforePause = viewModel.whiteTimer.inSeconds;
        var blackTimeBeforePause = viewModel.blackTimer.inSeconds;
        viewModel.pauseGame();
        expect(viewModel.timer.isActive, isFalse);
        expect(viewModel.gameState, GameState.paused);
        expect(viewModel.turn.isWhite, isTrue);
        expect(viewModel.turn.isBlack, isFalse);
        await Future.delayed(const Duration(seconds: 2));
        expect(whiteTimeBeforePause, equals(viewModel.whiteTimer.inSeconds));
        expect(blackTimeBeforePause, equals(viewModel.blackTimer.inSeconds));
      });

      test("should end the game", () async {
        await Future.delayed(const Duration(seconds: blackTimeInSeconds + 1));
        expect(viewModel.timer.isActive, isFalse);
        expect(viewModel.gameState, GameState.ended);
        expect(viewModel.whiteTimer, lessThanOrEqualTo(Duration.zero));
        expect(viewModel.turn.isBlack, isFalse);
        expect(viewModel.turn.isWhite, isFalse);
      });

      test("should increment in fischer timing method", () {
        var timeBeforeIncrement = viewModel.whiteTimer.inSeconds;
        viewModel.onPressedTimerButton(true);
        var timeAfterIncrement = viewModel.whiteTimer.inSeconds;

        expect(
            timeAfterIncrement,
            equals(timeBeforeIncrement +
                viewModel.timeControlWhite.incrementInSeconds));
      });
    });

    group("Game is paused", () {
      late int whiteTimeAfterPause;
      late int blackTimeAfterPause;
      setUp(() {
        viewModel.startGame();
        viewModel.pauseGame();
        whiteTimeAfterPause = viewModel.whiteTimer.inSeconds;
        blackTimeAfterPause = viewModel.blackTimer.inSeconds;
      });

      test("should resume the game", () async {
        viewModel.resumeGame();
        expect(viewModel.timer.isActive, isTrue);
        expect(viewModel.gameState, GameState.running);
        expect(viewModel.turn.isWhite, isTrue);
        expect(viewModel.turn.isBlack, isFalse);
        await Future.delayed(const Duration(seconds: 2));
        expect(whiteTimeAfterPause, isNot(viewModel.whiteTimer.inSeconds));
        expect(blackTimeAfterPause, equals(viewModel.blackTimer.inSeconds));
      });
    });
  });

  group("Given Black's turn", () {
    group("Game is running", () {
      setUp(() {
        viewModel.startGame();
        viewModel.onPressedTimerButton(true);
      });

      test(
          "should switch from Black to White's turn when Black presses the button",
          () {
        int countBeforeMove = viewModel.countMovesBlack;
        viewModel.onPressedTimerButton(false);
        expect(
            viewModel.countMovesBlack, greaterThanOrEqualTo(countBeforeMove));
        expect(viewModel.turn.isWhite, isTrue);
        expect(viewModel.turn.isBlack, isFalse);
      });

      test("should pause", () async {
        var whiteTimeBeforePause = viewModel.whiteTimer.inSeconds;
        var blackTimeBeforePause = viewModel.blackTimer.inSeconds;
        viewModel.pauseGame();
        expect(viewModel.timer.isActive, isFalse);
        expect(viewModel.gameState, GameState.paused);
        expect(viewModel.turn.isWhite, isFalse);
        expect(viewModel.turn.isBlack, isTrue);
        await Future.delayed(const Duration(seconds: 2));
        expect(whiteTimeBeforePause, equals(viewModel.whiteTimer.inSeconds));
        expect(blackTimeBeforePause, equals(viewModel.blackTimer.inSeconds));
      });

      test("should end the game", () async {
        await Future.delayed(const Duration(seconds: blackTimeInSeconds + 1));
        expect(viewModel.timer.isActive, isFalse);
        expect(viewModel.gameState, GameState.ended);
        expect(viewModel.blackTimer, lessThanOrEqualTo(Duration.zero));
        expect(viewModel.turn.isBlack, isFalse);
        expect(viewModel.turn.isWhite, isFalse);
      });

      test("should increment in fischer timing method", () {
        var timeBeforeIncrement = viewModel.blackTimer.inSeconds;
        viewModel.onPressedTimerButton(false);
        var timeAfterIncrement = viewModel.blackTimer.inSeconds;

        expect(
            timeAfterIncrement,
            equals(timeBeforeIncrement +
                viewModel.timeControlBlack.incrementInSeconds));
      });
    });

    group("Game is paused", () {
      late int whiteTimeAfterPause;
      late int blackTimeAfterPause;
      setUp(() {
        viewModel.startGame();
        viewModel.onPressedTimerButton(true);
        viewModel.pauseGame();
        whiteTimeAfterPause = viewModel.whiteTimer.inSeconds;
        blackTimeAfterPause = viewModel.blackTimer.inSeconds;
      });

      test("should resume the game", () async {
        viewModel.resumeGame();
        expect(viewModel.timer.isActive, isTrue);
        expect(viewModel.gameState, GameState.running);
        expect(viewModel.turn.isWhite, isFalse);
        expect(viewModel.turn.isBlack, isTrue);
        await Future.delayed(const Duration(seconds: 2));
        expect(whiteTimeAfterPause, equals(viewModel.whiteTimer.inSeconds));
        expect(blackTimeAfterPause, isNot(viewModel.blackTimer.inSeconds));
      });
    });
  });
}
