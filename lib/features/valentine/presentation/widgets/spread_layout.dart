import 'package:flutter/material.dart';

class SpreadView extends StatelessWidget {
  const SpreadView({super.key, required this.left, required this.right});

  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: left),
        const SizedBox(width: 14),
        Expanded(child: right),
      ],
    );
  }
}

class SinglePageView extends StatelessWidget {
  const SinglePageView({super.key, required this.page});

  final Widget page;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: page,
      ),
    );
  }
}
