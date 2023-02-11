import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fullscreen/fullscreen.dart';

import '../../common/extensions/on_duration.dart';
import '../../data/time_control.dart';
import '../../data/timing_methods_enum.dart';
import '../clocks_list_screen.dart';
import 'main_view_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final viewModel = MainViewModel(
    const TimeControl(
      timeInSeconds: 60,
      timingMethod: TimingMethodEnum.delay,
      incrementInSeconds: 0,
    ),
    const TimeControl(
      timeInSeconds: 60,
      timingMethod: TimingMethodEnum.delay,
      incrementInSeconds: 0,
    ),
  );

  @override
  void initState() {
    super.initState();
    FullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      autofocus: true,
      onFocusChange: (_) async {
        if ((await FullScreen.isFullScreen) == false) {
          FullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
        }
      },
      child: Scaffold(
        body: ValueListenableBuilder(
          valueListenable: viewModel.gameState,
          builder: (context, state, _) {
            return Column(
              children: [
                _TimerButton(
                  color: Colors.black,
                  viewModel: viewModel,
                ),
                _OptionsBar(viewModel: viewModel),
                _TimerButton(
                  isAtBottom: true,
                  color: Colors.white,
                  viewModel: viewModel,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TimerButton extends StatelessWidget {
  final Color color;
  final bool isAtBottom;
  final MainViewModel viewModel;

  const _TimerButton({
    required this.color,
    this.isAtBottom = false,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final onColor = color == Colors.black ? Colors.white : Colors.black;
    return Expanded(
      child: InkWell(
        onTap: () => viewModel.onPressedTimerButton(isAtBottom),
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
                  child: ValueListenableBuilder(
                    valueListenable: isAtBottom && viewModel.isBottomTimerWhite
                        ? viewModel.whiteTimer
                        : viewModel.blackTimer,
                    builder: (_, value, __) {
                      return Text(
                        value.timeToString(),
                        style: textTheme.displayLarge?.copyWith(
                          color: onColor,
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ValueListenableBuilder(
                      valueListenable:
                          isAtBottom && viewModel.isBottomTimerWhite
                              ? viewModel.countMovesWhite
                              : viewModel.countMovesBlack,
                      builder: (_, value, __) {
                        return Text(
                          "Move: $value",
                          style: textTheme.labelLarge?.copyWith(
                            color: onColor,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: isAtBottom
                        ? MediaQuery.of(context).padding.bottom
                        : MediaQuery.of(context).padding.top,
                  ),
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
                            color: onColor,
                          ),
                        ),
                        const SizedBox(width: 64.0),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.color_lens_outlined,
                            size: 32,
                            color: onColor,
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
  final MainViewModel viewModel;

  const _OptionsBar({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    Widget restartButton = IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.replay,
        color: colorScheme.onPrimary,
      ),
    );

    VoidCallback onPressed;
    if (viewModel.gameState.value.isInitial) {
      onPressed = viewModel.startGame;
    } else if (viewModel.gameState.value.isPaused) {
      onPressed = viewModel.resumeGame;
    } else {
      onPressed = viewModel.pauseGame;
    }
    Widget playOrPauseButton = IconButton(
      onPressed: onPressed,
      icon: Icon(
        viewModel.gameState.value.isNotRunning
            ? Icons.play_circle_outline
            : Icons.pause_circle_outline,
        color: colorScheme.onPrimary,
      ),
    );

    Widget clocksScreenButton = IconButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const ClocksListScreen(),
          ),
        );
      },
      icon: const _CustomSettingsIconButton(),
    );

    Widget toggleVolumeButton = IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.volume_up,
        color: colorScheme.onPrimary,
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.primary,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            restartButton,
            if (viewModel.gameState.value.isNotEnded) playOrPauseButton,
            clocksScreenButton,
            toggleVolumeButton,
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
