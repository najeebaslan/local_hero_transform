/* File: local_hero_transform
   Version: 1.0.1
*/

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_hero_transform/src/utils.dart'
    show CustomOnPressedFavoriteIcon, paddingHorizontal, paddingVertical;

import 'items_model.dart' show ItemsModel;

/// The base widget that builds the actual card content.
///
/// This is used by both CardGrid and CustomCardListView to maintain
/// consistent appearance while allowing different layouts.
class BaseHeroCard extends StatelessWidget {
  /// Creates a BaseView widget.
  ///
  /// Required parameters:
  /// - [heightImage]: Height of the image area
  /// - [index]: Index of this card
  /// - [itemsModel]: Data model for the card
  /// - [widthImage]: Width of the image area
  /// - [bottomTitle]: Bottom position for title
  /// - [rightTitle]: Right position for title
  /// - [rightPrice]: Right position for price
  /// - [favoriteIconPosition]: Position of favorite icon
  /// - [favoriteIconHeightPosition]: Height position of favorite icon
  /// - [textDirection]: Text direction for layout
  /// - [cardWidth]: Width of the card
  /// - [onPressedCard]: Callback when card is pressed
  const BaseHeroCard({
    super.key,
    required this.heightImage,
    required this.index,
    required this.itemsModel,
    required this.widthImage,
    required this.bottomTitle,
    required this.rightTitle,
    required this.rightPrice,
    required this.favoriteIconPosition,
    required this.favoriteIconHeightPosition,
    required this.textDirection,
    required this.cardWidth,
    required this.onPressedCard,
  });

  final int index;
  final double heightImage;
  final ItemsModel itemsModel;
  final double widthImage;
  final double bottomTitle;
  final double rightTitle;
  final double rightPrice;
  final double favoriteIconPosition;
  final double favoriteIconHeightPosition;
  final TextDirection textDirection;
  final double cardWidth;
  final CustomOnPressedFavoriteIcon onPressedCard;

  @override
  Widget build(BuildContext context) {
    final isRtl = textDirection == TextDirection.rtl;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: heightImage.h),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: const Color(0xFF3A5160).withValues(alpha: 0.1),
              offset: const Offset(0, 5),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0.r),
        ),
        margin: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
        child: InkWell(
          onTap: () => _onPassedCard(index, context),
          child: Stack(
            children: [
              // Name text
              Positioned(
                bottom: bottomTitle,
                right: isRtl ? rightTitle : 10.w,
                left: !isRtl ? rightTitle : 10.w,
                child: _buildTextWidget(itemsModel.name),
              ),

              // Title text
              Positioned(
                width: cardWidth * 0.8,
                bottom: (bottomTitle / 1.7),
                right: isRtl ? rightPrice : null,
                left: !isRtl ? rightPrice : null,
                child: Row(
                  children: [
                    Expanded(child: _buildTextWidget(itemsModel.title)),
                  ],
                ),
              ),

              // Subtitle with location icon
              Positioned(
                bottom: bottomTitle / 6,
                width: cardWidth * 0.8,
                right: isRtl ? rightPrice : null,
                left: !isRtl ? rightPrice : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (itemsModel.subTitleIcon != null) itemsModel.subTitleIcon!,
                    SizedBox(width: 1.w),
                    Flexible(child: _buildTextWidget(itemsModel.subTitle)),
                  ],
                ),
              ),

              _buildImage(),

              _buildFavoriteButton(isRtl, context),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a Text widget from the given properties
  Widget _buildTextWidget(Text textWidget) {
    return Text(
      textWidget.data ?? '',
      style: textWidget.style?.copyWith(
        fontSize: textWidget.style?.fontSize?.sp,
      ),
      maxLines: 1,
      locale: textWidget.locale,
      overflow: TextOverflow.ellipsis,
      key: textWidget.key,
      selectionColor: textWidget.selectionColor,
      semanticsLabel: textWidget.semanticsLabel,
      softWrap: textWidget.softWrap,
      strutStyle: textWidget.strutStyle,
      textAlign: textWidget.textAlign,
      textDirection: textWidget.textDirection,
      textHeightBehavior: textWidget.textHeightBehavior,
      textScaler: textWidget.textScaler,
      textWidthBasis: textWidget.textWidthBasis,
    );
  }

  /// Builds the image portion of the card
  Widget _buildImage() {
    return Padding(
      padding: EdgeInsets.all(8.0.w),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: heightImage.h,
          minWidth: widthImage.w,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Image(
            height: heightImage.h,
            width: widthImage.w,
            fit: BoxFit.cover,
            image: itemsModel.image.image,
            alignment: itemsModel.image.alignment,
            errorBuilder: (context, error, stackTrace) {
              return ColoredBox(
                color: Colors.grey.shade100,
                child: Icon(
                  Icons.error,
                  color: Colors.grey,
                  size: 30.w,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Builds the favorite button
  Positioned _buildFavoriteButton(bool isRtl, BuildContext context) {
    // log(itemsModel.favoriteIconButton.key.)
    return Positioned(
      top: favoriteIconHeightPosition.abs(),
      right: isRtl ? favoriteIconPosition : null,
      left: !isRtl ? favoriteIconPosition : null,
      child: itemsModel.favoriteIconButton,
    );
  }

  void _onPassedCard(int index, BuildContext context) {
    onPressedCard(index);
  }
}
