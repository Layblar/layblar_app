import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:layblar_app/DTO/DEviceCardMocksDTO.dart';
import 'package:layblar_app/Themes/Styles.dart';
import 'package:layblar_app/Themes/ThemeColors.dart';
import 'package:layblar_app/WIdgets/DeviceListItem.dart';


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
  String selectedDevice = "";

  List<DeviceListItem> mockedItems = DeviceCardMockDTO.generateCards();
  //get our households
  List<DropdownMenuItem<String>> dropdownItems = [];

  @override
  void initState() {
  super.initState();
  selectedDevice = mockedItems[0].title;
  dropdownItems = mockedItems
  .map((element) {
    return DropdownMenuItem(
      child: ListTile(
        leading: element.imgUrl != "" ?Image.network(element.imgUrl) : null,
        title: Text(element.title, style: Styles.regularTextStyle),
      ),
      value: element.title,
    );
    }).toList();
  }


  @override
  Widget build(BuildContext context) {

    return  SizedBox(
        child: Column(
          children: [
            //const InfoBox(),
            
            Expanded(flex: 2, child: getHouseHoldSelection()), 
            Expanded(flex: 7, child: getStopwatchSection(context)),
            Expanded(flex: 1,child: getSubmitBtnSection(context))   
        
          ],
        ),
      );
  }


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

  void _submit(String household, String time){
    debugPrint("submitted: " + household + ", " + time);
  }

  Container getSubmitBtnSection(BuildContext context) {
    return Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(8),
            decoration: Styles.containerDecoration,
            child: Padding(
              padding: const EdgeInsets.symmetric( vertical: 8.0, horizontal: 32.0),
              child: ElevatedButton(
                onPressed: ()=>  _submit(selectedDevice, _result),
                style: Styles.primaryButtonStyle,
                child: const Text("Sumbit"),  
              ),
            ),
          );
  }

  Container getStopwatchSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      decoration: Styles.containerDecoration,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: 
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: BlinkingDotWidget(isRunning: _isRunning),
                        ),
                      ),

                      Expanded(
                        flex: 6,
                        child: Container(
                          decoration: Styles.primaryBackgroundContainerDecoration,
                          child: Center(
                            child: Text(
                              _result,
                              style: const TextStyle(
                                fontSize: 50.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(flex: 2, child: Container())
                    ],
                  ),
                  GestureDetector(
                    onTap: !_isRunning ? _start : _stop,
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: !_isRunning
                          ? Styles.stopwatchContainerDecoration
                          : Styles.stopwatchContainerDecorationStopped,
                      child: Center(
                        child: !_isRunning
                            ? Text("Start", style: Styles.headerTextStyleSecondary)
                            : Text("Stop", style: Styles.headerTextStyleSecondary),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _reset,
                    style: Styles.secondaryButtonStyle,
                    child: const Text('Reset'),
                  ),
                ],
              ),
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
                  Text("Select your Device.", style: Styles.infoBoxTextStyle,),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: selectedDevice,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDevice = newValue!;
                          });
                        },
                      items: dropdownItems,
                      dropdownColor: ThemeColors.secondaryBackground,
                      isExpanded: true, // Öffnet die Dropdown-Liste in voller Breite
                      underline: null,
                      icon: const Icon(Icons.arrow_drop_down),
                       // Fügt einen Dropdown-Pfeil hinzu
                    
                                      ),
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



class BlinkingDotWidget extends StatefulWidget {
  final bool isRunning;

  BlinkingDotWidget({required this.isRunning});

  @override
  _BlinkingDotWidgetState createState() => _BlinkingDotWidgetState();
}

class _BlinkingDotWidgetState extends State<BlinkingDotWidget> {
  late Timer _blinkTimer;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _blinkTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (widget.isRunning) {
        setState(() {
          _isVisible = !_isVisible;
        });
      }
    });
  }

  @override
  void dispose() {
    _blinkTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isRunning && _isVisible) {
      return Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: ThemeColors.error,
          shape: BoxShape.circle,
        ),
      );
    } else {
      return const SizedBox(
        width: 20,
        height: 20,
      );
    }
  }
}

