import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../common/services/isar_service.dart';
import '../../data/data_sources/clock_local_data_source.dart';
import '../../data/models/clock.dart';
import '../../data/repositories/clock_repository.dart';
import '../new_clock/new_clock_screen.dart';
import '../settings_screen.dart';
import 'clocks_list_view_model.dart';

class ClocksListScreen extends StatefulWidget {
  const ClocksListScreen({Key? key}) : super(key: key);

  @override
  State<ClocksListScreen> createState() => _ClocksListScreenState();
}

class _ClocksListScreenState extends State<ClocksListScreen> {
  final viewModel = ClocksListViewModel(
    ClockRepository(ClockLocalDataSource(IsarService.instance)),
  );

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dialogTheme = Theme.of(context).dialogTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: BackButton(
          color: colorScheme.onPrimary,
          onPressed: () {
            if (viewModel.shouldShowSelectedCount) {
              viewModel.clearSelectedClocksList();
            } else {
              Navigator.of(context).pop();
            }
            setState(() {});
          },
        ),
        title: Text(
          viewModel.shouldShowSelectedCount
              ? "${viewModel.selectedClocksCount}"
              : "Clocks",
          style: textTheme.titleLarge?.copyWith(color: colorScheme.onPrimary),
        ),
        backgroundColor: colorScheme.primary,
        actions: [
          if (viewModel.shouldShowEditIconAndStartGameFAB)
            IconButton(
              onPressed: () {
                // TODO: IMPLEMENT
              },
              icon: Icon(
                Icons.edit,
                color: colorScheme.onPrimary,
              ),
            ),
          if (viewModel.shouldShowDeleteIcon)
            IconButton(
              onPressed: () async {
                bool response = await showDialog<bool>(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: Text(
                            Intl.plural(
                              viewModel.selectedClocksCount,
                              other:
                                  "Delete ${viewModel.selectedClocksCount} selected clocks?",
                              one: "Delete this clock?",
                            ),
                            style: dialogTheme.titleTextStyle,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: Text(
                                "No",
                                style: textTheme.labelLarge
                                    ?.copyWith(color: colorScheme.onPrimary),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: Text(
                                "Yes",
                                style: textTheme.labelLarge
                                    ?.copyWith(color: colorScheme.onPrimary),
                              ),
                            ),
                          ],
                        );
                      },
                    ) ??
                    false;
                if (response) {
                  await viewModel.onTapDelete();
                  setState(() {});
                }
              },
              icon: Icon(
                Icons.delete_outline,
                color: colorScheme.onPrimary,
              ),
            ),
          IconButton(
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
            icon: Icon(
              Icons.settings,
              color: colorScheme.onPrimary,
            ),
          ),
        ],
      ),
      floatingActionButton: viewModel.shouldShowEditIconAndStartGameFAB
          ? FloatingActionButton.extended(
              backgroundColor: colorScheme.primaryContainer,
              label: const Text("Start Game"),
              onPressed: () {
                // TODO: IMPLEMENT
              },
              tooltip: 'Start Game',
              icon: const Icon(Icons.play_arrow_outlined),
            )
          : FloatingActionButton.extended(
              backgroundColor: colorScheme.primaryContainer,
              label: const Text("New Clock"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const NewClockScreen()),
                );
              },
              tooltip: 'New Clock',
              icon: const Icon(Icons.add),
            ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<List<Clock>>(
          stream: viewModel.getListenableClocksList(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return Wrap(
                spacing: 16.0,
                children: snapshot.data!
                    .map(
                      (clock) => _ClockCard(
                        clock: clock,
                        isSelected: viewModel.isSelected(clock),
                        onTap: () {
                          setState(() {
                            viewModel.onTapClockCard(clock);
                          });
                        },
                      ),
                    )
                    .toList(),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class _ClockCard extends StatelessWidget {
  const _ClockCard({
    required this.clock,
    required this.isSelected,
    required this.onTap,
  });

  final Clock clock;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      key: Key("ClockCard${clock.id}"),
      width: 168,
      height: 168,
      child: Card(
        color: isSelected ? colorScheme.inversePrimary : colorScheme.primary,
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                clock.name,
                style: textTheme.headlineLarge?.copyWith(
                  color: isSelected
                      ? colorScheme.primaryContainer
                      : colorScheme.onPrimary,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Divider(
                thickness: 2,
                color: isSelected
                    ? colorScheme.primaryContainer
                    : colorScheme.onPrimary,
                indent: 64,
                endIndent: 64,
              ),
              Text(
                clock.toClockLabel(),
                style: textTheme.headlineMedium?.copyWith(
                  color: isSelected
                      ? colorScheme.primaryContainer
                      : colorScheme.onPrimary,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
