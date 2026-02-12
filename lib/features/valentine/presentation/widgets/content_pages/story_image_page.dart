import 'package:flutter/material.dart';

import '../book_page.dart';
import 'photo_collage.dart';

class StoryImagePage extends StatelessWidget {
  const StoryImagePage({
    super.key,
    required this.title,
    required this.imageUrls,
    required this.caption,
  });

  final String title;
  final List<String> imageUrls;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return BookPage(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color(0xFF502732),
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
            Text(
              caption,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: const Color(0xFF865A64)),
            ),
          ],
        ),
      ),
    );
  }
}
