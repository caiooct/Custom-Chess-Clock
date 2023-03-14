import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: BackButton(color: colorScheme.onPrimary),
        title: Text(
          "Clocks",
          style: textTheme.titleLarge?.copyWith(color: colorScheme.onPrimary),
        ),
        backgroundColor: colorScheme.primary,
        actions: [
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
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.delete_outline,
              color: colorScheme.onPrimary,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.edit,
              color: colorScheme.onPrimary,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
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
                    .map((clock) => _ClockCard(clock: clock))
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
  const _ClockCard({required this.clock});

  final Clock clock;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: 168,
      height: 168,
      child: Card(
        color: colorScheme.primary,
        child: InkWell(
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                clock.name,
                style: textTheme.headlineLarge?.copyWith(
                  color: colorScheme.onPrimary,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Divider(
                thickness: 2,
                color: colorScheme.onPrimary,
                indent: 64,
                endIndent: 64,
              ),
              Text(
                clock.toClockLabel(),
                style: textTheme.headlineMedium?.copyWith(
                  color: colorScheme.onPrimary,
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
