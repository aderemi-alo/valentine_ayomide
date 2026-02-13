import 'package:flutter/material.dart';

class ImageFallback extends StatelessWidget {
  const ImageFallback({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.surfaceContainerHighest,
      child: Center(
        child: Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
