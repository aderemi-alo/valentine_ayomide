import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatedHeartBackground extends StatefulWidget {
  const AnimatedHeartBackground({super.key, required this.isDarkMode});

  final bool isDarkMode;

  @override
  State<AnimatedHeartBackground> createState() =>
      _AnimatedHeartBackgroundState();
}

class _AnimatedHeartBackgroundState extends State<AnimatedHeartBackground>
    with SingleTickerProviderStateMixin {
  static const int _particleCount = 26;

  late final AnimationController _controller;
  late final List<_HeartParticle> _particles;

  @override
  void initState() {
    super.initState();
    _particles = _generateParticles();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 16),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return IgnorePointer(
      child: RepaintBoundary(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = constraints.maxHeight;

            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final animationValue = _controller.value;

                return Stack(
                  children: [
                    for (final particle in _particles)
                      _buildParticle(
                        particle: particle,
                        time: animationValue,
                        width: width,
                        height: height,
                        colorScheme: colorScheme,
                      ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildParticle({
    required _HeartParticle particle,
    required double time,
    required double width,
    required double height,
    required ColorScheme colorScheme,
  }) {
    final progress = ((time * particle.speed) + particle.phase) % 1.0;

    final y = particle.isFalling
        ? (progress * (height + particle.size)) - particle.size
        : height - (progress * (height + particle.size));

    final wave =
        math.sin(
          (progress * math.pi * 2 * particle.waveCycles) +
              (particle.phase * math.pi * 2),
        ) *
        particle.waveAmplitude;

    final x = (particle.xFactor * width) + wave;

    final rotation =
        math.sin((progress * math.pi * 2) + particle.phase) * particle.tilt;

    final baseColor = particle.isFalling
        ? colorScheme.primary
        : colorScheme.secondary;
    final alphaScale = widget.isDarkMode ? 1.25 : 1.0;
    final alpha = (particle.opacity * alphaScale).clamp(0.05, 0.38);

    return Positioned(
      left: x.clamp(-particle.size, width + particle.size),
      top: y,
      child: Transform.rotate(
        angle: rotation,
        child: Icon(
          Icons.favorite_rounded,
          size: particle.size,
          color: baseColor.withValues(alpha: alpha),
        ),
      ),
    );
  }

  List<_HeartParticle> _generateParticles() {
    final random = math.Random(27);

    return List.generate(_particleCount, (index) {
      final isFalling = index % 3 != 0;

      return _HeartParticle(
        xFactor: random.nextDouble(),
        size: 14 + random.nextDouble() * 18,
        speed: 0.55 + random.nextDouble() * 1.25,
        phase: random.nextDouble(),
        waveAmplitude: 10 + random.nextDouble() * 34,
        waveCycles: 0.8 + random.nextDouble() * 1.4,
        opacity: 0.08 + random.nextDouble() * 0.2,
        tilt: 0.06 + random.nextDouble() * 0.18,
        isFalling: isFalling,
      );
    });
  }
}

class _HeartParticle {
  const _HeartParticle({
    required this.xFactor,
    required this.size,
    required this.speed,
    required this.phase,
    required this.waveAmplitude,
    required this.waveCycles,
    required this.opacity,
    required this.tilt,
    required this.isFalling,
  });

  final double xFactor;
  final double size;
  final double speed;
  final double phase;
  final double waveAmplitude;
  final double waveCycles;
  final double opacity;
  final double tilt;
  final bool isFalling;
}
