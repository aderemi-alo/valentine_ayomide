import 'package:flutter/material.dart';

import '../book_page.dart';

class StoryNotePage extends StatelessWidget {
  const StoryNotePage({
    super.key,
    required this.heading,
    required this.body,
    required this.loveNotePlaceholder,
  });

  final String heading;
  final String body;
  final String loveNotePlaceholder;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BookPage(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: colorScheme.onSurface,
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
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              loveNotePlaceholder,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                letterSpacing: 1.2,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
