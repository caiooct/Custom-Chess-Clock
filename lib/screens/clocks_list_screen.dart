import 'package:flutter/material.dart';
import 'package:fullscreen/fullscreen.dart';

import 'new_clock/new_clock_screen.dart';
import 'settings_screen.dart';

class ClocksListScreen extends StatefulWidget {
  const ClocksListScreen({Key? key}) : super(key: key);

  @override
  State<ClocksListScreen> createState() => _ClocksListScreenState();
}

class _ClocksListScreenState extends State<ClocksListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FullScreen.exitFullScreen();
    });
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
        child: Column(
          children: const [
            _ClockCard(),
          ],
        ),
      ),
    );
  }
}

class _ClockCard extends StatelessWidget {
  const _ClockCard({Key? key}) : super(key: key);

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
                "Bullet",
                style: textTheme.headlineLarge?.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
              Divider(
                thickness: 2,
                color: colorScheme.onPrimary,
                indent: 64,
                endIndent: 64,
              ),
              Text(
                "5 | 1",
                style: textTheme.headlineLarge?.copyWith(
                  color: colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
