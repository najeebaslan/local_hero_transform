/* File: local_hero_transform
   Version: 1.0.1
*/

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_hero_transform/src/utils.dart'
    show ContextExtension, CustomOnPressedFavoriteIcon, paddingHorizontal;

import '../local_hero_transform.dart';

/// A card widget designed for grid view with hero animation capabilities.
class CardGridView extends StatelessWidget {
  /// Creates a CardGrid widget.
  ///
  /// Required parameters:
  /// - [textHeight]: Precalculated height for text content
  /// - [tagHero]: Unique tag for hero animation
  /// - [itemsModel]: Data model for the card
  /// - [index]: Index of this card
  /// - [textDirection]: Text direction for layout
  /// - [onPressedCard]: Callback when card is pressed
  const CardGridView({
    super.key,
    required this.textHeight,
    required this.tagHero,
    required this.itemsModel,
    required this.index,
    required this.textDirection,
    required this.onPressedCard,
  });

  final double textHeight;
  final int tagHero;
  final ItemsModel itemsModel;
  final int index;
  final TextDirection textDirection;
  final CustomOnPressedFavoriteIcon onPressedCard;

  @override
  Widget build(BuildContext context) {
    double beginAnimationWidth = (context.width * 0.5) - (paddingHorizontal * 2) - 16 / 21.5;

    double endIconPosition = (context.width - (context.isTablet ? 130 : 100));
    double iconHeight = context.isTablet ? 12.w : 12;
    double iconPosition = context.isTablet ? 18.w : 18;
    return Hero(
      tag: tagHero,
      flightShuttleBuilder: (
        flightContext,
        animation,
        flightDirection,
        fromHeroContext,
        toHeroContext,
      ) {
        // Animation setup for hero transition
        final positionRight = Tween<double>(begin: 100, end: 10).animate(animation);
        final positionBottom = Tween<double>(begin: 50, end: 50).animate(animation);

        // Get render boxes for size information
        final renderBoxTo = toHeroContext.findRenderObject() as RenderBox?;
        // Size animations
        final animationHeight = Tween<double>(
          begin: 100,
          end: renderBoxTo!.size.height - textHeight,
        ).animate(animation);

        final animationWidth = Tween<double>(begin: 75, end: 170).animate(animation);

        final favoriteIconPosition = Tween<double>(
          begin: endIconPosition,
          end: iconPosition,
        ).animate(animation);

        final favoriteIconHeightPosition = Tween<double>(
          begin: iconHeight,
          end: iconPosition,
        ).animate(animation);
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return LayoutBuilder(builder: (context, constraints) {
              return BaseHeroCard(
                cardWidth: beginAnimationWidth,
                onPressedCard: onPressedCard,
                textDirection: textDirection,
                favoriteIconHeightPosition: favoriteIconHeightPosition.value,
                favoriteIconPosition: favoriteIconPosition.value,
                itemsModel: itemsModel,
                index: index,
                heightImage: animationHeight.value,
                widthImage: animationWidth.value,
                bottomTitle: positionBottom.value.w,
                rightTitle: positionRight.value.w,
                rightPrice: positionRight.value.w,
              );
            });
          },
        );
      },
      createRectTween: (Rect? begin, Rect? end) {
        return MaterialRectCenterArcTween(begin: begin, end: end);
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return BaseHeroCard(
            cardWidth: beginAnimationWidth,
            onPressedCard: onPressedCard,
            textDirection: textDirection,
            favoriteIconHeightPosition: iconPosition,
            favoriteIconPosition: iconPosition,
            itemsModel: itemsModel,
            index: index,
            heightImage: _getImageHeight(constraints, context),
            widthImage: 170,
            bottomTitle: 50.w,
            rightTitle: 10.w,
            rightPrice: 10.w,
          );
        },
      ),
    );
  }

  double _getImageHeight(BoxConstraints constraints, BuildContext context) {
    return constraints.maxHeight - textHeight;
  }
}
