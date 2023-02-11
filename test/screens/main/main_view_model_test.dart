// ignore_for_file: require_trailing_commas

import 'package:custom_chess_clock/data/time_control.dart';
import 'package:custom_chess_clock/data/timing_methods_enum.dart';
import 'package:custom_chess_clock/screens/main/main_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late MainViewModel viewModel;
  setUp(() {
    viewModel = MainViewModel(
      const TimeControl(
        timeInSeconds: 60,
        timingMethod: TimingMethodEnum.delay,
        incrementInSeconds: 0,
      ),
      const TimeControl(
        timeInSeconds: 60,
        timingMethod: TimingMethodEnum.delay,
        incrementInSeconds: 0,
      ),
    );
  });

  test("should start the game and White's timer", () {
    viewModel.startGame();
    expect(viewModel.gameState.value, GameState.running);
    expect(viewModel.isWhiteTurn, isTrue);
    expect(viewModel.isBlackTurn, isFalse);
    expect(viewModel.isBottomTimerWhite, isTrue);
  });

  group("Given White's turn", () {
    group("Game is running", () {
      setUp(() {
        viewModel.startGame();
      });
      test(
          "should switch from White to Black's turn when White presses the button",
          () {
        int countBeforeMove = viewModel.countMovesWhite.value;
        viewModel.onPressedTimerButton(true);
        expect(viewModel.countMovesWhite.value, equals(countBeforeMove + 1));
        expect(viewModel.isWhiteTurn, isFalse);
        expect(viewModel.isBlackTurn, isTrue);
      });

      test("should pause", () async {
        var whiteTimeBeforePause = viewModel.whiteTimer.value.inSeconds;
        var blackTimeBeforePause = viewModel.blackTimer.value.inSeconds;
        viewModel.pause();
        expect(viewModel.gameState.value, GameState.paused);
        expect(viewModel.isWhiteTurn, isTrue);
        expect(viewModel.isBlackTurn, isFalse);
        await Future.delayed(const Duration(seconds: 2));
        expect(
            whiteTimeBeforePause, equals(viewModel.whiteTimer.value.inSeconds));
        expect(
            blackTimeBeforePause, equals(viewModel.blackTimer.value.inSeconds));
      });
    });

    group("Game is paused", () {
      late int whiteTimeAfterPause;
      late int blackTimeAfterPause;
      setUp(() {
        viewModel.startGame();
        viewModel.pause();
        whiteTimeAfterPause = viewModel.whiteTimer.value.inSeconds;
        blackTimeAfterPause = viewModel.blackTimer.value.inSeconds;
      });

      test("should resume the game", () async {
        viewModel.resume();
        expect(viewModel.gameState.value, GameState.running);
        expect(viewModel.isWhiteTurn, isTrue);
        expect(viewModel.isBlackTurn, isFalse);
        await Future.delayed(const Duration(seconds: 2));
        expect(
            whiteTimeAfterPause, isNot(viewModel.whiteTimer.value.inSeconds));
        expect(
            blackTimeAfterPause, equals(viewModel.blackTimer.value.inSeconds));
      });
    });
  });

  group("Given Black's turn", () {
    group("Game is running", () {
      setUp(() {
        viewModel.startGame();
        viewModel.onPressedTimerButton(true);
      });

      test("should switch from Black to White's turn when Black presses the button", () {
        int countBeforeMove = viewModel.countMovesBlack.value;
        viewModel.onPressedTimerButton(false);
        expect(viewModel.countMovesBlack.value, greaterThanOrEqualTo(countBeforeMove));
        expect(viewModel.isWhiteTurn, isTrue);
        expect(viewModel.isBlackTurn, isFalse);
      });

      test("should pause", () async {
        var whiteTimeBeforePause = viewModel.whiteTimer.value.inSeconds;
        var blackTimeBeforePause = viewModel.blackTimer.value.inSeconds;
        viewModel.pause();
        expect(viewModel.gameState.value, GameState.paused);
        expect(viewModel.isWhiteTurn, isFalse);
        expect(viewModel.isBlackTurn, isTrue);
        await Future.delayed(const Duration(seconds: 2));
        expect(
            whiteTimeBeforePause, equals(viewModel.whiteTimer.value.inSeconds));
        expect(
            blackTimeBeforePause, equals(viewModel.blackTimer.value.inSeconds));
      });

      test("should end the game", () {
        viewModel.endGame();
        expect(viewModel.gameState.value, GameState.ended);
      });
    });

    group("Game is paused", () {
      late int whiteTimeAfterPause;
      late int blackTimeAfterPause;
      setUp(() {
        viewModel.startGame();
        viewModel.onPressedTimerButton(true);
        viewModel.pause();
        whiteTimeAfterPause = viewModel.whiteTimer.value.inSeconds;
        blackTimeAfterPause = viewModel.blackTimer.value.inSeconds;
      });

      test("should resume the game", () async {
        viewModel.resume();
        expect(viewModel.gameState.value, GameState.running);
        expect(viewModel.isWhiteTurn, isFalse);
        expect(viewModel.isBlackTurn, isTrue);
        await Future.delayed(const Duration(seconds: 2));
        expect(
            whiteTimeAfterPause, equals(viewModel.whiteTimer.value.inSeconds));
        expect(
            blackTimeAfterPause, isNot(viewModel.blackTimer.value.inSeconds));
      });
    });
  });
}
