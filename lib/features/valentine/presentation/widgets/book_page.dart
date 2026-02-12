import 'package:flutter/material.dart';

class BookPage extends StatelessWidget {
  const BookPage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFCFA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE7CED2), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8C5A63).withValues(alpha: 0.12),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: child,
    );
  }
}
