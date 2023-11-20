import 'dart:async';

import 'package:flutter/material.dart';
import 'package:layblar_app/Themes/Styles.dart';
import 'package:layblar_app/WIdgets/Countdown.dart';

// ignore: must_be_immutable
class TimerItem extends StatefulWidget {
    TimerItem({
    required this.selectedDevice,
    required this.time,
    this.isPaused = false,
    Key? key}) : super(key: key);


  final String selectedDevice;
  final String time;
  bool isPaused;

  @override
  State<TimerItem> createState() => _TimerItemState();
}

class _TimerItemState extends State<TimerItem> with TickerProviderStateMixin {

  late Timer _timer;

  late AnimationController _controller;
  int levelClock = 180;

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
                levelClock) // gameData.levelClock is a user entered number elsewhere in the applciation
        );

    _controller.forward();
  }



  void _togglePause(){
    setState(() {
      widget.isPaused = ! widget.isPaused;
      if (widget.isPaused) {
        _controller.stop();
      } else {
        _controller.forward();
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
                Countdown(
                  animation: StepTween(
                    begin: levelClock, // THIS IS A USER ENTERED NUMBER
                    end: 0,
                  ).animate(_controller),
                ),
              ],
            ),
            ElevatedButton(onPressed:  ()=> _togglePause(), child: Icon(widget.isPaused ? Icons.play_arrow : Icons.pause))
          ],
        ),
      ),
    );
  }



}