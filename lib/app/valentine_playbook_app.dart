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
      theme: ThemeData(
        fontFamily: 'Playfair',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFCC4B5C),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        fontFamily: 'Playfair',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFCC4B5C),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: ValentineBookScreen(onToggleThemeMode: _toggleThemeMode),
    );
  }
}
