import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/timing_methods_enum.dart';

part './widgets/_timer_input_widget.dart';

class NewClockScreen extends StatefulWidget {
  const NewClockScreen({Key? key}) : super(key: key);

  @override
  State<NewClockScreen> createState() => _NewClockScreenState();
}

class _NewClockScreenState extends State<NewClockScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  ClockTypeEnum clockType = ClockTypeEnum.simple;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: BackButton(color: colorScheme.onPrimary),
        title: Text(
          "New clock",
          style: textTheme.titleLarge?.copyWith(color: colorScheme.onPrimary),
        ),
        backgroundColor: colorScheme.primary,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: TextField(
              decoration: InputDecoration(
                label: Text("Name"),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SegmentedButton<ClockTypeEnum>(
            segments: const [
              ButtonSegment(
                value: ClockTypeEnum.simple,
                label: Text("Simple"),
              ),
              ButtonSegment(
                value: ClockTypeEnum.advanced,
                label: Text("Advanced"),
              )
            ],
            selected: {clockType},
            onSelectionChanged: (newSelection) {
              setState(() {
                clockType = newSelection.first;
              });
            },
            showSelectedIcon: false,
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              ),
              backgroundColor: MaterialStateColor.resolveWith(
                (states) => states.contains(MaterialState.selected)
                    ? colorScheme.primary
                    : colorScheme.background,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            controller: tabController,
            tabs: const [
              Text("Player 1"),
              Text("Player 2"),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TabBarView(
                controller: tabController,
                children: [
                  _PlayerConfigurationView(type: clockType),
                  _PlayerConfigurationView(type: clockType),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayerConfigurationView extends StatefulWidget {
  const _PlayerConfigurationView({Key? key, required this.type})
      : super(key: key);

  final ClockTypeEnum type;

  @override
  State<_PlayerConfigurationView> createState() =>
      _PlayerConfigurationViewState();
}

class _PlayerConfigurationViewState extends State<_PlayerConfigurationView> {
  TimingMethodEnum timingMethod = TimingMethodEnum.delay;

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
                    children: const [
                      _TimerInputWidget(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                        child: Text(":"),
                      ),
                      _TimerInputWidget(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                        child: Text(":"),
                      ),
                      _TimerInputWidget(),
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
                        const _TimerInputWidget(),
                        Text("moves in", style: textTheme.bodyMedium),
                        Row(
                          children: const [
                            _TimerInputWidget(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Text(":"),
                            ),
                            _TimerInputWidget(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Text(":"),
                            ),
                            _TimerInputWidget(),
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
                          children: const [
                            _TimerInputWidget(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Text(":"),
                            ),
                            _TimerInputWidget(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Text(":"),
                            ),
                            _TimerInputWidget(),
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
                      value: TimingMethodEnum.delay, label: Text("Delay")),
                  ButtonSegment(
                      value: TimingMethodEnum.bronstein,
                      label: Text("Bronstein")),
                  ButtonSegment(
                      value: TimingMethodEnum.fischer, label: Text("Fischer")),
                ],
                selected: {timingMethod},
                onSelectionChanged: (newSelection) {
                  setState(() {
                    timingMethod = newSelection.first;
                  });
                },
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
              child:
                  Text(timingMethod.description, style: textTheme.labelSmall),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text("Increment", style: textTheme.titleMedium),
                const Spacer(),
                Row(
                  children: const [
                    _TimerInputWidget(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Text(":"),
                    ),
                    _TimerInputWidget(),
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
                Switch(value: true, onChanged: (_) {}),
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
                  onPressed: () {},
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
}

enum ClockTypeEnum { simple, advanced }
