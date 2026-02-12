import 'package:flutter/material.dart';

class CoverPage extends StatelessWidget {
  const CoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: Container(
          decoration: _paperDecoration,
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
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
                  color: const Color(0xFFFFFFFF).withValues(alpha: 0.35),
                ),
              ),
              Positioned(
                left: -60,
                bottom: -45,
                child: _floatingShape(
                  size: 190,
                  color: const Color(0xFFFF8EA7).withValues(alpha: 0.23),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 36,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Valentine Edition',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        letterSpacing: 3.2,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF703840),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Our Love\nStory',
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(
                            height: 1.05,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF4E1F2A),
                          ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'A playbook of our favorite chapters, small moments, and '
                      'the letter I wrote just for you.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.55,
                        color: const Color(0xFF643B42),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF5F6),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: const Color(0xFFDEA3AF)),
                      ),
                      child: Text(
                        'Tap Next to begin',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF83444F),
                        ),
                      ),
                    ),
                  ],
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

  BoxDecoration get _paperDecoration => BoxDecoration(
    color: const Color(0xFFFFFCFA),
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: const Color(0xFFE7CED2), width: 1.2),
    boxShadow: [
      BoxShadow(
        color: const Color(0xFF8C5A63).withValues(alpha: 0.14),
        blurRadius: 26,
        offset: const Offset(0, 14),
      ),
    ],
  );
}
