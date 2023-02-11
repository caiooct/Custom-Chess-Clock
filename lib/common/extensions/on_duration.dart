extension OnDuration  on Duration {
  String timeToString() {
    return toString().substring(inHours > 0 ? 0 : 2, 7);
  }
}