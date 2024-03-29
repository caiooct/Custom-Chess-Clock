import '../data_sources/clock_local_data_source.dart';
import '../models/clock.dart';

class ClockRepository {
  final IClockDataSource _dataSource;

  ClockRepository(this._dataSource);

  Future<List<Clock>> getClocks() => _dataSource.getAll();

  Future<void> deleteClock(Clock clock) async {
    await _dataSource.delete(clock);
  }

  Future<int> insertClock(Clock clock) async {
    return _dataSource.insert(clock);
  }

  int insertSyncClock(Clock clock)  {
    return _dataSource.insertSync(clock);
  }

  Future<void> updateClock(Clock clock) async {
    await _dataSource.update(clock);
  }

  Stream<List<Clock>> getAllListenable() {
    return _dataSource.getAllListenable();
  }

  Future<void> deleteClocks(List<Clock> clocks) {
    return _dataSource.deleteAll(clocks);
  }
}
