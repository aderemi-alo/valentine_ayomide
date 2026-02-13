import 'package:flutter/material.dart';

import 'image_fallback.dart';

class PhotoCollage extends StatelessWidget {
  const PhotoCollage({
    super.key,
    required this.imageUrls,
    required this.fallbackLabel,
  });

  final List<String> imageUrls;
  final String fallbackLabel;

  @override
  Widget build(BuildContext context) {
    final urls = _normalizeToFour(imageUrls);

    return Column(
      children: [
        Expanded(
          flex: 6,
          child: Row(
            children: [
              Expanded(flex: 6, child: _collageTile(urls[0])),
              const SizedBox(width: 8),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Expanded(child: _collageTile(urls[1])),
                    const SizedBox(height: 8),
                    Expanded(child: _collageTile(urls[2])),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(flex: 4, child: _collageTile(urls[3])),
      ],
    );
  }

  List<String> _normalizeToFour(List<String> urls) {
    if (urls.isEmpty) {
      return List<String>.filled(4, '');
    }

    final normalized = <String>[...urls];
    while (normalized.length < 4) {
      normalized.add(normalized.last);
    }

    return normalized.take(4).toList();
  }

  Widget _collageTile(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: imageUrl.isEmpty
          ? ImageFallback(label: fallbackLabel)
          : Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) =>
                  ImageFallback(label: fallbackLabel),
            ),
    );
  }
}
