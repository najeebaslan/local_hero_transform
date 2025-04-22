import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Signature for a callback when the favorite icon is pressed.
typedef CustomOnPressedFavoriteIcon = void Function(int index);
double paddingHorizontal = 10.w;
double paddingVertical = 8.w;
double paddingImageAll = 8.0.w;
double imageHeightListView = 100 + paddingImageAll * 2;

extension ContextExtension<T> on BuildContext {
  bool get isTablet => MediaQuery.sizeOf(this).width >= 600.0;
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;
  Size get designSize => isTablet ? const Size(481, 890) : const Size(428, 926);
}
