import 'package:flutter/material.dart';
import 'package:local_hero_transform/src/base_hero_card.dart';
import 'package:local_hero_transform/src/items_model.dart';
import 'package:local_hero_transform/src/text_height_calculator.dart' show TextHeightCalculator;

import '../local_hero_transform.dart' show LocalHero;
import 'card_grid_view.dart' show CardGridView;
import 'card_list_view.dart' show CardListView;
import 'local_hero.dart' show LocalHero;

/// A widget that displays items in either grid or list view with hero animations.
///
/// This widget provides a tabbed interface where users can switch between:
/// - Grid view (first tab)
/// - List view (second tab)
///
/// All transitions between views are animated using Hero widgets.
class LocalHeroViews extends StatefulWidget {
  /// Creates a LocalHeroViews widget.
  ///
  /// Required parameters:
  /// - [itemCount]: Number of items to display
  /// - [itemsModel]: Data model for each card
  /// - [tabController]: Controls the tab view
  /// - [onPressedCard]: Callback when a card is pressed
  ///
  /// Optional parameters:
  /// - [designSize]: Design size for responsive UI.The value by default Size(428, 926)
  /// - [transitionDuration]:Duration for transition animations.  The value by default Duration(milliseconds: 1100)
  /// - [textDirection]: Text direction (defaults to ltr)
  const LocalHeroViews({
    super.key,
    required this.itemCount,
    required this.itemsModel,
    required this.tabController,
    required this.onPressedCard,
    this.designSize,
    this.transitionDuration,
    this.textDirection = TextDirection.ltr,
  });

  final Size? designSize;
  final int itemCount;
  final ItemsModel Function(int index) itemsModel;
  final TextDirection textDirection;
  final TabController tabController;
  final Duration? transitionDuration;
  final CustomOnPressedFavoriteIcon onPressedCard;

  @override
  State<LocalHeroViews> createState() => _LocalHeroViewsState();
}

class _LocalHeroViewsState extends State<LocalHeroViews> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // Calculate text height based on card content
    final textHeight = TextHeightCalculator(
          itemsModel: widget.itemsModel(0),
          textDirection: widget.textDirection,
        ).calculateHeight() *
        2;

    return LocalHero(
      controller: widget.tabController,
      pages: [
        // Grid View Tab
        GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 16 / 21.5,
          padding: const EdgeInsets.all(8.0),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: List.generate(widget.itemCount, (index) {
            return CardGridView(
              onPressedCard: widget.onPressedCard,
              index: index,
              itemsModel: widget.itemsModel(index),
              tagHero: index,
              textHeight: textHeight,
              textDirection: widget.textDirection,
            );
          }),
        ),

        // List View Tab
        ListView.builder(
          padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
          itemCount: widget.itemCount,
          itemBuilder: (context, index) {
            return CardListView(
              onPressedCard: widget.onPressedCard,
              index: index,
              itemsModel: widget.itemsModel(index),
              tagHero: index.toString(),
              textHeight: textHeight,
              textDirection: widget.textDirection,
            );
          },
        ),
      ],
    );
  }
}
