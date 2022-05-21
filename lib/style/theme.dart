import 'package:flutter/material.dart';
import 'package:librex/style/constraints.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: lightPrimaryColor,
  textTheme: _textTheme(),
  chipTheme: _chipTheme(),
  pageTransitionsTheme: pageTransitionsTheme(),
);

TextTheme _textTheme() {
  return const TextTheme(
    headline1: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: lightPrimaryColor,
    ),
    bodyText1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  );
}

ChipThemeData _chipTheme() {
  return ChipThemeData(
    side: BorderSide(color: lightPrimaryColor.withOpacity(0.1)),
    backgroundColor: lightPrimaryColor.withOpacity(0.01),
  );
}

PageTransitionsTheme pageTransitionsTheme() {
  return const PageTransitionsTheme(builders: {
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
  });
}
