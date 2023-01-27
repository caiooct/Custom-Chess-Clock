import 'package:flutter/material.dart';

import 'screens/main_screen.dart';
import 'theme/theme.dart';

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
