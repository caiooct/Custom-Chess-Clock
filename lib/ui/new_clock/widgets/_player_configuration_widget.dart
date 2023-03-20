part of '../new_clock_screen.dart';

class _PlayerConfigurationWidget extends StatefulWidget {
  const _PlayerConfigurationWidget({
    Key? key,
    required this.isPlayerOne,
    required this.type,
    required this.viewModel,
  }) : super(key: key);

  final bool isPlayerOne;
  final ClockTypeEnum type;
  final NewClockViewModel viewModel;

  @override
  State<_PlayerConfigurationWidget> createState() =>
      _PlayerConfigurationWidgetState();
}

class _PlayerConfigurationWidgetState
    extends State<_PlayerConfigurationWidget> {
  late Clock clock;
  final TextEditingController hourTxtController = TextEditingController();
  final TextEditingController minutesTxtController = TextEditingController();
  final TextEditingController secondsTxtController = TextEditingController();
  final TextEditingController incrementMinutesTxtController =
      TextEditingController();
  final TextEditingController incrementSecondsTxtController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    clock = widget.viewModel.clock;
    _retrieveValues();
    _setUpListeners();
  }

  void _retrieveValues() {
    if (widget.isPlayerOne && clock.white.timeInSeconds > 0) {
      _setValuesForPlayer(clock.white);
    } else if (widget.isPlayerOne == false && clock.black.timeInSeconds > 0) {
      _setValuesForPlayer(clock.black);
    }
  }

  void _setValuesForPlayer(TimeControl timeControl) {
    hourTxtController.text = timeControl.timeInSeconds.s.hours == 0
        ? ''
        : timeControl.timeInSeconds.s.hours.toString();
    minutesTxtController.text = timeControl.timeInSeconds.s.minutes == 0
        ? ''
        : timeControl.timeInSeconds.s.minutes.toString();
    secondsTxtController.text = timeControl.timeInSeconds.s.seconds == 0
        ? ''
        : timeControl.timeInSeconds.s.seconds.toString();
    incrementMinutesTxtController.text =
        timeControl.incrementInSeconds.s.minutes == 0
            ? ''
            : timeControl.incrementInSeconds.s.minutes.toString();
    incrementSecondsTxtController.text =
        timeControl.incrementInSeconds.s.seconds == 0
            ? ''
            : timeControl.incrementInSeconds.s.seconds.toString();
  }

  void _setUpListeners() {
    listener() {
      int hours = int.tryParse(hourTxtController.text) ?? 0;
      int minutes = int.tryParse(minutesTxtController.text) ?? 0;
      int seconds = int.tryParse(secondsTxtController.text) ?? 0;
      int incrementMinutes =
          int.tryParse(incrementMinutesTxtController.text) ?? 0;
      int incrementSeconds =
          int.tryParse(incrementSecondsTxtController.text) ?? 0;

      if (widget.viewModel.isSameConfigForBoth) {
        widget.viewModel
          ..setTimePlayerOne(hours, minutes, seconds)
          ..setIncrementPlayerOne(incrementMinutes, incrementSeconds)
          ..setTimePlayerTwo(hours, minutes, seconds)
          ..setIncrementPlayerTwo(incrementMinutes, incrementSeconds);
      } else {
        if (widget.isPlayerOne) {
          widget.viewModel
            ..setTimePlayerOne(hours, minutes, seconds)
            ..setIncrementPlayerOne(incrementMinutes, incrementSeconds);
        } else {
          widget.viewModel
            ..setTimePlayerTwo(hours, minutes, seconds)
            ..setIncrementPlayerTwo(incrementMinutes, incrementSeconds);
        }
      }
    }

    hourTxtController.addListener(listener);
    minutesTxtController.addListener(listener);
    secondsTxtController.addListener(listener);
    incrementMinutesTxtController.addListener(listener);
    incrementSecondsTxtController.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.type == ClockTypeEnum.simple) ...[
              Row(
                children: [
                  Text("Time", style: textTheme.titleMedium),
                  const Spacer(),
                  Row(
                    children: [
                      _TimerInputWidget(hourTxtController),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                        child: Text(":"),
                      ),
                      _TimerInputWidget(minutesTxtController),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                        child: Text(":"),
                      ),
                      _TimerInputWidget(secondsTxtController),
                    ],
                  ),
                ],
              ),
            ] else ...[
              Text("Stages", style: textTheme.titleMedium),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove, color: colorScheme.error),
                    onPressed: () {},
                  ),
                  Text("1", style: textTheme.bodyMedium),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _TimerInputWidget(TextEditingController()),
                        Text("moves in", style: textTheme.bodyMedium),
                        Row(
                          children: [
                            _TimerInputWidget(TextEditingController()),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Text(":"),
                            ),
                            _TimerInputWidget(TextEditingController()),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Text(":"),
                            ),
                            _TimerInputWidget(TextEditingController()),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove, color: colorScheme.error),
                    onPressed: () {},
                  ),
                  Text("2", style: textTheme.bodyMedium),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Text("game in", style: textTheme.bodyMedium),
                        Row(
                          children: [
                            _TimerInputWidget(TextEditingController()),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Text(":"),
                            ),
                            _TimerInputWidget(TextEditingController()),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Text(":"),
                            ),
                            _TimerInputWidget(TextEditingController()),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.green),
                    onPressed: () {},
                  ),
                  Text("add stage", style: textTheme.bodyMedium),
                ],
              ),
            ],
            const SizedBox(height: 24),
            Text("Timing method", style: textTheme.titleMedium),
            const SizedBox(height: 8),
            Center(
              child: SegmentedButton<TimingMethodEnum>(
                segments: const [
                  ButtonSegment(
                    value: TimingMethodEnum.delay,
                    label: Text("Delay"),
                  ),
                  ButtonSegment(
                    value: TimingMethodEnum.bronstein,
                    label: Text("Bronstein"),
                  ),
                  ButtonSegment(
                    value: TimingMethodEnum.fischer,
                    label: Text("Fischer"),
                  ),
                ],
                selected: {
                  widget.isPlayerOne
                      ? clock.white.timingMethod
                      : clock.black.timingMethod
                },
                onSelectionChanged: _onSelectTimingMethod,
                showSelectedIcon: false,
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                  ),
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => states.contains(MaterialState.selected)
                        ? colorScheme.primary
                        : colorScheme.background,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                (widget.isPlayerOne
                        ? clock.white.timingMethod
                        : clock.black.timingMethod)
                    .description,
                style: textTheme.labelSmall,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text("Increment", style: textTheme.titleMedium),
                const Spacer(),
                Row(
                  children: [
                    _TimerInputWidget(incrementMinutesTxtController),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Text(":"),
                    ),
                    _TimerInputWidget(incrementSecondsTxtController),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  "Same configuration for both players",
                  style: textTheme.bodySmall,
                ),
                const Spacer(),
                Switch(
                  value: widget.viewModel.isSameConfigForBoth,
                  onChanged: (newValue) {
                    setState(() {
                      widget.viewModel.isSameConfigForBoth = newValue;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                  ),
                  onPressed: () async {
                    var response = await widget.viewModel.save();
                    if (response > 0 && context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    "Save",
                    style: textTheme.labelLarge?.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSelectTimingMethod(Set<TimingMethodEnum> selected) {
    setState(() {
      if (widget.viewModel.isSameConfigForBoth) {
        clock
          ..white = clock.white.copyWith(timingMethod: selected.first)
          ..black = clock.black.copyWith(timingMethod: selected.first);
      } else {
        widget.isPlayerOne
            ? clock.white = clock.white.copyWith(timingMethod: selected.first)
            : clock.black = clock.black.copyWith(timingMethod: selected.first);
      }
    });
  }
}
