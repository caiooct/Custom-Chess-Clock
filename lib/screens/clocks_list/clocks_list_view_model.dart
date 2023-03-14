import 'package:flutter/widgets.dart';

import '../../data/models/clock.dart';
import '../../data/repositories/clock_repository.dart';

class ClocksListViewModel extends ChangeNotifier {
  final ClockRepository _repository;

  ClocksListViewModel(this._repository);

  Future<void> deleteClock(Clock clock) async {
    await _repository.deleteClock(clock);
  }

  Future<void> insertClock(Clock clock) async {
    await _repository.insertClock(clock);
  }

  int insertSyncClock(Clock clock) {
    return _repository.insertSyncClock(clock);
  }

  Future<void> updateClock(Clock clock) async {
    await _repository.updateClock(clock);
  }

  Stream<List<Clock>> getListenableClocksList() {
    return _repository.getAllListenable();
  }
}
