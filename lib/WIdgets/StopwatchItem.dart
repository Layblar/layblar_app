import "dart:async";
import "package:flutter/material.dart";
import "package:layblar_app/Themes/Styles.dart";
import "package:layblar_app/Themes/ThemeColors.dart";
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
  String _result = '00:00:00';

  @override
  void initState() {
    super.initState();
    if (!_isRunning) {
      _start();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: Styles.containerDecoration,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(widget.selectedDevice),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlinkingDotWidget(isRunning: _isRunning),
                Container(
                  decoration: Styles.primaryBackgroundContainerDecoration,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(_result),
                  ),
                ),
                _isRunning
                    ? ElevatedButton(
                        style: Styles.errorButtonStyle,
                        onPressed: _stop,
                        child: Text("Stop", style: Styles.secondaryTextStyle),
                      )
                    : ElevatedButton(
                        style: Styles.primaryButtonStyle,
                        onPressed: _start,
                        child:
                            Text("Resume", style: Styles.secondaryTextStyle)),
                ElevatedButton(
                    style: Styles.secondaryButtonStyle,
                    onPressed: _reset,
                    child: Text("Reset", style: Styles.secondaryTextStyle)),
                IconButton(onPressed: () {}, icon: Icon(Icons.send, color: ThemeColors.textColor)),
              ],
            ),
          ],
        ),
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

  void _reset() {
    _stop();
    widget.stopwatch.reset();
    _isRunning = false;
    setState(() {
      _result = '00:00:00';
    });
  }

  void _submit(String household, String time) {
    debugPrint("submitted: " + household + ", " + time);
  }

  void _delete() {
    dispose();
  }

  @override
  void dispose() {
    // _timer.cancel(); // Du könntest dies hier entfernen, weil es bereits im _stop() aufgerufen wird
    super.dispose();
  }
}
