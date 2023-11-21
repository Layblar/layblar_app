
import 'package:flutter/material.dart';
import 'package:layblar_app/Themes/Styles.dart';
import 'package:layblar_app/Themes/ThemeColors.dart';
import 'package:layblar_app/WIdgets/BlinkingDot.dart';
import 'package:layblar_app/WIdgets/Countdown.dart';

// ignore: must_be_immutable
class TimerItem extends StatefulWidget {
    TimerItem({
    required this.selectedDevice,
    required this.seconds,
    this.isPaused = false,
    Key? key}) : super(key: key);


  final String selectedDevice;
  final int seconds;
  bool isPaused;

  @override
  State<TimerItem> createState() => _TimerItemState();
}

class _TimerItemState extends State<TimerItem> with TickerProviderStateMixin {


  late AnimationController _controller;
  bool _isRunning = true;


   @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            seconds:
                widget.seconds) // gameData.levelClock is a user entered number elsewhere in the applciation
        );

    _controller.forward();
  }



  void _togglePause(){
    setState(() {
      widget.isPaused = ! widget.isPaused;
      if (widget.isPaused) {
        _controller.stop();
        _isRunning =false;
      } else {
        _controller.forward();
        _isRunning = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: Styles.containerDecoration,
      child: Padding(padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(widget.selectedDevice),
            ),
            Row(
              children: [
                BlinkingDotWidget(isRunning: _isRunning),
                Countdown(
                  animation: StepTween(
                    begin: widget.seconds, // THIS IS A USER ENTERED NUMBER
                    end: 0,
                  ).animate(_controller),
                ),
              ],
            ),
            ElevatedButton(onPressed:  ()=> _togglePause(), style: widget.isPaused? Styles.primaryButtonStyle : Styles.errorButtonStyle, child: Icon(widget.isPaused ? Icons.play_arrow : Icons.pause, color: ThemeColors.secondaryBackground ,))
          ],
        ),
      ),
    );
  }



}