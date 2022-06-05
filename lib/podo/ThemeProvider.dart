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
        isDark ? const Color(0xFF373331) : Colors.white;
    var themeData = ThemeData(
        brightness: brightness,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        fontFamily: 'system',
        primaryColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: themeColor)
            .copyWith(secondary: accentColor, brightness: brightness));

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
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accentColor),
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
    var primaryColor = theme.primaryColor;
    var dividerColor = theme.dividerColor;
    var errorColor = theme.errorColor;
    var disabledColor = theme.disabledColor;

    var width = 0.5;

    return InputDecorationTheme(
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
