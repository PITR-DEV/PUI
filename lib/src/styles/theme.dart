import 'package:flutter/material.dart';

// extension
extension ThemePUI on ThemeData {
  ThemeData applyPUI({
    TargetPlatform? overrideThemePlatform = TargetPlatform.windows,
  }) {
    final genericTextColor = colorScheme.onSurface;
    final genericTextStyle = TextStyle(
      color: genericTextColor,
      fontFamily: 'packages/pui/Albert Sans',
      fontWeight: FontWeight.w500,
    );

    return copyWith(
      colorScheme: colorScheme,
      platform: overrideThemePlatform,
      textTheme: textTheme.copyWith(
        headlineSmall: genericTextStyle.copyWith(
          fontSize: 16,
        ),
        headlineMedium: genericTextStyle.copyWith(
          fontSize: 20,
        ),
        headlineLarge: genericTextStyle.copyWith(
          fontSize: 24,
        ),
        displaySmall: genericTextStyle.copyWith(
          fontSize: 19,
          fontWeight: FontWeight.w600,
        ),
        displayMedium: genericTextStyle.copyWith(
          fontSize: 36,
          fontWeight: FontWeight.w600,
        ),
        displayLarge: genericTextStyle.copyWith(
          fontSize: 48,
          fontWeight: FontWeight.w600,
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
        labelStyle: genericTextStyle.copyWith(
          color: colorScheme.onBackground.withOpacity(0.9),
          fontWeight: FontWeight.w100,
          fontSize: 15,
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
      appBarTheme: appBarTheme.copyWith(
        backgroundColor: colorScheme.background,
        foregroundColor: colorScheme.onBackground,
        titleTextStyle: genericTextStyle.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: iconTheme.copyWith(
          color: colorScheme.onBackground,
        ),
      ),
      sliderTheme: sliderTheme.copyWith(
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
        trackHeight: 5,
      ),
    );
  }
}
