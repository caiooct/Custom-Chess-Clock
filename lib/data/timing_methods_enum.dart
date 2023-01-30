enum TimingMethodEnum {
  delay("Delay", ""),
  bronstein("Bronstein", ""),
  fischer("Fischer", "");

  const TimingMethodEnum(this.title, this.description);

  final String title, description;
}
