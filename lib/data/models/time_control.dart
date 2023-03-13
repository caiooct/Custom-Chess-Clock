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
}
