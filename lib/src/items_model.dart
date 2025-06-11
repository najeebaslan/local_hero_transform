/*File : local_hero_transform
Version : 1.0.3
*/

import 'package:flutter/material.dart' show Widget;
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
    required this.favoriteIconButton,
  });

  final Widget name;
  final Widget title;
  final Widget subTitle;
  final Widget favoriteIconButton;
  final Widget? subTitleIcon;
  final DecorationImage image;
  final CardStyleMode? cardStyleMode;
}
