import "package:custom_chess_clock/data/repositories/clock_repository.dart";
import "package:custom_chess_clock/ui/clocks_list/clocks_list_view_model.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mocktail/mocktail.dart";

import "../../mocks/clocks.dart";

class MockClockRepository extends Mock implements ClockRepository {}

void main() {
  late ClocksListViewModel viewModel;
  late MockClockRepository repository;

  group("Given more than one is selected", () {
    setUp(() {
      repository = MockClockRepository();
      viewModel = ClocksListViewModel(repository)
        ..selectedClocksList.addAll([
          blitzClock,
          bulletClock,
        ]);
    });

    test("should empty the selectedClocksList", () {
      viewModel.clearSelectedClocksList();
      expect(viewModel.selectedClocksList, isEmpty);
    });

    test("should remove clock from selectedClocksList when clock is tapped and in the list", () {
      viewModel.onTapClockCard(blitzClock);
      expect(viewModel.selectedClocksList.contains(blitzClock), isFalse);
    });

    test("should add clock in selectedClocksList when clock is tapped and not in the list", () {
      viewModel.onTapClockCard(rapidClock);
      expect(viewModel.selectedClocksList.contains(rapidClock), isTrue);
    });

    test("should return true if clock is not in selectedClocksList", () {
      bool response = viewModel.isSelected(blitzClock);
      expect(response, isTrue);
    });

    test("should return false if clock is not in selectedClocksList", () {
      bool response = viewModel.isSelected(rapidClock);
      expect(response, isFalse);
    });

    test("should return false when the number of selected clocks is different from 1", () {
      expect(viewModel.shouldShowEditIconAndStartGameFAB, isFalse);
    });

    test("should return true when selectedClocksList is not empty", () {
      expect(viewModel.shouldShowDeleteIcon, isTrue);
    });

    test("should return true when the number of selected clocks is greater than 1", () {
      expect(viewModel.shouldShowSelectedCount, isTrue);
    });

    test("should return 2 (the number of clocks in selectedClocksList", () {
      expect(viewModel.selectedClocksCount, 2);
    });
  });

  group("Given one clock is selected", () {
    setUp(() {
      repository = MockClockRepository();
      viewModel = ClocksListViewModel(repository)..selectedClocksList.addAll([blitzClock]);
    });

    test("should return true when the number of selected clocks is equal to 1", () {
      expect(viewModel.shouldShowEditIconAndStartGameFAB, isTrue);
    });

    test("should return false when the number of selected clocks is equal to 1", () {
      expect(viewModel.shouldShowSelectedCount, isFalse);
    });

    test("should return 1 (the number of clocks in selectedClocksList", () {
      expect(viewModel.selectedClocksCount, 1);
    });
  });

  group("Given no clock is selected", () {
    setUp(() {
      repository = MockClockRepository();
      viewModel = ClocksListViewModel(repository);
    });

    test("should return false when selectedClocksList is empty", () {
      expect(viewModel.shouldShowEditIconAndStartGameFAB, isFalse);
    });

    test("should return false when selectedClocksList is empty", () {
      expect(viewModel.shouldShowDeleteIcon, isFalse);
    });

    test("should return false when selectedClocksList is empty", () {
      expect(viewModel.shouldShowSelectedCount, isFalse);
    });

    test("should return 0 when selectedClocksList is empty", () {
      expect(viewModel.selectedClocksCount, 0);
    });
  });
}
