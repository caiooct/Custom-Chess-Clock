import 'package:isar/isar.dart';

import '../models/clock.dart';

abstract class IClockDataSource {
  Future<List<Clock>> getAll();

  Future<void> update(Clock clock);

  Future<void> delete(Clock clock);

  Future<void> deleteAll(List<Clock> clocks);

  Future<int> insert(Clock clock);

  int insertSync(Clock clock);

  Stream<List<Clock>> getAllListenable();
}

class ClockLocalDataSource implements IClockDataSource {
  late Isar isar;

  ClockLocalDataSource(this.isar);

  @override
  Future<List<Clock>> getAll() async {
    final collection = isar.clocks;
    return collection.where().findAll();
  }

  @override
  Future<void> delete(Clock clock) async {
    final collection = isar.clocks;
    collection.isar.writeTxn(() async {
      await collection.delete(clock.id);
    });
  }

  @override
  Future<void> deleteAll(List<Clock> clocks) async {
    final collection = isar.clocks;
    collection.isar.writeTxn(() async {
      await collection.deleteAll(clocks.map((e) => e.id).toList());
    });
  }

  @override
  Future<int> insert(Clock clock) async {
    final collection = isar.clocks;
    return isar.writeTxn(() => collection.put(clock));
  }

  @override
  int insertSync(Clock clock) {
    final collection = isar.clocks;
    return isar.writeTxnSync(() => collection.putSync(clock));
  }

  @override
  Future<void> update(Clock clock) async {
    final collection = isar.clocks;
    isar.writeTxn(() async {
      await collection.put(clock);
    });
  }

  @override
  Stream<List<Clock>> getAllListenable() async* {
    final collection = isar.clocks;
    await for (final results
        in collection.where().build().watch(fireImmediately: true)) {
      yield results;
    }
  }
}
