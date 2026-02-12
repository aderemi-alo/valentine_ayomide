import 'package:flutter/material.dart';

class ImageFallback extends StatelessWidget {
  const ImageFallback({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFEFF2),
      child: Center(
        child: Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: const Color(0xFF9B6B76)),
        ),
      ),
    );
  }
}
