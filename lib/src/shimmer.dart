import 'package:flutter/material.dart';

class CustomShimmer extends StatefulWidget {
  const CustomShimmer({
    super.key,
    this.child,
    this.isCircle = false,
    this.borderAll,
    this.borderRadius,
    this.backgroundColor,
    this.animationShimmerColor,
    this.height,
    this.width,
    required this.isDark,
  });

  final Widget? child;
  final bool isCircle;
  final double? borderAll;
  final Color? backgroundColor;
  final Color? animationShimmerColor;
  final BorderRadiusGeometry? borderRadius;
  final double? height;
  final double? width;
  final bool isDark;

  @override
  State<CustomShimmer> createState() => _CustomShimmerState();
}

class _CustomShimmerState extends State<CustomShimmer> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1200));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  LinearGradient _getDarkGradient() {
    final darkColor = widget.backgroundColor ?? HexColor('#0D0F15');
    final shimmerColor = widget.animationShimmerColor ?? HexColor('#131822');

    return LinearGradient(
      colors: [
        darkColor.withValues(alpha: 0.99),
        shimmerColor,
        darkColor.withValues(alpha: 0.99),
      ],
      stops: const [0.1, 0.2, 0.4],
      begin: const Alignment(-1.0, -0.3),
      end: const Alignment(1.0, 0.3),
      tileMode: TileMode.clamp,
    );
  }

  LinearGradient _getLightGradient() {
    final lightColor = widget.backgroundColor ?? const Color.fromARGB(255, 226, 226, 237);
    final shimmerColor = widget.animationShimmerColor ?? lightColor.withValues(alpha: 0.5);

    return LinearGradient(
      colors: [
        lightColor.withValues(alpha: 0.99),
        shimmerColor,
        lightColor.withValues(alpha: 0.99),
      ],
      stops: const [0.1, 0.3, 0.4],
      begin: const Alignment(-1.0, -0.3),
      end: const Alignment(1.0, 0.3),
      tileMode: TileMode.clamp,
    );
  }

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.platformBrightnessOf(context);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        final animationValue = _animationController.value;
        final localChild = widget.child == null;

        return Container(
          height: localChild ? widget.height : null,
          width: localChild ? widget.width : null,
          decoration: BoxDecoration(
            borderRadius: getRadius(),
            shape: widget.isCircle ? BoxShape.circle : BoxShape.rectangle,
            gradient: _getGradient(brightness, animationValue),
          ),
          child: widget.child,
        );
      },
    );
  }

  LinearGradient _getGradient(Brightness brightness, double animationValue) {
    final baseGradient = widget.isDark ? _getDarkGradient() : _getLightGradient();

    return LinearGradient(
      colors: baseGradient.colors,
      stops: baseGradient.stops,
      begin: baseGradient.begin,
      end: baseGradient.end,
      transform: _SlidingGradientTransform(
        slidePercent: animationValue,
      ),
    );
  }

  BorderRadiusGeometry? getRadius() {
    return widget.isCircle
        ? null
        : widget.borderRadius ?? BorderRadius.circular(widget.borderAll ?? 10);
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({required this.slidePercent});
  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}
