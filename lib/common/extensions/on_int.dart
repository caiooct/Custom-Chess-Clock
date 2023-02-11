extension OnInt on int {
  Duration get s  {
    return Duration(seconds: this);
  }
  Duration get ms {
    return Duration(milliseconds: this);
  }
}
