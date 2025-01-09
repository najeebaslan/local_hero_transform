/* File: local_hero_transform
   Version: 0.0.3
*/

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// LocalHero widget that provides a tabbed navigation with smooth transitions.
class LocalHero extends StatefulWidget {
  final List<Widget> pages; // List of pages (widgets) to display in the tab view.

  /// TabController is required to manage the tab selection.
  final TabController controller;

  /// Duration for transition animations.
  /// The value by default Duration(milliseconds: 1100)
  final Duration? transitionDuration;

  /// Design size for responsive UI.
  /// The value by default Size(428, 926)
  final Size? designSize;

  /// Constructor for LocalHero, requiring pages and controller.
  const LocalHero({
    super.key,
    this.designSize,
    required this.pages,
    required this.controller,
    this.transitionDuration,
  });

  @override
  State<LocalHero> createState() => _LocalHeroState();
}

class _LocalHeroState extends State<LocalHero> {
  late TabController _controller; // Local TabController for managing tab states.
  final _navigatorKey = GlobalKey<NavigatorState>(); // Key for the nested navigator.
  int? _lastIndex; // Track the last tab index for comparison.

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Resolve the TabController from the widget.
    final resolvedController = widget.controller;
    _controller = resolvedController;

    // Add a listener to the controller to monitor tab changes.
    _controller.addListener(_switchPage);
    _lastIndex = _controller.index; // Initialize the last index with the current index.
  }

  @override
  void dispose() {
    // Clean up the listener on the controller when the widget is disposed.
    _controller.removeListener(_switchPage);
    super.dispose();
  }

  // Method to switch pages based on the selected tab.
  void _switchPage() {
    if (_controller.index != _lastIndex) {
      // Proceed only if the tab index has changed.
      _lastIndex = _controller.index; // Update the last index.
      // Navigate to the new page corresponding to the selected tab index.
      _navigatorKey.currentState!.pushReplacementNamed('${_controller.index}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build the widget tree using a nested Navigator for tab transitions.
    return ScreenUtilInit(
      designSize:
          widget.designSize ?? const Size(428, 926), // Set design size for responsive layout.
      minTextAdapt: true, // Allow text to adapt to screen size.
      enableScaleText: () => false, // Disable text scaling.
      splitScreenMode: true, // Enable split screen mode for responsive design.
      builder: (context, child) {
        return Navigator(
          key: _navigatorKey, // Key for the nested navigator.
          initialRoute:
              '${_controller.index}', // Set the initial route based on the current tab index.
          // Add HeroController to manage hero animations in a nested navigator.
          observers: [HeroController()],
          onGenerateRoute: (settings) => PageRouteBuilder(
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              // Determine if the transition is for the next or previous tab.
              final isAnimatingNext = _controller.index > _controller.previousIndex;

              // Define tween animations for right-to-middle transitions.
              final rightMiddleTween = Tween<Offset>(
                begin: isAnimatingNext ? const Offset(1, 0) : Offset.zero,
                end: isAnimatingNext ? Offset.zero : const Offset(1, 0),
              );

              // Define tween animations for middle-to-left transitions.
              final middleLeftTween = Tween<Offset>(
                begin: isAnimatingNext ? Offset.zero : const Offset(-1, 0),
                end: isAnimatingNext ? const Offset(-1, 0) : Offset.zero,
              );

              // Function to apply easing to animations.
              Animation<double> applyEasing(Animation<double> animation) =>
                  CurvedAnimation(parent: animation, curve: Curves.ease);

              // Return a combined SlideTransition for the animations.
              return SlideTransition(
                position: rightMiddleTween.animate(applyEasing(animation)),
                child: SlideTransition(
                  position: middleLeftTween.animate(applyEasing(secondaryAnimation)),
                  child: child, // The child widget to be animated.
                ),
              );
            },
            // Set the duration for the transition animation.
            transitionDuration: widget.transitionDuration ?? const Duration(milliseconds: 1100),
            pageBuilder: (context, animation, secondaryAnimation) {
              // Return the page corresponding to the current tab index.
              return widget.pages[int.parse(settings.name!)];
            },
          ),
        );
      },
    );
  }
}
