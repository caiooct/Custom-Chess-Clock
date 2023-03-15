enum GameState {
  initial,
  started,
  paused,
  running,
  ended;

  bool get isInitial => this == initial;

  bool get isStarted => this == started;

  bool get isPaused => this == paused;

  bool get isRunning => this == running;

  bool get isEnded => this == ended;

  bool get isNotPaused => this != paused;

  bool get isNotRunning => this != running;

  bool get isNotEnded => this != ended;
}
