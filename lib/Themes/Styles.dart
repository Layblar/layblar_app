import 'package:flutter/material.dart';
import 'package:layblar_app/Themes/ThemeColors.dart';
class Styles{

  static final primaryButtonStyle = ElevatedButton.styleFrom(
    primary: ThemeColors.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    textStyle: TextStyle(color: ThemeColors.textColor)
  );

  static final secondaryButtonStyle = ElevatedButton.styleFrom(
    primary: ThemeColors.secondary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    textStyle: TextStyle(color: ThemeColors.textColor)
  );

  static final errorButtonStyle = ElevatedButton.styleFrom(
    primary: ThemeColors.error,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    textStyle: TextStyle(color: ThemeColors.textColor)
  );

  static final containerDecoration = BoxDecoration(
    color: ThemeColors.secondaryBackground,
    borderRadius: BorderRadius.circular(16)
  );

   static final selctedContainerDecoration = BoxDecoration(
    color: ThemeColors.primary,
    borderRadius: BorderRadius.circular(16)
  );
}