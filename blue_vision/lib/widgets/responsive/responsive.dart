import 'dart:collection';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

bool printWidthFromMediaQueryOf(BuildContext context) {
  assert(() {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    print('width: ${size.width}');
    return true;
  }());
  return true;
}

Breakpoint _min(Breakpoint a, Breakpoint b) {
  if (a < b) return a;
  return b;
}

Breakpoint _max(Breakpoint a, Breakpoint b) {
  if (a > b) return a;
  return b;
}

abstract mixin class Breakpoint {
  double get value;

  const factory Breakpoint(double value) = BreakpointImpl;

  int compareTo(Object other) {
    if (other is num) {
      return value.compareTo(other);
    } else if (other is Breakpoint) {
      return value.compareTo(other.value);
    } else {
      return -1;
    }
  }

  bool operator <(Object other) {
    return (other is num && value < other) ||
        (other is Breakpoint && value < other.value);
  }

  bool operator >(Object other) {
    return (other is num && value > other) ||
        (other is Breakpoint && value > other.value);
  }

  bool operator >=(Object other) {
    return (other is num && value >= other) ||
        (other is Breakpoint && value >= other.value);
  }

  bool operator <=(Object other) {
    return (other is num && value <= other) ||
        (other is Breakpoint && value <= other.value);
  }

  @override
  String toString() {
    return 'Breakpoint($value)';
  }
}

@protected
class BreakpointImpl with Breakpoint implements Comparable<Object> {
  const BreakpointImpl(this.value);

  @override
  final double value;

  @override
  bool operator ==(Object other) {
    return (other is num && value == other) ||
        (other is Breakpoint && value == other.value);
  }

  @override
  int get hashCode => value.hashCode;
}

enum BreakpointDp with Breakpoint implements Comparable<Object> {
  dip1200(1200),
  dip1000(1000),
  dip800(800),
  dip600(600),
  dip400(400),
  dip360(360),
  dip320(320),
  dip300(300),
  zero(0);

  const BreakpointDp(this.value);

  @override
  final double value;
}

class Responsive {
  const Responsive(this.size);

  final double size;

  Responsive.fromMedia(
    BuildContext context,
    double Function(MediaQueryData context) onMedia,
  ) : size = onMedia(MediaQuery.of(context));

  Responsive.fromMediaWidth(BuildContext context)
      : size = MediaQuery.of(context).size.width;
  Responsive.fromMediaHeight(BuildContext context)
      : size = MediaQuery.of(context).size.height;
  Responsive.fromMediaShortestSide(BuildContext context)
      : size = MediaQuery.of(context).size.shortestSide;

  double _getExtrapolationFactor(num a, num b, double x) {
    return (x.clamp(a, b) - a) / (b - a);
  }

  double forRange(Map<double, double> valueByRange) {
    if (valueByRange.isEmpty) {
      throw StateError('valueByRange must not be empty');
    }
    final values = SplayTreeMap<double, double>.from(valueByRange);
    final ranges = values.keys;
    double begin = ranges.first;
    double end = ranges.last;

    for (final range in ranges) {
      if (size >= range) {
        begin = math.min(begin, range);
      }
      if (size <= range) {
        end = math.max(end, range);
      }
    }

    return Tween(
      begin: values[begin]!,
      end: values[end]!,
    ).transform(
      _getExtrapolationFactor(begin, end, size),
    );
  }

  double forBreakpoints(Map<Breakpoint, double> valueByBreakpoint) {
    if (valueByBreakpoint.isEmpty) {
      throw StateError('valueByBreakpoint must not be empty');
    }
    final values = SplayTreeMap<Breakpoint, double>.from(valueByBreakpoint);
    final ranges = values.keys;
    Breakpoint begin = ranges.first;
    Breakpoint end = ranges.last;

    for (final range in ranges) {
      if (size >= range.value) {
        begin = _min(begin, range);
      }
      if (size <= range.value) {
        end = _max(end, range);
      }
    }

    return Tween(
      begin: values[begin]!,
      end: values[end]!,
    ).transform(
      _getExtrapolationFactor(begin.value, end.value, size),
    );
  }
}
