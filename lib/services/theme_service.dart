// ignore_for_file: unused_field

import 'package:flutter/material.dart';

class ThemeService {
  static const _actionColorLight = Color.fromRGBO(161, 192, 56, 1);
  static const _backgroundLight = Colors.white;
  static const _onbackgroundLight = Color.fromRGBO(236, 239, 252, 1);
  static const _buttonColorLight = Color.fromRGBO(161, 192, 56, 1);
  static const _textColorLight = Colors.black;
  static const _textColorDisableLight = Color.fromRGBO(185, 189, 200, 1);

  static final appThemeLight = ThemeData(
    textTheme: _lightTextTheme,
    colorScheme: const ColorScheme.light(
      background: _backgroundLight,
      onBackground: _onbackgroundLight,
      primary: _buttonColorLight,
    ),
  );
  final appThemeDark = ThemeData(
    colorScheme: const ColorScheme.dark(
      background: _backgroundLight,
      onBackground: _onbackgroundLight,
      primary: _buttonColorLight,
    ),
  );

  static const TextTheme _lightTextTheme = TextTheme(
    titleLarge: _titleLargeLight,
    titleMedium: _titleMediumLight,
    bodyLarge: _bodyLargeLight,
    bodyMedium: _bodyMediumLight,
    bodySmall: _bodySmallLight,
    labelMedium: _buttonTextLight,
    labelSmall: _labelSmallTextLight,
  );

  // Title
  static const TextStyle _titleLargeLight = TextStyle(
    color: _textColorLight,
    fontSize: 32,
    fontWeight: FontWeight.w900,
    fontFamily: "Avenir",
  );

  static const TextStyle _titleMediumLight = TextStyle(
    color: _textColorLight,
    fontSize: 18.66,
    fontWeight: FontWeight.w900,
    fontFamily: "Avenir",
  );

  // Body
  static const TextStyle _bodyLargeLight = TextStyle(
    color: _textColorLight,
    fontSize: 21.333333333333332,
    fontWeight: FontWeight.w900,
    fontFamily: "Avenir",
  );

  static const TextStyle _bodyMediumLight = TextStyle(
    color: _textColorLight,
    fontSize: 21.333333333333332,
    fontWeight: FontWeight.w600,
    fontFamily: "Avenir",
  );

  static const TextStyle _bodySmallLight = TextStyle(
    color: _textColorDisableLight,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: "Avenir",
  );

  // Restliches
  static const TextStyle _buttonTextLight = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w900,
    fontFamily: "Avenir",
    wordSpacing: 0,
  );

  static const TextStyle _labelSmallTextLight = TextStyle(
    color: Colors.white,
    fontSize: 9,
    fontWeight: FontWeight.w200,
    fontFamily: "Avenir",
    wordSpacing: 0,
  );

  final EdgeInsets pagePadding = const EdgeInsets.only(
    top: 30,
    bottom: 20,
    left: 20,
    right: 20,
  );
}

AppBar appBarWithButton(
        {required String title,
        required Icon icon,
        void Function()? onPressedCallback}) =>
    AppBar(
      backgroundColor: ThemeService._backgroundLight,
      elevation: 0,
      title: Text(title, style: ThemeService._titleMediumLight),
      leading: IconButton(onPressed: onPressedCallback, icon: icon),
    );

AppBar appBarWithLeadingText({
  required String leadingTitle,
  required Icon icon,
  required double leadingWidth,
  void Function()? onPressedCallback,
  Color backgroundColor = ThemeService._backgroundLight,
}) =>
    AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      leadingWidth: leadingWidth,
      leading: Row(
        children: [
          const SizedBox(width: 10),
          IconButton(onPressed: onPressedCallback, icon: icon),
          Text(
            leadingTitle,
            style: ThemeService._bodyLargeLight,
          ),
        ],
      ),
    );

AppBar dummyAppBar({
  Color backgroundColor = ThemeService._backgroundLight,
}) =>
    AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      leading: null,
    );

EdgeInsets pagePaddingwithAppBar(double mediaWidth, double mediaHeight) =>
    EdgeInsets.only(
        top: 0,
        bottom: 20,
        left: mediaWidth > mediaHeight ? mediaWidth * 0.2 : mediaWidth * 0.05,
        right: mediaWidth > mediaHeight ? mediaWidth * 0.2 : mediaWidth * 0.05);

EdgeInsets normalPadding(double mediaWidth, double mediaHeight) => EdgeInsets.only(
      top: 20,
      bottom: 20,
      left: mediaWidth > mediaHeight ? mediaWidth * 0.2 : mediaWidth * 0.05,
      right: mediaWidth > mediaHeight ? mediaWidth * 0.2 : mediaWidth * 0.05);
