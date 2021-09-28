import 'package:flutter/material.dart';

class AppTheme {
  static final themeLight = themeData(colorSchemeLight);
  static final themeDark = themeData(colorSchemeDark);

  static ThemeData themeData(ColorScheme colorScheme) {
    final bool isDark = colorScheme.brightness == Brightness.dark;
    final iconTheme = isDark
        ? const IconThemeData(color: Colors.white)
        : const IconThemeData(color: Colors.black87);

    return ThemeData(
      iconTheme: iconTheme,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      primaryColor: colorScheme.primary,
      primaryColorLight: colorScheme.primaryVariant,
      primaryColorDark: colorScheme.primaryVariant,
      errorColor: colorScheme.error,
      toggleableActiveColor: colorScheme.primary,
      unselectedWidgetColor: colorScheme.onSurface,
      cardColor: colorScheme.surface,
      backgroundColor: colorScheme.background,
      dialogBackgroundColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.background,
      canvasColor: colorScheme.background,
      inputDecorationTheme: const InputDecorationTheme(filled: true),
      bottomSheetTheme: const BottomSheetThemeData(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
    );
  }

  static const ColorScheme colorSchemeLight = ColorScheme.light();
  static const ColorScheme colorSchemeDark = ColorScheme.dark();
}
