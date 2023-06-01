import 'package:flutter/material.dart';

class StylesApp {
  //static Color appPrimaryColor = Color.fromARGB(255, 6, 126, 122);

  static ThemeData darkTheme(BuildContext context) {
    final ThemeData theme = ThemeData.dark();
    return theme.copyWith(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFFFFB86B),
          onPrimary: Color(0xFF492900),
          primaryContainer: Color(0xFF683D00),
          onPrimaryContainer: Color(0xFFFFDCBC),
          secondary: Color(0xFFE1C1A3),
          onSecondary: Color(0xFF402C18),
          secondaryContainer: Color(0xFF58432C),
          onSecondaryContainer: Color(0xFFFEDDBE),
          tertiary: Color(0xFFBECC9B),
          onTertiary: Color(0xFF293411),
          tertiaryContainer: Color(0xFF3F4B25),
          onTertiaryContainer: Color(0xFFDAE8B5),
          error: Color(0xFFFFB4AB),
          errorContainer: Color(0xFF93000A),
          onError: Color(0xFF690005),
          onErrorContainer: Color(0xFFFFDAD6),
          background: Color(0xFF1F1B16),
          onBackground: Color(0xFFEBE1D9),
          surface: Color(0xFF1F1B16),
          onSurface: Color(0xFFEBE1D9),
          surfaceVariant: Color(0xFF50453A),
          onSurfaceVariant: Color(0xFFD5C3B5),
          outline: Color(0xFF9D8E81),
          onInverseSurface: Color(0xFF1F1B16),
          inverseSurface: Color(0xFFEBE1D9),
          inversePrimary: Color(0xFF895100),
          shadow: Color(0xFF000000),
          surfaceTint: Color(0xFFFFB86B),
          outlineVariant: Color(0xFF50453A),
          scrim: Color(0xFF000000),
        ));
  }

  static ThemeData lightTheme(BuildContext context) {
    final ThemeData theme = ThemeData.light();
    return theme.copyWith(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF895100),
          onPrimary: Color(0xFFFFFFFF),
          primaryContainer: Color(0xFFFFDCBC),
          onPrimaryContainer: Color(0xFF2C1700),
          secondary: Color(0xFF725A42),
          onSecondary: Color(0xFFFFFFFF),
          secondaryContainer: Color(0xFFFEDDBE),
          onSecondaryContainer: Color(0xFF291805),
          tertiary: Color(0xFF57633B),
          onTertiary: Color(0xFFFFFFFF),
          tertiaryContainer: Color(0xFFDAE8B5),
          onTertiaryContainer: Color(0xFF151F01),
          error: Color(0xFFBA1A1A),
          errorContainer: Color(0xFFFFDAD6),
          onError: Color(0xFFFFFFFF),
          onErrorContainer: Color(0xFF410002),
          background: Color(0xFFFFFBFF),
          onBackground: Color(0xFF1F1B16),
          surface: Color(0xFFFFFBFF),
          onSurface: Color(0xFF1F1B16),
          surfaceVariant: Color(0xFFF1DFD0),
          onSurfaceVariant: Color(0xFF50453A),
          outline: Color(0xFF837568),
          onInverseSurface: Color(0xFFFAEFE7),
          inverseSurface: Color(0xFF352F2B),
          inversePrimary: Color(0xFFFFB86B),
          shadow: Color(0xFF000000),
          surfaceTint: Color(0xFF895100),
          outlineVariant: Color(0xFFD5C3B5),
          scrim: Color(0xFF000000),
        ));
  }
}
