import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pui/src/models/navigation_tab.dart';

class NavigationSideRail extends StatelessWidget {
  const NavigationSideRail({
    required this.routerState,
    required this.routes,
    this.leading,
    super.key,
  });

  final Widget? leading;
  final GoRouterState routerState;
  final List<NavigationTab> routes;

  static NavigationRailDestination get blankDestination =>
      const NavigationRailDestination(
        icon: SizedBox.shrink(),
        selectedIcon: SizedBox.shrink(),
        label: SizedBox.shrink(),
        disabled: true,
        padding: EdgeInsets.zero,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final location = routerState.fullPath ?? routerState.matchedLocation;
    var filteredRoutes = routes;

    filteredRoutes = filteredRoutes
        .where((tab) => !tab.hideWhenInactive || _isMatch(location, tab))
        .toList(growable: false);

    var destinations = filteredRoutes
        .map(
          (e) => NavigationRailDestination(
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
            label: Text(
              e.label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context)
                    .colorScheme
                    .onSecondaryContainer
                    .withOpacity(0.9),
                fontSize: 11,
              ),
            ),
            disabled: !e.clickable,
          ),
        )
        .toList();

    if (destinations.length < 2) {
      destinations = [
        ...destinations,
        blankDestination,
        if (filteredRoutes.isEmpty) blankDestination,
      ];
    }

    return NavigationRail(
      labelType: NavigationRailLabelType.selected,
      leading: buildLeading(),
      destinations: destinations,
      selectedIndex:
          filteredRoutes.indexWhere((element) => _isMatch(location, element)),
      onDestinationSelected: (index) {
        context.go(filteredRoutes[index].routeStart);
      },
    );
  }

  Widget? buildLeading() {
    if (leading == null) return null;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: leading,
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
