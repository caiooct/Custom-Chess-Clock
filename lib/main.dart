import 'package:custom_chess_clock/main_screen.dart';
import 'package:custom_chess_clock/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Custom Chess Clock',
      theme: lightTheme,
      home: const MainScreen(),
    ),
  );
}
