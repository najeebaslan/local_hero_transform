import 'package:flutter/material.dart';

class CardStyleMode {
  final Color? cardColor;
  final Color? itemColor;
  final Color? animationShimmerColor;
  final bool? isLoading;
  final bool isDarkMode;

  CardStyleMode({
    this.cardColor,
    this.isLoading,
    this.itemColor,
    this.isDarkMode = false,
    this.animationShimmerColor,
  });

  static Color getCardColor(bool isDarkMode) {
    return isDarkMode ? Color.fromARGB(255, 36, 39, 92) : Colors.white;
  }

  static Color getItemBackgroundColor(bool isDarkMode) {
    return isDarkMode ? Color.fromARGB(255, 13, 13, 29) : const Color.fromARGB(255, 226, 226, 237);
  }

  static Color getAnimationShimmerColor(bool isDarkMode) {
    return isDarkMode ? Color.fromARGB(255, 36, 39, 92) : Colors.white;
  }
}
