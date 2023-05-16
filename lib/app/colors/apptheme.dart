import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'appcolors.dart';

class AppTheme {
  final _getStorage = GetStorage();
  final storageKey = "isDarkMode";

  Locale getLocale() {
    bool isEnglishSaved = _getStorage.read('isEnglishSaved') ?? true;
    return isEnglishSaved ? const Locale('en', 'US') : const Locale('sw', 'TZ');
  }

  ThemeMode getThemeMode() {
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  bool isSavedDarkMode() {
    bool isDarkMode =
        Get.theme.scaffoldBackgroundColor == AppColors.blackBackground;
    return _getStorage.read(storageKey) ?? isDarkMode;
  }

  void saveThemeMode(bool isDarkMode) {
    _getStorage.write(storageKey, isDarkMode);
  }

  void changeTheme() {
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeMode(!isSavedDarkMode());
    androidSystemNavigationBarColor();
  }

  void androidSystemNavigationBarColor() {
    if (GetPlatform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarColor:
              Get.theme.scaffoldBackgroundColor == AppColors.blackBackground
                  ? AppColors.blackBackground
                  : AppColors.whiteBackground,
          systemNavigationBarIconBrightness:
              Get.theme.scaffoldBackgroundColor == AppColors.blackBackground
                  ? Brightness.light
                  : Brightness.dark,
        ),
      );
    }
  }

  void androidSystemNavigationBarColorHomeFeed() {
    if (GetPlatform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarColor:
              Get.theme.scaffoldBackgroundColor != AppColors.blackBackground
                  ? AppColors.blackBackground
                  : AppColors.whiteBackground,
          systemNavigationBarIconBrightness:
              Get.theme.scaffoldBackgroundColor != AppColors.blackBackground
                  ? Brightness.light
                  : Brightness.dark,
        ),
      );
    }
  }

  static final lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      //   elevation: 0,
      //   systemOverlayStyle: GetPlatform.isAndroid
      //       ? const SystemUiOverlayStyle(
      //           statusBarColor: AppColors.whiteBackground,
      //           statusBarIconBrightness: Brightness.dark,
      //         )
      //       : const SystemUiOverlayStyle(
      //           statusBarBrightness: Brightness.light,
      //         ),
      surfaceTintColor: AppColors.whiteBackground,
    ),
    scaffoldBackgroundColor: AppColors.whiteBackground,
    cardTheme: CardTheme(
      surfaceTintColor: Get.theme.colorScheme.surface,
    ),
    colorScheme: AppTheme.lightColorScheme,
    iconTheme: const IconThemeData(
      color: AppColors.whitecolor,
      opacity: 0.9,
      size: 25,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.greenColor,
    ),
    fontFamily: "Urbanist",
    textTheme: GoogleFonts.urbanistTextTheme(Typography.blackHelsinki),
    useMaterial3: true,
  );

  static final darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      //   elevation: 0,
      //   systemOverlayStyle: GetPlatform.isAndroid
      //       ? const SystemUiOverlayStyle(
      //           statusBarColor: AppColors.blackBackground,
      //           statusBarIconBrightness: Brightness.light,
      //         )
      //       : const SystemUiOverlayStyle(
      //           statusBarBrightness: Brightness.dark,
      //         ),
      surfaceTintColor: AppColors.blackBackground,
    ),
    cardTheme: CardTheme(
      surfaceTintColor: Get.theme.colorScheme.surface,
    ),
    scaffoldBackgroundColor: AppColors.blackBackground,
    colorScheme: AppTheme.darkColorScheme,
    iconTheme: const IconThemeData(
      color: AppColors.whitecolor,
      opacity: 0.8,
      size: 25,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.greenColor,
    ),
    fontFamily: "Urbanist",
    textTheme: GoogleFonts.urbanistTextTheme(Typography.whiteHelsinki),
    useMaterial3: true,
  );

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF0B6D36),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFF9EF6B0),
    onPrimaryContainer: Color(0xFF00210B),
    secondary: Color(0xFFA23F00),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFFFDBCC),
    onSecondaryContainer: Color(0xFF351000),
    tertiary: Color(0xFF3A656E),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFBDEAF5),
    onTertiaryContainer: Color(0xFF001F25),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFCFDF7),
    onBackground: Color(0xFF191C19),
    surface: Color(0xFFFCFDF7),
    onSurface: Color(0xFF191C19),
    surfaceVariant: Color(0xFFDDE5DA),
    onSurfaceVariant: Color(0xFF414941),
    outline: Color(0xFF717970),
    onInverseSurface: Color(0xFFF0F1EC),
    inverseSurface: Color(0xFF2E312E),
    inversePrimary: Color(0xFF82D996),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF0B6D36),
    outlineVariant: Color(0xFFC1C9BE),
    scrim: Color(0xFF000000),
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF82D996),
    onPrimary: Color(0xFF003918),
    primaryContainer: Color(0xFF005226),
    onPrimaryContainer: Color(0xFF9EF6B0),
    secondary: Color(0xFFFFB695),
    onSecondary: Color(0xFF571E00),
    secondaryContainer: Color(0xFF7C2E00),
    onSecondaryContainer: Color(0xFFFFDBCC),
    tertiary: Color(0xFFA2CED8),
    onTertiary: Color(0xFF01363E),
    tertiaryContainer: Color(0xFF204D55),
    onTertiaryContainer: Color(0xFFBDEAF5),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF191C19),
    onBackground: Color(0xFFE2E3DE),
    surface: Color(0xFF191C19),
    onSurface: Color(0xFFE2E3DE),
    surfaceVariant: Color(0xFF414941),
    onSurfaceVariant: Color(0xFFC1C9BE),
    outline: Color(0xFF8B938A),
    onInverseSurface: Color(0xFF191C19),
    inverseSurface: Color(0xFFE2E3DE),
    inversePrimary: Color(0xFF0B6D36),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF82D996),
    outlineVariant: Color(0xFF414941),
    scrim: Color(0xFF000000),
  );
}
