import 'package:flutter/material.dart';

import 'package:valentine_ayomide/features/valentine/presentation/pages/valentine_book_screen.dart';

class ValentinePlaybookApp extends StatefulWidget {
  const ValentinePlaybookApp({super.key});

  @override
  State<ValentinePlaybookApp> createState() => _ValentinePlaybookAppState();
}

class _ValentinePlaybookAppState extends State<ValentinePlaybookApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleThemeMode() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark
          ? ThemeMode.light
          : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Our Valentine Playbook',
      themeMode: _themeMode,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      home: ValentineBookScreen(onToggleThemeMode: _toggleThemeMode),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFFCC4B5C),
      brightness: brightness,
    );

    final baseTheme = ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      brightness: brightness,
    );

    final themedText = _buildTypography(baseTheme.textTheme);

    return baseTheme.copyWith(
      textTheme: themedText,
      primaryTextTheme: themedText,
    );
  }

  TextTheme _buildTypography(TextTheme base) {
    const headingStyle = TextStyle(
      fontFamily: 'Playfair Display',
      height: 1.2,
      fontStyle: FontStyle.italic,
    );
    const bodyStyle = TextStyle(fontFamily: 'Cormorant Garamond', height: 1.45);

    return base.copyWith(
      displayLarge: base.displayLarge?.merge(headingStyle),
      displayMedium: base.displayMedium?.merge(headingStyle),
      displaySmall: base.displaySmall?.merge(headingStyle),
      headlineLarge: base.headlineLarge?.merge(headingStyle),
      headlineMedium: base.headlineMedium?.merge(headingStyle),
      headlineSmall: base.headlineSmall?.merge(headingStyle),
      titleLarge: base.titleLarge?.merge(headingStyle),
      titleMedium: base.titleMedium?.merge(headingStyle),
      titleSmall: base.titleSmall?.merge(headingStyle),
      bodyLarge: base.bodyLarge?.merge(bodyStyle),
      bodyMedium: base.bodyMedium?.merge(bodyStyle),
      bodySmall: base.bodySmall?.merge(bodyStyle),
      labelLarge: base.labelLarge?.merge(bodyStyle),
      labelMedium: base.labelMedium?.merge(bodyStyle),
      labelSmall: base.labelSmall?.merge(bodyStyle),
    );
  }
}
