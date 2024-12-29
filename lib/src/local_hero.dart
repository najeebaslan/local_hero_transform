/*File : local_hero_transform
Version : 0.0.1
*/
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocalHero extends StatefulWidget {
  final List<Widget> pages;

  // Just like a normal TabView, you need to either have a parent
  // DefaultTabController or pass a TabController.
  final TabController controller;
  final Duration? transitionDuration;
  final Size? designSize;
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
  late TabController _controller;
  final _navigatorKey = GlobalKey<NavigatorState>();
  int? _lastIndex; // Track the last tab index

  @override
  void didChangeDependencies() {
    final resolvedController = widget.controller;
    _controller = resolvedController;
    _controller.addListener(_switchPage);
    _lastIndex = _controller.index; // Initialize last index

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.removeListener(_switchPage);
    super.dispose();
  }

  void _switchPage() {
    if (_controller.index != _lastIndex) {
      // Only proceed if the index has changed
      _lastIndex = _controller.index; // Update last index
      // Use the route's name as the index of the page to switch to.
      _navigatorKey.currentState!.pushReplacementNamed('${_controller.index}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use a nested Navigator so that switching tabs involves pushing a
    // new page onto a Navigator stack without changing the general
    // navigation state of your app.
    return ScreenUtilInit(
      designSize: widget.designSize ?? const Size(428, 926),
      minTextAdapt: true,
      enableScaleText: () => false,
      splitScreenMode: true,
      builder: (context, child) {
        return Navigator(
          key: _navigatorKey,
          initialRoute: '${_controller.index}',
          // This is required in order to make Hero animations work in a
          // nested navigator.
          observers: [HeroController()],
          onGenerateRoute: (settings) => PageRouteBuilder(
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              final isAnimatingNext = _controller.index > _controller.previousIndex;

              // Animates the page when it moves between the middle of the screen and the right of the screen.
              final rightMiddleTween = Tween<Offset>(
                begin: isAnimatingNext ? const Offset(1, 0) : Offset.zero,
                end: isAnimatingNext ? Offset.zero : const Offset(1, 0),
              );

              // Animates the page when it moves between the middle of the screen and the left of the screen.
              final middleLeftTween = Tween<Offset>(
                begin: isAnimatingNext ? Offset.zero : const Offset(-1, 0),
                end: isAnimatingNext ? const Offset(-1, 0) : Offset.zero,
              );
              Animation<double> applyEasing(Animation<double> animation) =>
                  CurvedAnimation(parent: animation, curve: Curves.ease);

              return SlideTransition(
                position: rightMiddleTween.animate(applyEasing(animation)),
                child: SlideTransition(
                  position: middleLeftTween.animate(applyEasing(secondaryAnimation)),
                  child: child,
                ),
              );
            },
            transitionDuration: widget.transitionDuration ?? const Duration(milliseconds: 1000),
            pageBuilder: (context, animation, secondaryAnimation) {
              return widget.pages[int.parse(settings.name!)];
            },
          ),
        );
      },
    );
  }
}
