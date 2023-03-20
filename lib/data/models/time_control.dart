part of 'clock.dart';

@embedded
class TimeControl {
  final int timeInSeconds;
  @enumerated
  final TimingMethodEnum timingMethod;
  final int incrementInSeconds;

  const TimeControl({
    this.timeInSeconds = 0,
    this.timingMethod = TimingMethodEnum.fischer,
    this.incrementInSeconds = 0,
  });

  TimeControl copyWith({
    int? timeInSeconds,
    TimingMethodEnum? timingMethod,
    int? incrementInSeconds,
  }) {
    return TimeControl(
      timeInSeconds: timeInSeconds ?? this.timeInSeconds,
      timingMethod: timingMethod ?? this.timingMethod,
      incrementInSeconds: incrementInSeconds ?? this.incrementInSeconds,
    );
  }

  @override
  String toString() {
    return 'TimeControl{timeInSeconds: $timeInSeconds, timingMethod: $timingMethod, incrementInSeconds: $incrementInSeconds}';
  }
}
