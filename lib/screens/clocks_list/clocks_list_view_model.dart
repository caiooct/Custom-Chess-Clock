import 'package:flutter/widgets.dart';

import '../../data/models/clock.dart';
import '../../data/repositories/clock_repository.dart';

class ClocksListViewModel extends ChangeNotifier {
  final ClockRepository _repository;

  ClocksListViewModel(this._repository);

  @visibleForTesting
  final List<Clock> selectedClocksList = <Clock>[];

  bool get shouldShowEditIconAndStartGameFAB => selectedClocksList.length == 1;

  bool get shouldShowDeleteIcon => selectedClocksList.isNotEmpty;

  bool get shouldShowSelectedCount => selectedClocksList.length > 1;

  int get selectedClocksCount => selectedClocksList.length;

  Future<void> deleteClock(Clock clock) async {
    await _repository.deleteClock(clock);
  }

  Stream<List<Clock>> getListenableClocksList() {
    return _repository.getAllListenable();
  }

  Future<void> onTapDelete() async {
    await _repository.deleteClocks(selectedClocksList);
    clearSelectedClocksList();
  }

  void clearSelectedClocksList() {
    selectedClocksList.clear();
  }

  void onTapClockCard(Clock clock) {
    if (isSelected(clock)) {
      selectedClocksList.remove(clock);
    } else {
      selectedClocksList.add(clock);
    }
  }

  bool isSelected(Clock clock) => selectedClocksList.contains(clock);
}
