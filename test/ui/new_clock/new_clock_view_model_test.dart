import 'package:custom_chess_clock/data/repositories/clock_repository.dart';
import 'package:custom_chess_clock/ui/new_clock/new_clock_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockClockRepository extends Mock implements ClockRepository {}

void main() {
  late NewClockViewModel viewModel;
  late MockClockRepository repository;

  group('NewClockViewModel', () {
    setUp(() {
      repository = MockClockRepository();
      viewModel = NewClockViewModel(repository);
    });

    group('given White', () {
      test("should set White's time", () {
        viewModel.setTimePlayerOne(0, 0, 1);
        expect(viewModel.clock.white.timeInSeconds, equals(1));
      });

      test("should set White's time", () {
        viewModel.setTimePlayerOne(0, 1, 1);
        expect(viewModel.clock.white.timeInSeconds, equals(61));
      });

      test("should set White's time", () {
        viewModel.setTimePlayerOne(1, 0, 1);
        expect(viewModel.clock.white.timeInSeconds, equals(3601));
      });

      test("should set White's time", () {
        viewModel.setTimePlayerOne(1, 1, 1);
        expect(viewModel.clock.white.timeInSeconds, equals(3661));
      });

      test("should set White's increment time", () {
        viewModel.setIncrementPlayerOne(0, 1);
        expect(viewModel.clock.white.incrementInSeconds, equals(1));
      });

      test("should set White's increment time", () {
        viewModel.setIncrementPlayerOne(1, 0);
        expect(viewModel.clock.white.incrementInSeconds, equals(60));
      });

      test("should set White's increment time", () {
        viewModel.setIncrementPlayerOne(1, 1);
        expect(viewModel.clock.white.incrementInSeconds, equals(61));
      });
    });

    group('given Black', () {
      test("should set Black's time", () {
        viewModel.setTimePlayerTwo(0, 0, 1);
        expect(viewModel.clock.black.timeInSeconds, equals(1));
      });

      test("should set Black's time", () {
        viewModel.setTimePlayerTwo(0, 1, 1);
        expect(viewModel.clock.black.timeInSeconds, equals(61));
      });

      test("should set Black's time", () {
        viewModel.setTimePlayerTwo(1, 0, 1);
        expect(viewModel.clock.black.timeInSeconds, equals(3601));
      });

      test("should set Black's time", () {
        viewModel.setTimePlayerTwo(1, 1, 1);
        expect(viewModel.clock.black.timeInSeconds, equals(3661));
      });

      test("should set Black's increment time", () {
        viewModel.setIncrementPlayerTwo(0, 1);
        expect(viewModel.clock.black.incrementInSeconds, equals(1));
      });

      test("should set Black's increment time", () {
        viewModel.setIncrementPlayerTwo(1, 0);
        expect(viewModel.clock.black.incrementInSeconds, equals(60));
      });

      test("should set Black's increment time", () {
        viewModel.setIncrementPlayerTwo(1, 1);
        expect(viewModel.clock.black.incrementInSeconds, equals(61));
      });
    });
  });
}
