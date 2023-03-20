import '../../data/models/clock.dart';
import '../../data/repositories/clock_repository.dart';

class NewClockViewModel {
  final ClockRepository _repository;

  NewClockViewModel(this._repository);

  bool isSameConfigForBoth = true;
  Clock clock = Clock.sec("", const TimeControl(), const TimeControl());

  void setTimePlayerOne(int hours, int minutes, int seconds) {
    clock.white = clock.white.copyWith(
      timeInSeconds: (hours * 3600) + (minutes * 60) + seconds,
    );
  }

  void setIncrementPlayerOne(int minutes, int seconds) {
    clock.white = clock.white.copyWith(
      incrementInSeconds: (minutes * 60) + seconds,
    );
  }

  void setIncrementPlayerTwo(int minutes, int seconds) {
    clock.black = clock.black.copyWith(
      incrementInSeconds: (minutes * 60) + seconds,
    );
  }

  void setTimePlayerTwo(int hours, int minutes, int seconds) {
    clock.black = clock.black.copyWith(
      timeInSeconds: (hours * 3600) + (minutes * 60) + seconds,
    );
  }

  Future<int> save() async {
    // TODO: VALIDATE
    return _repository.insertClock(clock);
  }
}
