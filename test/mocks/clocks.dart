import 'package:custom_chess_clock/data/models/clock.dart';
import 'package:custom_chess_clock/data/timing_methods_enum.dart';

final blitzClock = Clock.sec(
  id: 1,
  "Blitz",
  const TimeControl(
    timeInSeconds: 180,
    timingMethod: TimingMethodEnum.fischer,
    incrementInSeconds: 0,
  ),
  const TimeControl(
    timeInSeconds: 180,
    timingMethod: TimingMethodEnum.fischer,
    incrementInSeconds: 0,
  ),
);

final bulletClock = Clock.sec(
  id: 2,
  "Bullet",
  const TimeControl(
    timeInSeconds: 60,
    timingMethod: TimingMethodEnum.fischer,
    incrementInSeconds: 0,
  ),
  const TimeControl(
    timeInSeconds: 60,
    timingMethod: TimingMethodEnum.fischer,
    incrementInSeconds: 0,
  ),
);
final rapidClock = Clock.sec(
  id: 3,
  "Rapid",
  const TimeControl(
    timeInSeconds: 600,
    timingMethod: TimingMethodEnum.fischer,
    incrementInSeconds: 0,
  ),
  const TimeControl(
    timeInSeconds: 600,
    timingMethod: TimingMethodEnum.fischer,
    incrementInSeconds: 0,
  ),
);
