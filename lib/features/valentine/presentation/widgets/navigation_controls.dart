import 'package:flutter/material.dart';

import '../../domain/jump_target.dart';

class ValentineTopBar extends StatelessWidget {
  const ValentineTopBar({super.key, required this.onJump});

  final ValueChanged<JumpTarget> onJump;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE9D4D8)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runSpacing: 8,
        spacing: 8,
        children: [
          _jumpButton(
            context,
            label: 'Cover',
            onTap: () => onJump(JumpTarget.cover),
          ),
          _jumpButton(
            context,
            label: 'Contents',
            onTap: () => onJump(JumpTarget.contents),
          ),
          _jumpButton(
            context,
            label: 'Our Story',
            onTap: () => onJump(JumpTarget.story),
          ),
          _jumpButton(
            context,
            label: 'Letter',
            onTap: () => onJump(JumpTarget.letter),
          ),
        ],
      ),
    );
  }

  Widget _jumpButton(
    BuildContext context, {
    required String label,
    required VoidCallback onTap,
  }) {
    return FilledButton.tonal(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        foregroundColor: const Color(0xFF5B2B35),
        backgroundColor: const Color(0xFFF8E8EB),
      ),
      child: Text(label),
    );
  }
}

class ValentineBottomControls extends StatelessWidget {
  const ValentineBottomControls({
    super.key,
    required this.index,
    required this.total,
    required this.canGoBack,
    required this.canGoForward,
    required this.onBack,
    required this.onForward,
  });

  final int index;
  final int total;
  final bool canGoBack;
  final bool canGoForward;
  final VoidCallback onBack;
  final VoidCallback onForward;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE9D4D8)),
      ),
      child: Row(
        children: [
          IconButton.filledTonal(
            onPressed: canGoBack ? onBack : null,
            icon: const Icon(Icons.arrow_back_rounded),
            tooltip: 'Previous page',
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Page ${index + 1} of $total',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: const Color(0xFF60343D)),
            ),
          ),
          const SizedBox(width: 10),
          IconButton.filled(
            onPressed: canGoForward ? onForward : null,
            icon: const Icon(Icons.arrow_forward_rounded),
            tooltip: 'Next page',
          ),
        ],
      ),
    );
  }
}
