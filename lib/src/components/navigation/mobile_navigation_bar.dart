import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pui/pui.dart';

class MobileNavigationBar extends StatelessWidget {
  const MobileNavigationBar({
    required this.routerState,
    required this.routes,
    super.key,
  });
  final GoRouterState routerState;
  final List<NavigationTab> routes;

  @override
  Widget build(BuildContext context) {
    final location = routerState.fullPath ?? routerState.matchedLocation;
    var filteredRoutes = routes;

    filteredRoutes = filteredRoutes
        .where((tab) => !tab.hideWhenInactive || _isMatch(location, tab))
        .toList(growable: false);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withAlpha(120),
            width: 0.5,
          ),
        ),
      ),
      child: NavigationBar(
        destinations: filteredRoutes
            .map(
              (e) => NavigationDestination(
                icon: Icon(
                  e.icon,
                  color: Theme.of(context)
                      .colorScheme
                      .onSecondaryContainer
                      .withOpacity(0.9),
                ),
                selectedIcon: Icon(
                  e.icon,
                  fill: 1,
                  color: Theme.of(context)
                      .colorScheme
                      .onSecondaryContainer
                      .withOpacity(0.9),
                ),
                label: e.label,
              ),
            )
            .toList(),
        selectedIndex: filteredRoutes.indexWhere((e) => _isMatch(location, e)),
        onDestinationSelected: (index) {
          final route = filteredRoutes[index];
          if (route.clickable) {
            context.go(filteredRoutes[index].routeStart);
          }
        },
      ),
    );
  }

  bool _isMatch(String location, NavigationTab tab) {
    final routeStart = tab.routeStart;

    if (tab.exact) return location == routeStart;
    if (routeStart.length == 1) return location == routeStart;

    final routeSplit = routeStart.split('/');
    final locationSplit = location.split('/');
    if (routeSplit.length != locationSplit.length) return false;

    return location.startsWith(routeStart);
  }
}
