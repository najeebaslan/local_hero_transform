/*File : local_hero_transform
Version : 0.0.1
*/
import 'package:flutter/material.dart';

import '../local_hero_transform.dart';

class CardGridView extends StatelessWidget {
  final int index;
  final HeroCardModel cardModel;
  final TextDirection textDirection;
  final BaseHeroCardOptionalParameters? optionalParameters;
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
        final positionRight = Tween<double>(begin: 100, end: 10).animate(animation);
        final positionBottom = Tween<double>(begin: 50, end: 50).animate(animation);

        // Get size for the to hero widget or from hero widget size
        RenderBox? renderBoxFrom = fromHeroContext.findRenderObject() as RenderBox?;
        RenderBox? renderBoxTo = toHeroContext.findRenderObject() as RenderBox?;
        final animationHeight =
            Tween<double>(begin: 90, end: renderBoxTo!.size.height * 0.67).animate(animation);

        final animationWidth =
            Tween<double>(begin: 80, end: renderBoxTo.size.width * 0.9).animate(animation);
        final favoriteIconPosition =
            Tween<double>(begin: renderBoxFrom!.size.width - 72, end: 20).animate(animation);
        final favoriteIconHeightPosition =
            Tween<double>(begin: renderBoxFrom.size.height - 72, end: 20).animate(animation);

        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return BaseFavoriteCard(
              parameters: BaseHeroCardParameters(
                optionalParameters: optionalParameters,
                textDirection: textDirection,
                favoriteIconHeightPosition: favoriteIconHeightPosition.value,
                favoriteIconPosition: favoriteIconPosition.value,
                cardModel: cardModel,
                index: index,
                heightImage: animationHeight.value,
                widthImage: animationWidth.value,
                bottomTitle: positionBottom.value,
                rightTitle: positionRight.value,
                rightPrice: positionRight.value,
              ),
            );
          },
        );
      },
      createRectTween: (Rect? begin, Rect? end) {
        return MaterialRectCenterArcTween(begin: begin, end: end);
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return BaseFavoriteCard(
            parameters: BaseHeroCardParameters(
              textDirection: textDirection,
              favoriteIconHeightPosition: 20,
              favoriteIconPosition: 20,
              cardModel: cardModel,
              optionalParameters: optionalParameters,
              index: index,
              heightImage: constraints.maxHeight * 0.67,
              widthImage: 180,
              bottomTitle: 50,
              rightTitle: 10,
              rightPrice: 10,
            ),
          );
        },
      ),
    );
  }
}
