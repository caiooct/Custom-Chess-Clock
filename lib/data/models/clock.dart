import 'package:isar/isar.dart';

import '../../common/extensions/on_duration.dart';
import '../timing_methods_enum.dart';

part 'clock.g.dart';

part 'time_control.dart';

@collection
class Clock {
  Id id = Isar.autoIncrement;
  late String name;
  late TimeControl white;
  late TimeControl black;

  Clock();

  Clock.sec(this.name, this.white, this.black);

  String toClockLabel() {
    String result = "";
    result = Duration(seconds: white.timeInSeconds).timeToClockLabel();
    if (white.incrementInSeconds > 0) {
      result +=
          "\n+${Duration(seconds: white.incrementInSeconds).timeToClockLabel()}";
    }
    return result;
  }

  @override
  String toString() {
    return 'Clock{name: $name, white: $white, black: $black}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Clock &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => name.hashCode;
}
