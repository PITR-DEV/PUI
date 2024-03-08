import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:layout/layout.dart';
import 'package:pui/pui.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({
    required this.routes,
    required this.routerState,
    required this.child,
    this.appBar,
    this.showAppBar = true,
    this.drawer,
    this.endDrawer,
    this.desktopRailBottomItems,
    this.bottomBar,
    this.bottomBarHeight = 32,
    this.showBottomBar = true,
    this.borderColor,
    super.key,
  });
  final List<NavigationTab> routes;
  final GoRouterState routerState;

  final Widget child;

  final Widget? appBar;
  final bool showAppBar;

  final Widget? drawer;
  final Widget? endDrawer;

  final List<Widget>? desktopRailBottomItems;

  final Widget? bottomBar;
  final double bottomBarHeight;
  final bool showBottomBar;

  final Color? borderColor;

  @override
  createState() => _AppPageState();
}

class _AppPageState extends State<AppNavigation> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final isMobileLayout = context.breakpoint < LayoutBreakpoint.sm;
    final showAppbar = widget.appBar != null && widget.showAppBar;

    final colorScheme = Theme.of(context).colorScheme;
    final darkerColor = Color.lerp(colorScheme.background, Colors.black, 0.15);
    final subPageTheme = Theme.of(context).copyWith(
      scaffoldBackgroundColor: darkerColor,
      appBarTheme: Theme.of(context).appBarTheme.copyWith(
            backgroundColor: darkerColor,
          ),
    );

    final borderColor =
        widget.borderColor ?? colorScheme.outline.withOpacity(0.2);

    final showBottomBar = widget.showBottomBar && widget.bottomBar != null;

    const borderRadius = 7.0;
    final animationDuration = 100.milliseconds;
    const animationCurve = Curves.linear;

    return Material(
      color: Theme.of(context).colorScheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: _scaffoldKey,
        endDrawer: widget.endDrawer,
        bottomNavigationBar: isMobileLayout
            ? AnimatedContainer(
                duration: animationDuration,
                curve: animationCurve,
                height: showAppbar ? kToolbarHeight * 1.15 : 0,
                child: MobileNavigationBar(
                  routerState: widget.routerState,
                  routes: widget.routes,
                ),
              )
            : null,
        body: SafeArea(
          child: Column(
            children: [
              AnimatedContainer(
                height: showAppbar ? kToolbarHeight : 0,
                duration: animationDuration,
                curve: animationCurve,
                child: widget.appBar,
              ),
              Expanded(
                child: Row(
                  children: [
                    if (!isMobileLayout)
                      Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 21),
                              child: NavigationSideRail(
                                routerState: widget.routerState,
                                routes: widget.routes,
                              ),
                            ),
                          ),
                          if (widget.desktopRailBottomItems != null)
                            for (final item in widget.desktopRailBottomItems!)
                              item,
                        ],
                      ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: isMobileLayout ? 0 : 1,
                                    left: isMobileLayout ? 0 : 1,
                                  ),
                                  child: Theme(
                                    data: subPageTheme,
                                    child: widget.child,
                                  )
                                      .animate(
                                        target: showBottomBar ? 1 : 0,
                                      )
                                      .custom(
                                        curve: animationCurve,
                                        duration: animationDuration,
                                        builder: (context, value, child) {
                                          return ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: isMobileLayout
                                                  ? Radius.zero
                                                  : Radius.circular(
                                                      borderRadius * value,
                                                    ),
                                            ),
                                            child: child,
                                          );
                                        },
                                      )
                                      .animate(
                                        target: showAppbar ? 1 : 0,
                                      )
                                      .custom(
                                        curve: animationCurve,
                                        duration: animationDuration,
                                        builder: (context, value, child) {
                                          return ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: isMobileLayout
                                                  ? Radius.zero
                                                  : Radius.circular(
                                                      borderRadius * value),
                                            ),
                                            child: child,
                                          );
                                        },
                                      ),
                                ),
                                AnimatedPositioned(
                                  top: -8 + (8 * (showAppbar ? 1 : 0)),
                                  bottom: -8 + (8 * (showBottomBar ? 1 : 0)),
                                  right: -8,
                                  left: 0,
                                  duration: animationDuration,
                                  curve: animationCurve,
                                  child: IgnorePointer(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: borderColor,
                                          width: 1,
                                        ),
                                        borderRadius: isMobileLayout
                                            ? BorderRadius.zero
                                            : BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: widget.bottomBarHeight,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: widget.bottomBar,
                          )
                              .animate(
                                target: showBottomBar ? 1 : 0,
                              )
                              .custom(
                                curve: animationCurve,
                                duration: animationDuration,
                                builder: (context, value, child) {
                                  final targetHeight = widget.bottomBarHeight;
                                  return SizedBox(
                                    height: targetHeight * value,
                                    child: child,
                                  );
                                },
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
