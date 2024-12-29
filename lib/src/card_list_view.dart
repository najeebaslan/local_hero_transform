/*File : local_hero_transform
Version : 0.0.1
*/
import 'package:flutter/material.dart';

import '../local_hero_transform.dart';

class CardListView extends StatelessWidget {
  final int index;
  final HeroCardModel cardModel;
  final TextDirection textDirection;
  final BaseHeroCardOptionalParameters? optionalParameters;
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
        final positionRight = Tween<double>(begin: 10, end: 100).animate(animation);
        final positionBottom = Tween<double>(begin: 50, end: 50).animate(animation);
        // Get size for the to hero widget or from hero widget size
        RenderBox? renderBoxTo = toHeroContext.findRenderObject() as RenderBox?;
        RenderBox? renderBoxFrom = fromHeroContext.findRenderObject() as RenderBox?;
        final animationHeight =
            Tween<double>(begin: renderBoxFrom!.size.height * 0.67, end: 90).animate(animation);
        final animationWidth =
            Tween<double>(begin: renderBoxFrom.size.width * 0.9, end: 80).animate(animation);
        final favoriteIconPosition =
            Tween<double>(begin: 20, end: renderBoxTo!.size.width - 72).animate(animation);
        final favoriteIconHeightPosition =
            Tween<double>(begin: 20, end: renderBoxTo.size.height - 72).animate(animation);

        return AnimatedBuilder(
          animation: animationHeight,
          builder: (context, child) {
            return BaseFavoriteCard(
              parameters: BaseHeroCardParameters(
                optionalParameters: optionalParameters,
                textDirection: textDirection,
                cardModel: cardModel,
                index: index,
                heightImage: animationHeight.value,
                widthImage: animationWidth.value,
                bottomTitle: positionBottom.value,
                rightTitle: positionRight.value,
                rightPrice: positionRight.value,
                favoriteIconPosition: favoriteIconPosition.value,
                favoriteIconHeightPosition: favoriteIconHeightPosition.value,
              ),
            );
          },
        );
      },
      createRectTween: (Rect? begin, Rect? end) {
        return MaterialRectCenterArcTween(begin: begin, end: end);
      },
      child: BaseFavoriteCard(
        parameters: BaseHeroCardParameters(
          textDirection: textDirection,
          optionalParameters: optionalParameters,
          favoriteIconHeightPosition: 100 - 72,
          favoriteIconPosition: MediaQuery.sizeOf(context).width - 72,
          cardModel: cardModel,
          index: index,
          heightImage: 100,
          widthImage: 80,
          bottomTitle: 50,
          rightTitle: 100,
          rightPrice: 100,
        ),
      ),
    );
  }
}
