/* File: local_hero_transform
   Version: 0.0.5
*/

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'hero_card_model.dart';

/// BaseFavoriteCard widget that displays a single card with various details and animations.
class BaseFavoriteCard extends StatelessWidget {
  final BaseHeroCardParameters parameters; // Parameters required to build the card.

  /// Constructor for BaseFavoriteCard, requiring the parameters.
  const BaseFavoriteCard({super.key, required this.parameters});

  @override
  Widget build(BuildContext context) {
    // Determine the text direction for layout.
    bool isRtl = parameters.textDirection == TextDirection.rtl;
    CardOptionalParameters? optionalParams =
        parameters.optionalParameters; // Optional parameters for customization.
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: parameters.heightImage), // Constrain the card's maximum height.
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1), // Light border around the card.
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Color(0xFF3A5160).withValues(alpha: 0.1), // Shadow effect for depth.
              offset: const Offset(0, 5), // Position of the shadow.
            ),
          ],
          color: Colors.white, // Background color of the card.
          borderRadius: BorderRadius.circular(24.0.r), // Rounded corners.
        ),
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h), // Margin for spacing.
        child: InkWell(
          onTap: () => onPassedCard(optionalParams, context),
          child: Stack(
            children: [
              // Display the image or a custom image widget if provided.
              optionalParams?.image ??
                  _buildImage(
                    height: parameters.heightImage,
                    width: parameters.widthImage,
                  ),
              // Position the favorite icon button on the card.
              Positioned(
                top: parameters.favoriteIconHeightPosition.abs(),
                right: isRtl ? parameters.favoriteIconPosition : null,
                left: !isRtl ? parameters.favoriteIconPosition : null,
                child: optionalParams?.favoriteIconButton ??
                    IconButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                              Colors.redAccent), // Background for the button.
                        ),
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () => onPassedIconFavorite(optionalParams, context)
                        // Action when the button is pressed.
                        ),
              ),
              // Display the card name.
              Positioned(
                bottom: parameters.bottomTitle,
                right: isRtl ? parameters.rightTitle : 10.w,
                left: !isRtl ? parameters.rightTitle : 10.w,
                child: optionalParams?.name ??
                    Text(
                      parameters.cardModel.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
              ),
              // Display the card title.
              Positioned(
                bottom: (parameters.bottomTitle / 1.7).h,
                right: isRtl ? parameters.rightPrice : null,
                left: !isRtl ? parameters.rightPrice : null,
                child: optionalParams?.title ??
                    RichText(
                      text: TextSpan(
                        text: parameters.cardModel.title.toString(),
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          WidgetSpan(child: SizedBox(width: 3.w)), // Space between text elements.
                          TextSpan(
                            text: 'sar', // Currency symbol.
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
              ),
              // Display the subtitle of the card.
              Positioned(
                bottom: parameters.bottomTitle / 6,
                right: isRtl ? parameters.rightPrice : null,
                left: !isRtl ? parameters.rightPrice : null,
                child: optionalParams?.subtitle ??
                    _buildSubTitle(context), // Use a subtitle widget if provided.
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onPassedIconFavorite(CardOptionalParameters? optionalParams, BuildContext context) {
    optionalParams != null && optionalParams.onPressedFavoriteIcon != null
        ? optionalParams.onPressedFavoriteIcon!(
            parameters.cardModel,
            context,
          )
        : null;
  }

  void onPassedCard(CardOptionalParameters? optionalParams, BuildContext context) {
    optionalParams != null && optionalParams.onPressedCard != null
        ? optionalParams.onPressedCard!(
            parameters.cardModel,
            context,
          )
        : null;
  }

  /// Method to build the card image.
  Widget _buildImage({double? height, double? width}) {
    return Padding(
      padding: EdgeInsets.all(8.0.h), // Padding around the image.
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r), // Rounded corners for the image.
        child: Image.network(
          parameters.cardModel.imageUrl, // Image URL from the card model.
          height: height?.h ?? 200, // Height of the image.
          width: width?.w ?? 200, // Width of the image.
          fit: BoxFit.cover, // Cover the entire area.
        ),
      ),
    );
  }

  /// Method to build the subtitle for the card.
  Row _buildSubTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Align items to the start.
      children: [
        Icon(
          Icons.location_on_outlined,
          color: const Color(0xFF95979A), // Color for the location icon.
          size: 10,
        ),
        SizedBox(width: 1.w), // Space between icon and text.
        Text(
          parameters.cardModel.name, // Display the card name as subtitle.
          style: TextStyle(
            color: const Color(0xFF95979A),
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
          ),
          overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis.
        ),
      ],
    );
  }
}

/// Parameters required to build a BaseFavoriteCard.
class BaseHeroCardParameters {
  final int index; // Index of the card.
  final double heightImage; // Height of the card image.
  final double widthImage; // Width of the card image.
  final double bottomTitle; // Position of the bottom title.
  final double rightTitle; // Position of the right title.
  final double rightPrice; // Position of the right price.
  final double favoriteIconPosition; // Position of the favorite icon.
  final double favoriteIconHeightPosition; // Height position of the favorite icon.
  final HeroCardModel cardModel; // Model representing the card data.
  final TextDirection textDirection; // Text direction for the card layout.
  final CardOptionalParameters? optionalParameters; // Optional parameters for customization.

  /// Constructor for BaseHeroCardParameters, requiring necessary parameters.
  const BaseHeroCardParameters({
    this.optionalParameters,
    required this.index,
    required this.heightImage,
    required this.widthImage,
    required this.bottomTitle,
    required this.rightTitle,
    required this.rightPrice,
    required this.cardModel,
    required this.textDirection,
    required this.favoriteIconPosition,
    required this.favoriteIconHeightPosition,
  });
}

/// Optional parameters for customizing the BaseFavoriteCard.
class CardOptionalParameters {
  final Widget? title; // Custom title widget.
  final Widget? name; // Custom name widget.
  final Widget? favoriteIconButton; // Custom favorite icon button.
  final OnPressedFavoriteIcon? onPressedFavoriteIcon; // Callback for favorite icon press.
  final OnPressedFavoriteIcon? onPressedCard; // Callback for favorite icon press.
  final Widget? subtitle; // Custom subtitle widget.
  final Widget? image; // Custom image widget.

  /// Constructor for BaseHeroCardOptionalParameters.
  CardOptionalParameters({
    this.title,
    this.name,
    this.favoriteIconButton,
    this.onPressedFavoriteIcon,
    this.onPressedCard,
    this.subtitle,
    this.image,
  });
}

typedef OnPressedFavoriteIcon = Function(HeroCardModel cardModel, BuildContext context);
