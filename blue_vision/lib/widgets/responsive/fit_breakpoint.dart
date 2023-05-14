import 'package:flutter/material.dart';

class BreakpointFittedBox extends StatelessWidget {
  const BreakpointFittedBox({
    super.key,
    required this.breakpointScaleFactor,
    required this.breakpointWidth,
    this.maxWidth,
    required this.child,
  });

  final Widget child;
  final double? maxWidth;
  final double breakpointWidth;
  final double breakpointScaleFactor;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final textScalingFactor = mediaQuery.textScaleFactor;

    Widget box = child;

    if (maxWidth != null) {
      box = ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth! * textScalingFactor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            box,
          ],
        ),
      );
    }

    if (width < (breakpointWidth * textScalingFactor)) {
      box = SizedBox(
        width: width * breakpointScaleFactor * textScalingFactor,
        child: FittedBox(
          fit: BoxFit.contain,
          child: box,
        ),
      );
    }

    return box;
  }
}
