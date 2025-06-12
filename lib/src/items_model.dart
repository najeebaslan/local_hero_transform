/*File : local_hero_transform
Version : 1.0.5
*/

import 'package:flutter/material.dart' show BuildContext, ImageChunkEvent, Widget;
import 'package:flutter/widgets.dart' show DecorationImage;

import 'card_style_mode.dart';

/// Data model for hero card content and styling.
///
/// This model contains all the necessary information to build a card,
/// including text content, images, and favorite button.
class ItemsModel {
  /// Creates a HeroCardModel.
  ///
  /// Required parameters:
  /// - [name]: Widget that returns the name Text widget for a given index
  /// - [title]: Widget that returns the title Text widget
  /// - [subTitle]: Widget that returns the subtitle Text widget
  /// - [subTitleIcon]: Widget that returns the subtitle Icon widget
  /// - [image]: Widget that returns the DecorationImage for a given index
  /// - [favoriteIconButton]: Function that returns the favorite icon widget
  /// - [cardStyleMode]: Widget that returns the card style
  ///
  const ItemsModel({
    required this.name,
    required this.title,
    required this.image,
    required this.subTitle,
    this.subTitleIcon,
    this.cardStyleMode,
    this.loadingImageBuilder,
    required this.favoriteIconButton,
  });

  final Widget name;
  final Widget title;
  final Widget subTitle;
  final Widget favoriteIconButton;
  final Widget? subTitleIcon;
  final DecorationImage image;
  final Widget Function(BuildContext context, Widget child, ImageChunkEvent? loadingProgress)?
      loadingImageBuilder;
  final CardStyleMode? cardStyleMode;
}
