import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:layblar_app/Themes/Styles.dart';
import 'package:layblar_app/Themes/ThemeColors.dart';


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
    [
      DropdownMenuItem(child: Container(color: ThemeColors.secondaryBackground, child: Text("Haushalt 1", style: Styles.regularTextStyle,)),value: "Haushalt 1", ),
      DropdownMenuItem(child: Container(color: ThemeColors.secondaryBackground, child: Text("Haushalt 2", style: Styles.regularTextStyle,)), value: "Haushalt 2"),
      DropdownMenuItem(child: Container(color: ThemeColors.secondaryBackground, child: Text("Haushalt 3", style: Styles.regularTextStyle,)),value: "Haushalt 3"),
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
    setState(() {
      _isRunning = false;
    });
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
      
      //infobox
      //househol selection
      //time
      //big cirlce with glow
      //reset button
      //sumbit
    return  SizedBox(
        child: Column(
          children: [
            //const InfoBox(),
            //household selection
            getHouseHoldSelection(), 

            //stopwatch time

            Container(
              margin: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              decoration: Styles.containerDecoration,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      decoration: Styles.primaryBackgroundContainerDecoration,
                      child: Text(
                        _result,
                        style: const TextStyle(
                          fontSize: 50.0,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap:  !_isRunning? _start : _stop,
                      child: Container(
                        height: 136,
                        width: 136,
                        decoration: !_isRunning ? Styles.stopwatchContainerDecoration: Styles.stopwatchContainerDecorationStopped,
                        child:  Center(child: !_isRunning? Text("Start", style: Styles.headerTextStyle,): Text("Stop", style: Styles.headerTextStyle,) ),
                      ),
                    ),
                  ],
                ),
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
             
              
              ElevatedButton(
                onPressed: _start,
                child: const Text('Start'),
              ),

          ],
        ),
      );
  }

  Container getHouseHoldSelection() {
    return Container(
            margin: EdgeInsets.all(8),
            decoration: Styles.containerDecoration,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
                  const Text("Select your household"),
                  Container(
                    width: double.infinity,
                    child: DropdownButton(
                      value: selectedHousehould,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedHousehould = newValue!;
                        });
                      },
                    items: dropdownItems,
                    dropdownColor: ThemeColors.secondaryBackground,
                    isExpanded: true, // Öffnet die Dropdown-Liste in voller Breite
                  )
                  ),

                ],
              ),
            ),
          );
  }
}

class InfoBox extends StatelessWidget {
  const InfoBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: Styles.containerDecoration,
      child:  Padding(
        padding:  EdgeInsets.all(16.0),
           child: Text (
            "Select your household and start the stopwatch at the same time as your device. when the device is finished, stop the watch and submit the data with the submit button.",
             style: Styles.infoBoxTextStyle, 
             overflow: TextOverflow.clip,
            )
      ),
       
    );
  }
}

