import 'package:flutter/material.dart';
import 'package:layblar_app/Themes/ThemeColors.dart';
class Styles{

  static final primaryButtonStyle = ElevatedButton.styleFrom(
    primary: ThemeColors.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    textStyle: TextStyle(color: ThemeColors.textColor)
  );

  static final secondaryButtonStyle = ElevatedButton.styleFrom(
    primary: ThemeColors.secondary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    textStyle: TextStyle(color: ThemeColors.textColor)
  );

  static final tertiaryButtonStyle = ElevatedButton.styleFrom(
    primary: ThemeColors.tertiary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    textStyle: TextStyle(color: ThemeColors.textColor)
  );

  static final errorButtonStyle = ElevatedButton.styleFrom(
    primary: ThemeColors.error,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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

  static final primaryBackgroundContainerDecoration = BoxDecoration(
    color: ThemeColors.primaryBackground,
    borderRadius: BorderRadius.circular(16)
  );


  static final stopwatchContainerDecoration = BoxDecoration(
    color: ThemeColors.primary,
    borderRadius: BorderRadius.circular(200),
    boxShadow: [
      BoxShadow(
        color: ThemeColors.primary.withOpacity(0.4),
        spreadRadius: 5,
        blurRadius: 7,
        offset: const Offset(0, 3)
        )
    ]
  );

  static final stopwatchContainerDecorationStopped = BoxDecoration(
    color: ThemeColors.error,
    borderRadius: BorderRadius.circular(200),
    boxShadow: [
      BoxShadow(
        color: ThemeColors.error.withOpacity(0.4),
        spreadRadius: 5,
        blurRadius: 7,
        offset: const Offset(0, 3)
        )
    ]
  );

    static final infoBoxTextStyle =  TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: ThemeColors.textColor,
  );

  static final headerTextStyle = TextStyle(
    fontSize: 48,
    color: ThemeColors.textColor
  );

  static final regularTextStyle = TextStyle(
    color: ThemeColors.textColor
  );
}

