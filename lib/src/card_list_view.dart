/* File: local_hero_transform
   Version: 0.0.3
*/

import 'package:flutter/material.dart';

import '../local_hero_transform.dart';

// CardListView widget that displays a card with hero animations during transitions.
class CardListView extends StatelessWidget {
  /// Unique tag for the hero animation based on the index.
  final int index;

  /// Model representing the data for the card.
  final HeroCardModel cardModel;

  /// Text direction for the card content.
  final TextDirection textDirection;

  /// Optional parameters for customization.
  final BaseHeroCardOptionalParameters? optionalParameters;

  /// Constructor for CardListView, requires index, card model, text direction, and optional parameters.
  const CardListView({
    super.key,
    required this.index,
    required this.cardModel,
    required this.textDirection,
    this.optionalParameters,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: index,
      flightShuttleBuilder:
          (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
        // Define animation for the position of the card during the transition.
        final positionRight = Tween<double>(begin: 10, end: 100).animate(animation);
        final positionBottom = Tween<double>(begin: 50, end: 50).animate(animation);

        // Get sizes of the hero widgets from their render boxes.
        RenderBox? renderBoxTo = toHeroContext.findRenderObject() as RenderBox?;
        RenderBox? renderBoxFrom = fromHeroContext.findRenderObject() as RenderBox?;

        // Define animations for height and width of the card during transition.
        final animationHeight =
            Tween<double>(begin: renderBoxFrom!.size.height * 0.67, end: 90).animate(animation);
        final animationWidth =
            Tween<double>(begin: renderBoxFrom.size.width * 0.9, end: 80).animate(animation);

        // Define animations for the favorite icon's position.
        final favoriteIconPosition =
            Tween<double>(begin: 20, end: renderBoxTo!.size.width - 72).animate(animation);
        final favoriteIconHeightPosition =
            Tween<double>(begin: 20, end: renderBoxTo.size.height - 72).animate(animation);

        return AnimatedBuilder(
          animation: animationHeight,
          builder: (context, child) {
            // Build the animated card using BaseFavoriteCard with updated parameters.
            return BaseFavoriteCard(
              parameters: BaseHeroCardParameters(
                optionalParameters: optionalParameters,
                textDirection: textDirection,
                cardModel: cardModel,
                index: index,
                heightImage: animationHeight.value, // Animated height
                widthImage: animationWidth.value, // Animated width
                bottomTitle: positionBottom.value, // Animated bottom title position
                rightTitle: positionRight.value, // Animated right title position
                rightPrice: positionRight.value, // Animated right price position
                favoriteIconPosition: favoriteIconPosition.value, // Animated favorite icon position
                favoriteIconHeightPosition:
                    favoriteIconHeightPosition.value, // Animated favorite icon height
              ),
            );
          },
        );
      },
      // Create a rectangular tween for the hero animation.
      createRectTween: (Rect? begin, Rect? end) {
        return MaterialRectCenterArcTween(
            begin: begin, end: end); // Arc tween for smooth transitions.
      },
      child: BaseFavoriteCard(
        parameters: BaseHeroCardParameters(
          textDirection: textDirection,
          optionalParameters: optionalParameters,
          favoriteIconHeightPosition: 100 - 72, // Initial height for the favorite icon position.
          favoriteIconPosition:
              MediaQuery.sizeOf(context).width - 72, // Initial position for the favorite icon.
          cardModel: cardModel, // Card model data.
          index: index, // Index of the card.
          heightImage: 100, // Initial height of the card image.
          widthImage: 80, // Initial width of the card image.
          bottomTitle: 50, // Bottom position of the title.
          rightTitle: 100, // Right position of the title.
          rightPrice: 100, // Right position of the price.
        ),
      ),
    );
  }
}
