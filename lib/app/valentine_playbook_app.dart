import 'package:flutter/material.dart';

import 'package:valentine_ayomide/features/valentine/presentation/pages/valentine_book_screen.dart';

class ValentinePlaybookApp extends StatelessWidget {
  const ValentinePlaybookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Our Valentine Playbook',
      theme: ThemeData(
        fontFamily: 'Georgia',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFCC4B5C),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const ValentineBookScreen(),
    );
  }
}
