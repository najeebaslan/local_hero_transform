/* File: local_hero_transform
   Version: 1.0.2
*/

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_hero_transform/src/utils.dart'
    show ContextExtension, CustomOnPressedFavoriteIcon, imageHeightListView, paddingHorizontal;

import '../local_hero_transform.dart';

/// A card widget designed for list view with hero animation capabilities.
class CardListView extends StatelessWidget {
  /// Creates a CustomCardListView widget.
  ///
  /// Required parameters:
  /// - [tagHero]: Unique tag for hero animation
  /// - [itemsModel]: Data model for the card
  /// - [index]: Index of this card
  /// - [textDirection]: Text direction for layout
  /// - [onPressedCard]: Callback when card is pressed
  const CardListView({
    super.key,
    required this.tagHero,
    required this.itemsModel,
    required this.index,
    required this.textDirection,
    required this.onPressedCard,
  });

  final String tagHero;
  final ItemsModel itemsModel;
  final int index;
  final TextDirection textDirection;
  final CustomOnPressedFavoriteIcon onPressedCard;

  @override
  Widget build(BuildContext context) {
    double beginAnimationWidth = (context.width * 0.5) - (paddingHorizontal * 2) - 16 / 21.5;
    double iconHeight = context.isTablet ? 18.w : 12.w;

    return LayoutBuilder(builder: (context, constraints) {
      return Hero(
        tag: index,
        flightShuttleBuilder: (
          flightContext,
          animation,
          flightDirection,
          fromHeroContext,
          toHeroContext,
        ) {
          double heightCard =
              (fromHeroContext.findRenderObject() as RenderBox).size.height - paddingHorizontal * 2;

          /// widthGridCard it's equal width grid card
          double widthCard =
              (fromHeroContext.findRenderObject() as RenderBox).size.width - paddingHorizontal * 2;

          final positionRight = Tween<double>(begin: 10, end: 100).animate(animation);
          final positionBottom = Tween<double>(begin: 50, end: 50).animate(animation);

          final animationHeight = Tween<double>(begin: heightCard, end: 90).animate(animation);

          final animationWidth = Tween<double>(begin: widthCard, end: 90.w).animate(animation);

          final favoriteIconPosition = Tween<double>(
            begin: iconHeight,
            end: constraints.maxWidth - 90.w,
          ).animate(animation);

          final favoriteIconHeightPosition = Tween<double>(
            begin: iconHeight,
            end: (imageHeightListView / 6).w,
          ).animate(animation);

          return AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return LayoutBuilder(builder: (context, constraints) {
                return BaseHeroCard(
                  cardWidth: beginAnimationWidth,
                  onPressedCard: onPressedCard,
                  index: index,
                  textDirection: textDirection,
                  itemsModel: itemsModel,
                  heightImage: animationHeight.value,
                  widthImage: animationWidth.value,
                  bottomTitle: positionBottom.value.w,
                  rightTitle: positionRight.value.w,
                  rightPrice: positionRight.value.w,
                  favoriteIconPosition: favoriteIconPosition.value,
                  favoriteIconHeightPosition: favoriteIconHeightPosition.value,
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
              cardWidth: constraints.maxWidth - 80.w,
              onPressedCard: onPressedCard,
              textDirection: textDirection,
              favoriteIconHeightPosition: (imageHeightListView / 6).w,
              favoriteIconPosition: constraints.maxWidth - 90.w,
              itemsModel: itemsModel,
              index: index,
              heightImage: imageHeightListView,
              widthImage: 90.w,
              bottomTitle: 50.w,
              rightTitle: 100.w,
              rightPrice: 100.w,
            );
          },
        ),
      );
    });
  }
}
