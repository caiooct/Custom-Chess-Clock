enum TimingMethodEnum {
  delay("Delay", ""),
  bronstein("Bronstein", ""),
  fischer("Fischer", "");

  const TimingMethodEnum(this.title, this.description);

  final String title, description;

  bool get isDelay => this == delay;

  bool get isBronstein => this == bronstein;

  bool get isFischer => this == fischer;
}
