import 'package:flutter/material.dart';

// extension
extension ThemePUI on ThemeData {
  ThemeData applyPUI({
    TargetPlatform? overrideThemePlatform = TargetPlatform.windows,
  }) {
    final genericTextColor = colorScheme.onSurface;

    return copyWith(
      colorScheme: colorScheme,
      platform: overrideThemePlatform,
      textTheme: textTheme.copyWith(
        headlineSmall: TextStyle(
          color: genericTextColor,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        headlineMedium: TextStyle(
          color: genericTextColor,
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
        headlineLarge: TextStyle(
          color: genericTextColor,
          fontWeight: FontWeight.w500,
          fontSize: 24,
        ),
        displaySmall: TextStyle(
          color: genericTextColor,
          fontWeight: FontWeight.w500,
          fontSize: 19,
        ),
        displayMedium: TextStyle(
          color: genericTextColor,
          fontWeight: FontWeight.w500,
          fontSize: 36,
        ),
        displayLarge: TextStyle(
          color: genericTextColor,
          fontWeight: FontWeight.w500,
          fontSize: 48,
        ),
      ),
      inputDecorationTheme: inputDecorationTheme.copyWith(
        filled: true,
        fillColor: colorScheme.shadow.withOpacity(0.2),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.onBackground.withOpacity(0.2),
          ),
        ),
        hintStyle: TextStyle(
          color: colorScheme.onBackground.withOpacity(0.35),
          fontWeight: FontWeight.w400,
        ),
      ),
      dialogTheme: dialogTheme.copyWith(
        backgroundColor: colorScheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: colorScheme.outline.withOpacity(0.6),
          ),
        ),
        titleTextStyle: TextStyle(
          color: colorScheme.onSecondaryContainer,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        contentTextStyle: TextStyle(
          color: colorScheme.onSecondaryContainer,
          fontWeight: FontWeight.w400,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: (filledButtonTheme.style ?? const ButtonStyle()).copyWith(
          shape: MaterialStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: BorderSide(
                color: colorScheme.secondary.withOpacity(0.7),
                strokeAlign: -1,
                width: 1,
              ),
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: (outlinedButtonTheme.style ?? const ButtonStyle()).copyWith(
          shape: MaterialStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: BorderSide(
                color: colorScheme.secondary.withOpacity(0.7),
                strokeAlign: -1,
                width: 1,
              ),
            ),
          ),
          foregroundColor: MaterialStatePropertyAll<Color>(
            colorScheme.onSecondaryContainer,
          ),
        ),
      ),
    );
  }
}
