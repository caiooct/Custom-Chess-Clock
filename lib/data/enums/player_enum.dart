enum PlayerEnum {
  none,
  white,
  black;

  bool get isNone => this == none;

  bool get isWhite => this == white;

  bool get isBlack => this == black;
}
