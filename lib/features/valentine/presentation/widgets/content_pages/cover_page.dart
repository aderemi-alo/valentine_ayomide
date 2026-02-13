import 'package:flutter/material.dart';

class CoverPage extends StatelessWidget {
  const CoverPage({super.key});

  static const double _maxPageWidth = 400;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _maxPageWidth),
        child: Container(
          decoration: _paperDecoration(context),
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [
                              colorScheme.surfaceContainerHighest,
                              colorScheme.surfaceContainerHigh,
                            ]
                          : [
                              const Color(0xFFFFD7CF).withValues(alpha: 0.9),
                              const Color(0xFFFAD7EA).withValues(alpha: 0.85),
                            ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -70,
                top: -40,
                child: _floatingShape(
                  size: 180,
                  color: colorScheme.surface.withValues(alpha: 0.22),
                ),
              ),
              Positioned(
                left: -60,
                bottom: -45,
                child: _floatingShape(
                  size: 190,
                  color: colorScheme.primary.withValues(alpha: 0.16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 36,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Valentine Edition',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    letterSpacing: 3.2,
                                    fontWeight: FontWeight.w600,
                                    color: colorScheme.primary,
                                  ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Our Love\nStory',
                              style: Theme.of(context).textTheme.displayMedium
                                  ?.copyWith(
                                    height: 1.05,
                                    fontWeight: FontWeight.w700,
                                    color: colorScheme.onSurface,
                                  ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'A playbook of our favorite chapters, small moments, and '
                              'the letter I wrote just for you.',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    height: 1.55,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                            ),
                            const SizedBox(height: 24),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.secondaryContainer,
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(
                                  color: colorScheme.outlineVariant,
                                ),
                              ),
                              child: Text(
                                'Tap Next to begin',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: colorScheme.onSecondaryContainer,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _floatingShape({required double size, required Color color}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }

  BoxDecoration _paperDecoration(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BoxDecoration(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: colorScheme.outlineVariant, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: isDark ? 0.32 : 0.14),
          blurRadius: 26,
          offset: const Offset(0, 14),
        ),
      ],
    );
  }
}
