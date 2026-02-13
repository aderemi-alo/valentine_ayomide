import 'package:flutter/material.dart';

class SpreadView extends StatelessWidget {
  const SpreadView({super.key, required this.left, required this.right});

  static const double _maxPageWidth = 500;

  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _maxPageWidth),
            child: left,
          ),
          const SizedBox(width: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _maxPageWidth),
            child: right,
          ),
        ],
      ),
    );
  }
}

class SinglePageView extends StatelessWidget {
  const SinglePageView({super.key, required this.page});

  static const double _maxPageWidth = 500;

  final Widget page;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _maxPageWidth),
        child: page,
      ),
    );
  }
}
