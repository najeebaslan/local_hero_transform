/* File: local_hero_transform
   Version: 1.0.0
*/

import 'package:flutter/material.dart';

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
        final renderBoxFrom = fromHeroContext.findRenderObject() as RenderBox?;
        final renderBoxTo = toHeroContext.findRenderObject() as RenderBox?;

        // Size animations
        final animationHeight = Tween<double>(
          begin: 90,
          end: renderBoxTo!.size.height - textHeight,
        ).animate(animation);

        final animationWidth = Tween<double>(
          begin: 80,
          end: renderBoxTo.size.width * 0.9,
        ).animate(animation);

        // Favorite icon position animations
        final favoriteIconPosition = Tween<double>(
          begin: renderBoxFrom!.size.width - 72,
          end: 18,
        ).animate(animation);

        final favoriteIconHeightPosition = Tween<double>(
          begin: renderBoxFrom.size.height - 82,
          end: 18,
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
            heightImage: _getImageHeight(constraints, context),
            index: index,
            itemsModel: itemsModel,
            widthImage: MediaQuery.sizeOf(context).width > 420 ? 230 : 180,
            bottomTitle: 50,
            rightTitle: 10,
            rightPrice: 10,
            favoriteIconPosition: 18,
            favoriteIconHeightPosition: 18,
            textDirection: textDirection,
            cardWidth: constraints.maxWidth,
          );
        },
      ),
    );
  }

  double _getImageHeight(BoxConstraints constraints, BuildContext context) =>
      constraints.maxHeight - textHeight;
}
