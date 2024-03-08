import 'package:example/app.dart';
import 'package:example/pages/hidden.dart';
import 'package:example/pages/home.dart';
import 'package:example/pages/navigation.dart';
import 'package:example/pages/noise.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:pui/pui.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

List<NavigationTab> get navigationTabs => [
      NavigationTab(
        icon: Symbols.home,
        label: 'Home',
        routeStart: '/',
        exact: true,
      ),
      NavigationTab(
        icon: Symbols.navigation,
        label: 'Navigation',
        routeStart: '/navigation',
        exact: true,
      ),
      NavigationTab(
        icon: Symbols.visibility_off,
        label: 'Hidden',
        routeStart: '/hidden',
        exact: true,
        hideWhenInactive: true,
      ),
      NavigationTab(
        icon: Symbols.hive,
        label: 'Noise',
        routeStart: '/noise',
        exact: true,
      ),
    ];

List<ShellRouteBase> get routes => [
      ShellRoute(
        builder: (context, state, child) => AppPage(
          state: state,
          navigationTabs: navigationTabs,
          child: child,
        ),
        routes: subRoutes,
      ),
    ];

List<RouteBase> get subRoutes => [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/navigation',
        builder: (context, state) => const NavigationPage(),
      ),
      GoRoute(
        path: '/hidden',
        builder: (context, state) => const HiddenPage(),
      ),
      GoRoute(
        path: '/noise',
        builder: (context, state) => const NoisePage(),
      ),
    ];

GoRouter getRouterConfig = GoRouter(
  initialLocation: '/',
  routes: routes,
  errorBuilder: (context, state) => FourOhFourPage(
    state: state,
    debug: kDebugMode,
  ),
  navigatorKey: _rootNavigatorKey,
);
