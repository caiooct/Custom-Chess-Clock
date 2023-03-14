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

  String timeToClockLabel() {
    String result = "";
    var copy = this;
    if (copy.inHours > 0) {
      result += "${copy.inHours}h";
      copy -= Duration(hours: copy.inHours);
    }
    if (copy.inMinutes > 0) {
      result += "${copy.inMinutes}m";
      copy -= Duration(minutes: copy.inMinutes);
    }
    if (copy.inSeconds > 0) {
      result += "${copy.inSeconds}s";
      copy -= Duration(seconds: copy.inSeconds);
    }
    return result;
  }
}
