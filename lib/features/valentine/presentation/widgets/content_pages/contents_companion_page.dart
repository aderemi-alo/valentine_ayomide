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
