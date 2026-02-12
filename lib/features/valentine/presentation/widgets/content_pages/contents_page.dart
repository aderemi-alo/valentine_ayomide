import 'package:flutter/material.dart';

import '../../../domain/story_section.dart';
import '../book_page.dart';

class ContentsPage extends StatelessWidget {
  const ContentsPage({super.key, required this.storySections});

  final List<StorySection> storySections;

  @override
  Widget build(BuildContext context) {
    return BookPage(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contents',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: const Color(0xFF4D2330),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Use the jump buttons above any time.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF7B4A55)),
            ),
            const SizedBox(height: 22),
            ...storySections.asMap().entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24,
                      child: Text(
                        '${entry.key + 1}',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: const Color(0xFFB65063),
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        entry.value.title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: const Color(0xFF5B2B35)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Text(
              'Finale: A Valentine Letter',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontStyle: FontStyle.italic,
                color: const Color(0xFFB7445E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
