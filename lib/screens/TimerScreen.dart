import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:layblar_app/DTO/chartItem.dart';


class TimerScreen extends StatefulWidget {


  const TimerScreen({  Key? key }) : super(key: key);


  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {

  final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  bool _isRunning = false;
  String _result = '00:00:00';
  String selectedHousehould = 'Haushalt 1';

  //get our households
  List<DropdownMenuItem<String>>  dropdownItems =
   const [
      DropdownMenuItem(child: Text("Haushalt 1"),value: "Haushalt 1"),
      DropdownMenuItem(child: Text("Haushalt 2"),value: "Haushalt 2"),
      DropdownMenuItem(child: Text("Haushalt 3"),value: "Haushalt 3"),
    ];


  void _start(){

    _isRunning = true;
    _timer = Timer.periodic(const Duration(milliseconds: 30), (Timer t) {
      setState(() {
        _result = 
          '${_stopwatch.elapsed.inMinutes.toString().padLeft(2, '0')}:${(_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0')}:${(_stopwatch.elapsed.inMilliseconds % 100).toString().padLeft(2, '0')}';
      });
    });
    _stopwatch.start();
  }

   void _stop() {
    _timer.cancel();
    _stopwatch.stop();
  }

  void _reset(){
    _stop();
    _stopwatch.reset();
    _isRunning = false;
    setState(() {
      _result = '00:00:00';
    });
  }

  @override
  Widget build(BuildContext context) {
      
    return  Container(
        child: Column(
          children: [
            Text(
              _result,
              style: const TextStyle(
                fontSize: 50.0,
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Stop button
                  _isRunning ? ElevatedButton(
                    onPressed: _stop,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    child: const Text('Stop'),
                  ): Container(),
                  // Reset button
                  _isRunning? ElevatedButton(
                    onPressed: _reset,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    child: const Text('Reset'),
                  ): Container()
                ],
              ),
              DropdownButton(
                value: selectedHousehould,
                onChanged: (String? newValue){
                  setState(() {
                    selectedHousehould = newValue!;
                  });
                },
                items: dropdownItems, 

              ),
              
              ElevatedButton(
                onPressed: _start,
                child: const Text('Start'),
              ),

          ],
        ),
      );
  }
}

