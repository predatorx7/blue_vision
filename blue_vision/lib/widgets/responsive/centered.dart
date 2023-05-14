import 'package:flutter/material.dart';

class CenteredConstraintBox extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const CenteredConstraintBox({
    super.key,
    required this.child,
    this.maxWidth = 800,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: child,
          ),
        ),
      ],
    );
  }
}
