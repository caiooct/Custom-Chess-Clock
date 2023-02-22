extension OnDuration on Duration {
  String timeToString() {
    return toString().substring(inHours > 0 ? 0 : 2, 9);
  }

  String timeToAdaptiveString() {
    late int startIndex;
    if (inHours > 0) {
      startIndex = 0;
    } else if (inSeconds > 59) {
      startIndex = 2;
    } else {
      startIndex = 5;
    }
    return toString().substring(startIndex, 7);
  }
}
