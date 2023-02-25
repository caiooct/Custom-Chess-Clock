import '../timing_methods_enum.dart';

class TimeControl {
  final int timeInSeconds;
  final TimingMethodEnum timingMethod;
  final int incrementInSeconds;

  const TimeControl({
    required this.timeInSeconds,
    required this.timingMethod,
    required this.incrementInSeconds,
  });
}
