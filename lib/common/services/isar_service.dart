import 'package:isar/isar.dart';

import '../../data/models/clock.dart';

class IsarService {
  static Isar? _instance;

  IsarService._();

  static Isar get instance {
    _instance ??= Isar.openSync([ClockSchema]);
    return _instance!;
  }

  static Future<void> closeInstance() async {
    await _instance?.close(deleteFromDisk: true);
    _instance = null;
  }
}
