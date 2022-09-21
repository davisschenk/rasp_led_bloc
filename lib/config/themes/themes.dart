import 'package:flutter/material.dart';

enum AppTheme { Dark, Light }

final appThemeData = {
  AppTheme.Light: ThemeData.light(),
  AppTheme.Dark: ThemeData.dark(),
};
