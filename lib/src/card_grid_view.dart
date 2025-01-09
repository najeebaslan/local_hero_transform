/* File: local_hero_transform
   Version: 0.0.3
*/

import 'package:flutter/material.dart';

import '../local_hero_transform.dart';

/// CardGridView widget that displays a card in a grid layout with hero animations.
class CardGridView extends StatelessWidget {
  /// Unique tag for the hero animation based on the index.
  final int index;

  /// Model representing the data for the card.
  final HeroCardModel cardModel;

  /// Direction displayed the card.
  final TextDirection textDirection;

  /// Optional parameters for additional customization.
  final BaseHeroCardOptionalParameters? optionalParameters;

  // Constructor for CardGridView, requiring card model, index, text direction, and optional parameters.
  const CardGridView({
    required this.cardModel,
    required this.index,
    required this.textDirection,
    this.optionalParameters,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: index,
      flightShuttleBuilder:
          (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
        // Define animations for the position of the card during the transition.
        final positionRight = Tween<double>(begin: 100, end: 10).animate(animation);
        final positionBottom = Tween<double>(begin: 50, end: 50).animate(animation);

        // Get sizes of the hero widgets from their render boxes.
        RenderBox? renderBoxFrom = fromHeroContext.findRenderObject() as RenderBox?;
        RenderBox? renderBoxTo = toHeroContext.findRenderObject() as RenderBox?;

        // Define animations for height and width of the card during transition.
        final animationHeight =
            Tween<double>(begin: 90, end: renderBoxTo!.size.height * 0.67).animate(animation);
        final animationWidth =
            Tween<double>(begin: 80, end: renderBoxTo.size.width * 0.9).animate(animation);

        // Define animations for the favorite icon's position.
        final favoriteIconPosition =
            Tween<double>(begin: renderBoxFrom!.size.width - 72, end: 20).animate(animation);
        final favoriteIconHeightPosition =
            Tween<double>(begin: renderBoxFrom.size.height - 72, end: 20).animate(animation);

        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            // Build the animated card using BaseFavoriteCard with updated parameters.
            return BaseFavoriteCard(
              parameters: BaseHeroCardParameters(
                optionalParameters: optionalParameters,
                textDirection: textDirection,
                favoriteIconHeightPosition: favoriteIconHeightPosition
                    .value, // Animated position for the favorite icon's height.
                favoriteIconPosition:
                    favoriteIconPosition.value, // Animated position for the favorite icon.
                cardModel: cardModel, // Card model data.
                index: index, // Index of the card.
                heightImage: animationHeight.value, // Animated height of the card image.
                widthImage: animationWidth.value, // Animated width of the card image.
                bottomTitle: positionBottom.value, // Animated bottom position of the title.
                rightTitle: positionRight.value, // Animated right position of the title.
                rightPrice: positionRight.value, // Animated right position of the price.
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Build the base card that is displayed initially.
          return BaseFavoriteCard(
            parameters: BaseHeroCardParameters(
              textDirection: textDirection,
              favoriteIconHeightPosition: 20, // Initial height for the favorite icon position.
              favoriteIconPosition: 20, // Initial position for the favorite icon.
              cardModel: cardModel, // Card model data.
              optionalParameters: optionalParameters, // Optional parameters.
              index: index, // Index of the card.
              heightImage: constraints.maxHeight *
                  0.67, // Set height for the card based on layout constraints.
              widthImage: 180, // Fixed width for the card image.
              bottomTitle: 50, // Bottom position for the title.
              rightTitle: 10, // Right position for the title.
              rightPrice: 10, // Right position for the price.
            ),
          );
        },
      ),
    );
  }
}
