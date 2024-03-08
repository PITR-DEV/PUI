import 'package:flutter/material.dart';

class NavigationTab {
  IconData icon;
  String label;
  String routeStart;
  bool exact;
  bool clickable;
  bool hideWhenInactive;
  bool alwaysHidden;

  NavigationTab({
    required this.icon,
    required this.label,
    required this.routeStart,
    this.exact = true,
    this.clickable = true,
    this.hideWhenInactive = false,
    this.alwaysHidden = false,
  });
}
