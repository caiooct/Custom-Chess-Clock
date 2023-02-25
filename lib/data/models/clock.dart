import '../../common/extensions/on_duration.dart';
import '../time_control.dart';

class Clock {
  String name;
  TimeControl white, black;

  Clock({
    required this.name,
    required this.white,
    required this.black,
  });

  String toClockLabel() {
    String result = "";

    result = Duration(seconds: white.timeInSeconds).timeToClockLabel();
    if (white.incrementInSeconds > 0) {
      result += "\n+${Duration(seconds: white.incrementInSeconds).timeToClockLabel()}";
    }
    return result;
  }
}
