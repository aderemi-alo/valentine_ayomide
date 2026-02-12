import 'package:flutter/material.dart';

import '../book_page.dart';

class StoryNotePage extends StatelessWidget {
  const StoryNotePage({super.key, required this.heading, required this.body});

  final String heading;
  final String body;

  @override
  Widget build(BuildContext context) {
    return BookPage(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: const Color(0xFF4A2130),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  body,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.8,
                    color: const Color(0xFF623B45),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Love note space',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                letterSpacing: 1.2,
                color: const Color(0xFFB14761),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
