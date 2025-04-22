/*File : local_hero_transform
Version : 1.0.2
*/

import 'package:flutter/material.dart' show Text, Widget;
import 'package:flutter/widgets.dart' show DecorationImage;

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
  const ItemsModel({
    required this.name,
    required this.title,
    required this.image,
    required this.subTitle,
    this.subTitleIcon,
    required this.favoriteIconButton,
  });

  final Text name;
  final Text title;
  final Text subTitle;
  final Widget favoriteIconButton;
  final Widget? subTitleIcon;
  final DecorationImage image;
}
