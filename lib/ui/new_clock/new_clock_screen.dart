import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../common/extensions/on_duration.dart';

import '../../common/extensions/on_int.dart';
import '../../common/services/isar_service.dart';
import '../../data/data_sources/clock_local_data_source.dart';
import '../../data/enums/timing_methods_enum.dart';
import '../../data/models/clock.dart';
import '../../data/repositories/clock_repository.dart';
import 'new_clock_view_model.dart';

part './widgets/_timer_input_widget.dart';

part './widgets/_player_configuration_widget.dart';

class NewClockScreen extends StatefulWidget {
  const NewClockScreen({Key? key}) : super(key: key);

  @override
  State<NewClockScreen> createState() => _NewClockScreenState();
}

class _NewClockScreenState extends State<NewClockScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  final TextEditingController _nameTextController = TextEditingController();
  final NewClockViewModel _viewModel = NewClockViewModel(
    ClockRepository(ClockLocalDataSource(IsarService.instance)),
  );

  ClockTypeEnum clockType = ClockTypeEnum.simple;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    _nameTextController.addListener(() {
      _viewModel.clock.name = _nameTextController.text;
    });
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: TextField(
              controller: _nameTextController,
              decoration: const InputDecoration(
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
                  _PlayerConfigurationWidget(
                    type: clockType,
                    viewModel: _viewModel,
                    isPlayerOne: true,
                  ),
                  _PlayerConfigurationWidget(
                    type: clockType,
                    viewModel: _viewModel,
                    isPlayerOne: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum ClockTypeEnum { simple, advanced }
