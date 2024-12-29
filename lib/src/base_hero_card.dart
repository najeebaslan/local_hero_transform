/*File : local_hero_transform
Version : 0.0.1
*/
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'hero_card_model.dart';

class BaseFavoriteCard extends StatelessWidget {
  final BaseHeroCardParameters parameters;
  const BaseFavoriteCard({super.key, required this.parameters});

  @override
  Widget build(BuildContext context) {
    bool isRtl = parameters.textDirection == TextDirection.rtl;
    BaseHeroCardOptionalParameters? optionalParams = parameters.optionalParameters;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: parameters.heightImage),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Color(0xFF3A5160).withValues(alpha: 0.1),
              offset: const Offset(0, 5),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0.r),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        child: Stack(
          children: [
            optionalParams?.imageWidget ??
                _buildImage(
                  height: parameters.heightImage,
                  width: parameters.widthImage,
                ),
            Positioned(
              top: parameters.favoriteIconHeightPosition.abs(),
              right: isRtl ? parameters.favoriteIconPosition : null,
              left: !isRtl ? parameters.favoriteIconPosition : null,
              child: optionalParams?.favoriteIconButton ??
                  IconButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Colors.redAccent,
                      ),
                    ),
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: optionalParams?.onPressedFavoriteIcon,
                  ),
            ),
            Positioned(
              bottom: parameters.bottomTitle,
              right: isRtl ? parameters.rightTitle : 10.w,
              left: !isRtl ? parameters.rightTitle : 10.w,
              child: optionalParams?.nameWidget ??
                  Row(
                    children: [
                      Text(
                        parameters.cardModel.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
            ),
            Positioned(
              bottom: (parameters.bottomTitle / 1.6).h,
              right: isRtl ? parameters.rightPrice : null,
              left: !isRtl ? parameters.rightPrice : null,
              child: optionalParams?.titleWidget ??
                  RichText(
                    text: TextSpan(
                      text: parameters.cardModel.title.toString(),
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        WidgetSpan(child: SizedBox(width: 3.w)),
                        TextSpan(
                          text: 'sar',
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
            Positioned(
              bottom: parameters.bottomTitle / 6,
              right: isRtl ? parameters.rightPrice : null,
              left: !isRtl ? parameters.rightPrice : null,
              child: optionalParams?.subtitleWidget ?? _buildSubTitle(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage({double? height, double? width}) {
    return Padding(
      padding: EdgeInsets.all(8.0.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Image.network(
          parameters.cardModel.imageUrl,
          height: height?.h ?? 200,
          width: width?.w ?? 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Row _buildSubTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.location_on_outlined,
          color: const Color(0xFF95979A),
          size: 10,
        ),
        SizedBox(width: 1.w),
        Text(
          parameters.cardModel.name,
          style: TextStyle(
            color: const Color(0xFF95979A),
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class BaseHeroCardParameters {
  final int index;
  final double heightImage;
  final double widthImage;
  final double bottomTitle;
  final double rightTitle;
  final double rightPrice;
  final double favoriteIconPosition;
  final double favoriteIconHeightPosition;
  final HeroCardModel cardModel;
  final TextDirection textDirection;
  final BaseHeroCardOptionalParameters? optionalParameters;
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

class BaseHeroCardOptionalParameters {
  final Widget? titleWidget;
  final Widget? nameWidget;
  final Widget? favoriteIconButton;
  final VoidCallback? onPressedFavoriteIcon;
  final Widget? subtitleWidget;
  final Widget? imageWidget;

  BaseHeroCardOptionalParameters({
    this.titleWidget,
    this.nameWidget,
    this.favoriteIconButton,
    this.onPressedFavoriteIcon,
    this.subtitleWidget,
    this.imageWidget,
  });
}
