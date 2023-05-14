import 'package:flutter/material.dart';

import 'responsive.dart';

class AdaptiveContentPadding extends StatelessWidget {
  const AdaptiveContentPadding({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.fromMediaWidth(context).forRange({
          1000: 80.0,
          360: 16,
        }),
      ),
      child: child,
    );
  }
}

class AdaptiveScrollableContentPadding extends StatelessWidget {
  const AdaptiveScrollableContentPadding({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.fromMediaWidth(context).forRange({
          1000: 60.0,
          360: 16,
        }),
      ),
      children: children,
    );
  }
}
