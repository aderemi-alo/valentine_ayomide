import 'package:flutter/material.dart';

import '../book_page.dart';
import 'photo_collage.dart';

class ContentsCompanionPage extends StatelessWidget {
  const ContentsCompanionPage({super.key, required this.imageUrls});

  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return BookPage(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How To Personalize',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: const Color(0xFF4D2330),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Replace each placeholder image URL with your own photos. '
              'This page now supports a 4-photo collage layout that scales '
              'to fit while preserving aspect ratio.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.6,
                color: const Color(0xFF68404A),
              ),
            ),
            const SizedBox(height: 22),
            Expanded(
              child: PhotoCollage(
                imageUrls: imageUrls,
                fallbackLabel: 'Memory board placeholder',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
