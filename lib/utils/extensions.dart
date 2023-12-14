import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  ThemeData get _theme => Theme.of(this);
  TextTheme get textTheme => _theme.textTheme;
  ColorScheme get colorScheme => _theme.colorScheme;
  Size get deviceSize => MediaQuery.sizeOf(this);
  ButtonThemeData get buttonTheme => _theme.buttonTheme;
  Color get scaffolColor => _theme.scaffoldBackgroundColor;
}
