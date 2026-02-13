import 'package:flutter/material.dart';

import '../../domain/jump_target.dart';

class ValentineTopBar extends StatelessWidget {
  const ValentineTopBar({
    super.key,
    required this.onJump,
    required this.isDarkMode,
    required this.onToggleThemeMode,
  });

  final ValueChanged<JumpTarget> onJump;
  final bool isDarkMode;
  final VoidCallback onToggleThemeMode;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh.withValues(alpha: 0.86),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant),
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
          IconButton.filledTonal(
            onPressed: onToggleThemeMode,
            tooltip: isDarkMode
                ? 'Switch to light mode'
                : 'Switch to dark mode',
            icon: Icon(
              isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            ),
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
    final colorScheme = Theme.of(context).colorScheme;

    return FilledButton.tonal(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        foregroundColor: colorScheme.onSecondaryContainer,
        backgroundColor: colorScheme.secondaryContainer,
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
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant),
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
              ).textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
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
