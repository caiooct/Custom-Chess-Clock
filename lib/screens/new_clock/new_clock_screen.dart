import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part './widgets/_timer_input_widget.dart';

class NewClockScreen extends StatefulWidget {
  const NewClockScreen({Key? key}) : super(key: key);

  @override
  State<NewClockScreen> createState() => _NewClockScreenState();
}

class _NewClockScreenState extends State<NewClockScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  String selection = "1";
  String selectionTMethod = "1";

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
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: "1", label: Text("Simple")),
              ButtonSegment(value: "2", label: Text("Advanced"))
            ],
            selected: {selection},
            onSelectionChanged: (newSelection) {
              setState(() {
                selection = newSelection.first;
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
                children: const [
                  _PlayerConfigurationView(),
                  _PlayerConfigurationView(),
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
  const _PlayerConfigurationView({Key? key}) : super(key: key);

  @override
  State<_PlayerConfigurationView> createState() =>
      _PlayerConfigurationViewState();
}

class _PlayerConfigurationViewState extends State<_PlayerConfigurationView> {
  String selectionTMethod = "1";

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Time", style: textTheme.titleMedium),
        const SizedBox(height: 8),
        Row(
          children: [
            const Text("Player 1"),
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
        const SizedBox(height: 36),
        Text("Timing method", style: textTheme.titleMedium),
        const SizedBox(height: 8),
        Center(
          child: SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: "1", label: Text("Delay")),
              ButtonSegment(value: "2", label: Text("Bronstein")),
              ButtonSegment(value: "3", label: Text("Fischer")),
            ],
            selected: {selectionTMethod},
            onSelectionChanged: (newSelection) {
              setState(() {
                selectionTMethod = newSelection.first;
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
        Text(
          "The player's clock starts after the delay period",
          style: textTheme.labelSmall?.copyWith(
            color: colorScheme.onPrimary,
          ),
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
        const Spacer(),
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
    );
  }
}
