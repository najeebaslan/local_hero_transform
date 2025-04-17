import 'package:flutter/material.dart';

import '../local_hero_transform.dart';

class TextHeightCalculator {
  final ItemsModel itemsModel;
  final TextDirection textDirection;
  TextHeightCalculator({required this.itemsModel, required this.textDirection});

  double calculateHeight() {
    // Measure each text component
    final nameHeight = _measureTextHeight(
      itemsModel.name.data ?? '',
      itemsModel.name.style,
    );
    final priceHeight = _measureTextHeight(
      itemsModel.title.data ?? '',
      itemsModel.title.style,
    );

    final locationHeight = _measureTextHeight(
      itemsModel.subTitle.data ?? '',
      itemsModel.subTitle.style,
    );

    // Return the total height of all text components
    return nameHeight + priceHeight + locationHeight;
  }

  double _measureTextHeight(String text, TextStyle? style) {
    if (style == null) return 0.0;

    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: textDirection,
    )..layout();

    return textPainter.height;
  }
}
