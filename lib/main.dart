import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ui/main/main_screen.dart';
import 'theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(
    MaterialApp(
      title: 'Custom Chess Clock',
      theme: lightTheme,
      home: MainScreen(),
    ),
  );
}
