import 'package:flutter/material.dart';

import 'palette.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: onPrimary,
    secondary: secondary,
    onSecondary: onSecondary,
    error: error,
    onError: onError,
    background: background,
    onBackground: onBackground,
    surface: surface,
    onSurface: onSurface,
    inversePrimary: inversePrimary,
    primaryContainer: primaryContainer,
  ),
  dialogTheme: DialogTheme(
    backgroundColor: primaryContainer,
    titleTextStyle: ThemeData.fallback(useMaterial3: true)
        .textTheme
        .headlineSmall
        ?.copyWith(color: onPrimary, fontSize: 24),
    contentTextStyle: ThemeData.fallback(useMaterial3: true)
        .textTheme
        .bodyMedium
        ?.copyWith(color: onPrimary),
  ),
);
