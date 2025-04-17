/* File: local_hero_transform
   Version: 1.0.0
*/

import 'package:flutter/material.dart';

import '../local_hero_transform.dart';

/// A card widget designed for list view with hero animation capabilities.
class CardListView extends StatelessWidget {
  /// Creates a CustomCardListView widget.
  ///
  /// Required parameters:
  /// - [textHeight]: Precalculated height for text content
  /// - [tagHero]: Unique tag for hero animation
  /// - [itemsModel]: Data model for the card
  /// - [index]: Index of this card
  /// - [textDirection]: Text direction for layout
  /// - [onPressedCard]: Callback when card is pressed
  const CardListView({
    super.key,
    required this.textHeight,
    required this.tagHero,
    required this.itemsModel,
    required this.index,
    required this.textDirection,
    required this.onPressedCard,
  });

  final double textHeight;
  final String tagHero;
  final ItemsModel itemsModel;
  final int index;
  final TextDirection textDirection;
  final CustomOnPressedFavoriteIcon onPressedCard;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: index,
      flightShuttleBuilder: (
        flightContext,
        animation,
        flightDirection,
        fromHeroContext,
        toHeroContext,
      ) {
        // Animation setup for hero transition
        final positionRight = Tween<double>(begin: 10, end: 100).animate(animation);
        final positionBottom = Tween<double>(begin: 50, end: 50).animate(animation);

        // Get render boxes for size information
        final renderBoxTo = toHeroContext.findRenderObject() as RenderBox?;
        final renderBoxFrom = fromHeroContext.findRenderObject() as RenderBox?;

        // Size animations
        final animationHeight = Tween<double>(
          begin: renderBoxFrom!.size.height - textHeight,
          end: 90,
        ).animate(animation);

        final animationWidth = Tween<double>(
          begin: renderBoxFrom.size.width * 0.9,
          end: 80,
        ).animate(animation);

        // Favorite icon position animations
        final favoriteIconPosition = Tween<double>(
          begin: 18,
          end: renderBoxTo!.size.width - 72,
        ).animate(animation);

        final favoriteIconHeightPosition = Tween<double>(
          begin: 18,
          end: renderBoxTo.size.height - 82,
        ).animate(animation);

        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return LayoutBuilder(builder: (context, constraints) {
              return BaseHeroCard(
                onPressedCard: onPressedCard,
                heightImage: animationHeight.value,
                index: index,
                itemsModel: itemsModel,
                widthImage: animationWidth.value,
                bottomTitle: positionBottom.value,
                rightTitle: positionRight.value,
                rightPrice: positionRight.value,
                favoriteIconPosition: favoriteIconPosition.value,
                favoriteIconHeightPosition: favoriteIconHeightPosition.value,
                textDirection: textDirection,
                cardWidth: constraints.maxWidth,
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
            onPressedCard: onPressedCard,
            heightImage: 100,
            index: index,
            itemsModel: itemsModel,
            widthImage: 80,
            bottomTitle: 50,
            rightTitle: 100,
            rightPrice: 100,
            favoriteIconPosition: MediaQuery.sizeOf(context).width - 92,
            favoriteIconHeightPosition: 18,
            textDirection: textDirection,
            cardWidth: constraints.maxWidth,
          );
        },
      ),
    );
  }
}
