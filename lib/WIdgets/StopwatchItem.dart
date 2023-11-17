import "dart:async";

import "package:flutter/material.dart";
import "package:layblar_app/Themes/Styles.dart";
import "package:layblar_app/WIdgets/BlinkingDot.dart";


class StopWatchItem extends StatefulWidget {
  const StopWatchItem({
    required this.selectedDevice,
    required this.stopwatch,
    Key? key,
  }) : super(key: key);

  final String selectedDevice;
  final Stopwatch stopwatch;


  @override
  State<StopWatchItem> createState() => _StopWatchItemState();
}

class _StopWatchItemState extends State<StopWatchItem> {

  late Timer _timer;
  bool _isRunning = false;
  bool _isInitialStart = true;
  String _result = '00:00:00';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(_isInitialStart){
      _start();
      setState(() {
              _isInitialStart = false;

      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    decoration: Styles.containerDecoration,
    child: Column(
      children: [
        Text(widget.selectedDevice),
        Row(
          children: [
            BlinkingDotWidget(isRunning: _isRunning),
            Text(_result),
            ElevatedButton(onPressed: _stop, child: Text("Stop")),
            ElevatedButton(onPressed: _reset, child: Text("Reset")),
            ElevatedButton(onPressed: _reset, child: Text("Delete")),

          ],
        ),
      ],
    ),
                            );
  }


  void _start() {
  if (mounted) {
    _isRunning = true;
    _timer = Timer.periodic(const Duration(milliseconds: 30), (Timer t) {
      if (mounted) {
        setState(() {
          _result = '${widget.stopwatch.elapsed.inMinutes.toString().padLeft(2, '0')}:${(widget.stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0')}:${(widget.stopwatch.elapsed.inMilliseconds % 100).toString().padLeft(2, '0')}';
        });
      } else {
        t.cancel();
      }
    });
    widget.stopwatch.start();
  }
}

   void _stop() {

    
    _timer.cancel();
    widget.stopwatch.stop();
    setState(() {
      _isRunning = false;
    });
  }

  void _reset(){
    _stop();
    widget.stopwatch.reset();
    _isRunning = false;
    setState(() {
      _result = '00:00:00';
    });
  }

  void _submit(String household, String time){
    debugPrint("submitted: " + household + ", " + time);
  }

  void _delete(){
    dispose();

  }

  @override
void dispose() {
  _timer.cancel();
  super.dispose();
}
}