import 'package:flutter/material.dart';

import '../book_page.dart';
import 'photo_collage.dart';

class StoryImagePage extends StatelessWidget {
  const StoryImagePage({
    super.key,
    required this.title,
    required this.imageUrls,
  });

  final String title;
  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BookPage(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: PhotoCollage(
                imageUrls: imageUrls,
                fallbackLabel: 'Image placeholder',
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
