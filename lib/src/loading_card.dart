import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_hero_transform/src/card_style_mode.dart';

import 'shimmer.dart';
import 'utils.dart';

class ShimmerBaseHeroCard extends StatelessWidget {
  final double heightImage;
  final double widthImage;
  final double bottomTitle;
  final double rightTitle;
  final double rightPrice;
  final double favoriteIconPosition;
  final double favoriteIconHeightPosition;
  final TextDirection textDirection;
  final double cardWidth;
  final CardStyleMode cardStyleMode;

  const ShimmerBaseHeroCard({
    super.key,
    required this.heightImage,
    required this.widthImage,
    required this.bottomTitle,
    required this.rightTitle,
    required this.rightPrice,
    required this.favoriteIconPosition,
    required this.favoriteIconHeightPosition,
    required this.textDirection,
    required this.cardWidth,
    required this.cardStyleMode,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: heightImage),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: const Color(0xFF3A5160).withValues(alpha: 0.1),
              offset: const Offset(0, 5),
            ),
          ],
          color: cardStyleMode.cardColor,
          borderRadius: BorderRadius.circular(24.0.r),
        ),
        margin: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
        child: Stack(
          textDirection: textDirection,
          children: [
            // Shimmer Placeholder for Image
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: CustomShimmer(
                isDark: cardStyleMode.isDarkMode,
                animationShimmerColor: cardStyleMode.animationShimmerColor,
                backgroundColor: cardStyleMode.itemColor,
                height: widthImage - paddingImageAll * 2,
                width: widthImage - paddingImageAll * 2,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),

            // Shimmer Placeholder for Name
            PositionedDirectional(
              bottom: bottomTitle,
              start: rightTitle,
              end: 10.w,
              child: CustomShimmer(
                isDark: cardStyleMode.isDarkMode,
                animationShimmerColor: cardStyleMode.animationShimmerColor,
                backgroundColor: cardStyleMode.itemColor,
                height: 12.h,
                width: cardWidth * 0.6,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),

            // Shimmer Placeholder for Title
            PositionedDirectional(
              bottom: (bottomTitle / 1.7),
              start: rightPrice,
              end: rightPrice,
              child: SizedBox(
                width: cardWidth * 0.8,
                child: CustomShimmer(
                  isDark: cardStyleMode.isDarkMode,
                  animationShimmerColor: cardStyleMode.animationShimmerColor,
                  backgroundColor: cardStyleMode.itemColor,
                  height: 10.h,
                  width: cardWidth * 0.5,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),

            // Shimmer Placeholder for Subtitle
            PositionedDirectional(
              bottom: bottomTitle / 6,
              start: rightPrice,
              end: rightPrice,
              child: SizedBox(
                width: cardWidth * 0.8,
                child: CustomShimmer(
                  isDark: cardStyleMode.isDarkMode,
                  animationShimmerColor: cardStyleMode.animationShimmerColor,
                  backgroundColor: cardStyleMode.itemColor,
                  height: 8.h,
                  width: cardWidth * 0.4,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
