import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: BackButton(color: colorScheme.onPrimary),
        title: Text(
          "Settings",
          style: textTheme.titleLarge?.copyWith(color: colorScheme.onPrimary),
        ),
        backgroundColor: colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Preferences", style: textTheme.titleMedium),
                const _ItemWithSwitch("Count moves"),
                const _ItemWithSwitch("Sounds"),
                const _ItemWithSwitch("Vibrate when game is over"),
                const _ItemWithSwitch("Change time color at low time"),
                const _ItemWithSwitch("Error sound when it's not your turn"),
                const SizedBox(height: 32),
                Text("Theme", style: textTheme.titleMedium),
                Row(
                  children: [
                    Text("Player 1", style: textTheme.bodySmall),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const CircleAvatar(
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Player 2", style: textTheme.bodySmall),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const CircleAvatar(
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text("Tap size height", style: textTheme.bodySmall),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text("50%", style: textTheme.bodySmall),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text("About", style: textTheme.titleMedium),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text("Rate this app", style: textTheme.bodySmall),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text("Send feedback", style: textTheme.bodySmall),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text("Privacy policy", style: textTheme.bodySmall),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text("Support this app ❤️", style: textTheme.bodySmall),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ItemWithSwitch extends StatelessWidget {
  const _ItemWithSwitch(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Text(label, style: textTheme.bodySmall),
        const Spacer(),
        Switch(value: true, onChanged: (onChanged) {}),
      ],
    );
  }
}
