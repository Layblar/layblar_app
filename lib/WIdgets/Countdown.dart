
import 'package:flutter/material.dart';
import 'package:layblar_app/Themes/ThemeColors.dart';

class Countdown extends AnimatedWidget {
  const Countdown({Key? key, required this.animation}) : super(key: key, listenable: animation);
  final Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inHours.toString().padLeft(2, '0')}:${clockTimer.inMinutes.remainder(60).toString().padLeft(2, '0')}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    return Text(
      timerText,
      style: TextStyle(
        fontSize: 24,
        color: ThemeColors.textColor,
      ),
    );
  }
}