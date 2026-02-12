import 'package:flutter/material.dart';

import '../book_page.dart';

class LetterPage extends StatelessWidget {
  const LetterPage({super.key, required this.letterBody});

  final String letterBody;

  @override
  Widget build(BuildContext context) {
    return BookPage(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Valentine Letter',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: const Color(0xFF4A2130),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  letterBody,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.85,
                    color: const Color(0xFF623B45),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
