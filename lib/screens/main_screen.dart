import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fullscreen/fullscreen.dart';

import 'clock_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    FullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          const _TimerButton(color: Colors.red),
          _OptionsBar(),
          const _TimerButton(isAtBottom: true, color: Colors.blue),
        ],
      ),
    );
  }
}

class _TimerButton extends StatelessWidget {
  final Color color;
  final bool isAtBottom;

  const _TimerButton({
    required this.color,
    this.isAtBottom = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Transform.rotate(
          angle: isAtBottom ? 0 : pi,
          child: Ink(
            width: double.infinity,
            height: double.infinity,
            color: color,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "5:00",
                    style:
                        textTheme.displayLarge?.copyWith(color: Colors.white),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Move: 0",
                      style:
                          textTheme.labelLarge?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.timer_outlined,
                            size: 32,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                        const SizedBox(width: 64.0),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.color_lens_outlined,
                            size: 32,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OptionsBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.primary,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.replay,
                color: colorScheme.onPrimary,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.play_circle_outline,
                color: colorScheme.onPrimary,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ClockScreen()),
                );
              },
              icon: const _CustomSettingsIconButton(),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.volume_up,
                color: colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomSettingsIconButton extends StatelessWidget {
  const _CustomSettingsIconButton();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Icon(
          Icons.timer_outlined,
          color: colorScheme.onPrimary,
        ),
        Positioned(
          right: -1,
          bottom: -1,
          child: DecoratedBox(
            decoration: BoxDecoration(color: colorScheme.primary),
            child: Center(
              child: Icon(
                Icons.settings,
                size: 12,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
