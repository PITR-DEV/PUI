import 'package:flutter/material.dart';

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

    var updatedTheme = copyWith(
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
        bodySmall: genericTextStyle.copyWith(
          fontSize: 12,
        ),
        bodyMedium: genericTextStyle.copyWith(
          fontSize: 15,
        ),
        bodyLarge: genericTextStyle.copyWith(
          fontSize: 17,
        ),
      ),
      inputDecorationTheme: inputDecorationTheme.copyWith(
        filled: true,
        fillColor: colorScheme.shadow.withValues(alpha: 0.2),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorScheme.onSurface.withValues(alpha: 0.2),
          ),
        ),
        hintStyle: TextStyle(
          color: colorScheme.onSurface.withValues(alpha: 0.35),
          fontWeight: FontWeight.w400,
        ),
        labelStyle: genericTextStyle.copyWith(
          color: colorScheme.onSurface.withValues(alpha: 0.9),
          fontWeight: FontWeight.w100,
          fontSize: 15,
        ),
      ),
      dialogTheme: dialogTheme.copyWith(
        backgroundColor: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.6),
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
      textButtonTheme: TextButtonThemeData(
        style: (filledButtonTheme.style ?? const ButtonStyle()).copyWith(
          shape: WidgetStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: BorderSide(
                color: colorScheme.outline.withValues(alpha: 0.2),
                strokeAlign: -1,
                width: 1,
              ),
            ),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: (filledButtonTheme.style ?? const ButtonStyle()).copyWith(
          shape: WidgetStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: BorderSide(
                color: colorScheme.secondary.withValues(alpha: 0.4),
                strokeAlign: -1,
                width: 1,
              ),
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: (outlinedButtonTheme.style ?? const ButtonStyle()).copyWith(
          shape: WidgetStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: BorderSide(
                color: colorScheme.secondary.withValues(alpha: .7),
                strokeAlign: -1,
                width: 1,
              ),
            ),
          ),
          foregroundColor: WidgetStatePropertyAll<Color>(
            colorScheme.onSecondaryContainer,
          ),
        ),
      ),
      appBarTheme: appBarTheme.copyWith(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: genericTextStyle.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: iconTheme.copyWith(
          color: colorScheme.onSurface,
        ),
      ),
      sliderTheme: sliderTheme.copyWith(
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
        trackHeight: 5,
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
      ),
    );

    if (updatedTheme.brightness == Brightness.light) {
      updatedTheme = _applyLightTheme(updatedTheme);
    } else {
      updatedTheme = _applyDarkTheme(updatedTheme);
    }

    return updatedTheme;
  }

  ThemeData _applyLightTheme(ThemeData theme) {
    return theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
        outline: theme.colorScheme.outline.withAlpha(191),
      ),
    );
  }

  ThemeData _applyDarkTheme(ThemeData theme) {
    final darkerColor = Color.lerp(colorScheme.surface, Colors.black, 0.15);

    return theme.copyWith(
      scaffoldBackgroundColor: darkerColor,
      colorScheme: theme.colorScheme.copyWith(),
    );
  }
}
