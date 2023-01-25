import 'package:custom_chess_clock/splash_screen.dart';
import 'package:custom_chess_clock/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Custom Chess Clock',
      theme: lightTheme,
      home: const SplashScreen(),
    ),
  );
}
