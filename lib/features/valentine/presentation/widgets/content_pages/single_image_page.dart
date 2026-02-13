import 'package:flutter/material.dart';

import '../book_page.dart';
import 'image_fallback.dart';

class SingleImagePage extends StatelessWidget {
  const SingleImagePage({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.caption,
  });

  final String title;
  final String imageUrl;
  final String caption;

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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                      const ImageFallback(label: 'Image placeholder'),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              caption,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
