// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'StorageManager.dart';

class ThemeModel extends ChangeNotifier {
  bool _userDarkMode = false;
  static const kThemeUserDarkMode = 'kThemeUserDarkMode';
  ThemeModel() {
    _userDarkMode =
        StorageManager.sharedPreferences.getBool(kThemeUserDarkMode) ?? false;
  }
  themeData({bool platformDarkMode = false}) {
    _userDarkMode =
        StorageManager.sharedPreferences.getBool(kThemeUserDarkMode) ?? false;
    var isDark = platformDarkMode || _userDarkMode;
    Brightness brightness = isDark ? Brightness.dark : Brightness.light;

    var themeColor = Colors.red;
    var accentColor = Colors.redAccent.shade400;
    var scaffoldBackgroundColor =
        isDark ? const Color(0xFF262626) : Colors.white;
    ColorScheme colorScheme = ColorScheme(
        brightness: brightness,
        primary: Colors.white,
        onPrimary: Colors.black,
        secondary: Colors.redAccent.shade400,
        onSecondary: Colors.white,
        error: Colors.amberAccent.shade400,
        onError: Colors.black,
        background: const Color(0xFFcca3a3),
        onBackground: Colors.white,
        surface: const Color(0xFF808080),
        onSurface: Colors.white);
    ColorScheme darkColorScheme = ColorScheme(
        brightness: brightness,
        primary: Colors.black,
        onPrimary: Colors.white,
        secondary: Colors.redAccent.shade400,
        onSecondary: Colors.black,
        error: Colors.amberAccent.shade400,
        onError: Colors.black,
        background: const Color(0xFF403333),
        onBackground: Colors.white,
        surface: const Color(0xFF808080),
        onSurface: Colors.white);
    var themeData = ThemeData(
        brightness: brightness,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        backgroundColor: scaffoldBackgroundColor,
        fontFamily: 'system',
        primaryColor: Colors.white,
        colorScheme: (isDark) ? darkColorScheme : colorScheme);

    themeData = themeData.copyWith(
      brightness: brightness,
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: themeColor,
        brightness: brightness,
      ),

      appBarTheme: themeData.appBarTheme.copyWith(elevation: 0),
      splashColor: themeColor.withAlpha(50),
      hintColor: themeData.hintColor.withAlpha(90),
      errorColor: Colors.red,
      textTheme: themeData.textTheme.copyWith(
          headline6: themeData.textTheme.headline6
              ?.copyWith(textBaseline: TextBaseline.alphabetic)),

      toggleableActiveColor: accentColor,
      chipTheme: themeData.chipTheme.copyWith(
        pressElevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        labelStyle: themeData.textTheme.caption,
        backgroundColor: themeData.chipTheme.backgroundColor?.withOpacity(0.1),
      ),
//          textTheme: CupertinoTextThemeData(brightness: Brightness.light)
      inputDecorationTheme: ThemeHelper.inputDecorationTheme(themeData),
      iconTheme: IconThemeData(
        color: colorScheme.primary,
        size: 24,
      ),
      colorScheme: (isDark) ? darkColorScheme : colorScheme,
    );
    return themeData;
  }

  /// 数据持久化到shared preferences
  saveTheme2Storage(bool userDarkMode) async {
    await Future.wait([
      StorageManager.sharedPreferences
          .setBool(kThemeUserDarkMode, userDarkMode),
    ]);
  }
}

class ThemeHelper {
  static InputDecorationTheme inputDecorationTheme(ThemeData theme) {
    var primaryColor = theme.colorScheme.onPrimary;
    var dividerColor = const Color(0xFF707070);
    var errorColor = Colors.amberAccent.shade400;
    var disabledColor = Colors.grey;
    var accentColor = theme.colorScheme.secondary;
    var width = 0.5;

    return InputDecorationTheme(
      focusColor: accentColor,
      iconColor: accentColor,
      hintStyle: const TextStyle(fontSize: 14),
      errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: width, color: errorColor)),
      focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 0.7, color: errorColor)),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: width, color: primaryColor)),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: width, color: dividerColor)),
      border: UnderlineInputBorder(
          borderSide: BorderSide(width: width, color: dividerColor)),
      disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: width, color: disabledColor)),
    );
  }
}
