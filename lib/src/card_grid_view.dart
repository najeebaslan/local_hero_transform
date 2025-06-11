/* File: local_hero_transform
   Version: 1.0.4
*/

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_hero_transform/src/utils.dart'
    show ContextExtension, CustomOnPressedFavoriteIcon, imageHeightListView, paddingHorizontal;

import '../local_hero_transform.dart';

/// A card widget designed for grid view with hero animation capabilities.
class CardGridView extends StatelessWidget {
  /// Creates a CardGrid widget.
  ///
  /// Required parameters:
  /// - [tagHero]: Unique tag for hero animation
  /// - [itemsModel]: Data model for the card
  /// - [index]: Index of this card
  /// - [textDirection]: Text direction for layout
  /// - [onPressedCard]: Callback when card is pressed
  const CardGridView({
    super.key,
    required this.tagHero,
    required this.itemsModel,
    required this.index,
    required this.textDirection,
    required this.onPressedCard,
  });

  final int tagHero;
  final ItemsModel itemsModel;
  final int index;
  final TextDirection textDirection;
  final CustomOnPressedFavoriteIcon onPressedCard;

  @override
  Widget build(BuildContext context) {
    double beginAnimationWidth = (context.width * 0.5) - (paddingHorizontal * 2) - 16 / 21.5;
    double iconHeight = context.isTablet ? 18.w : 12.w;

    return LayoutBuilder(builder: (context, constraints) {
      /// widthGridCard it's equal width grid card
      double widthCard = constraints.maxWidth - paddingHorizontal * 2;

      return Hero(
        tag: tagHero,
        flightShuttleBuilder: (
          flightContext,
          animation,
          flightDirection,
          fromHeroContext,
          toHeroContext,
        ) {
          final positionRight = Tween<double>(begin: 100, end: 10).animate(animation);
          final positionBottom = Tween<double>(begin: 50, end: 50).animate(animation);

          final widthLisViewCard = (fromHeroContext.findRenderObject() as RenderBox).size.width;

          final animationHeight = Tween<double>(begin: 90, end: 300).animate(animation);

          final animationWidth = Tween<double>(begin: 90.w, end: widthCard).animate(animation);

          final favoriteIconPosition = Tween<double>(
            begin: widthLisViewCard - 90.w,
            end: iconHeight,
          ).animate(animation);

          final favoriteIconHeightPosition = Tween<double>(
            begin: (imageHeightListView / 6).w,
            end: iconHeight,
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
              favoriteIconHeightPosition: iconHeight,
              favoriteIconPosition: iconHeight,
              itemsModel: itemsModel,
              index: index,
              heightImage: 300,
              widthImage: widthCard,
              bottomTitle: 50.w,
              rightTitle: 10.w,
              rightPrice: 10.w,
            );
          },
        ),
      );
    });
  }
}
