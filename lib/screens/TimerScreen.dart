import 'dart:async';

import 'package:flutter/material.dart';
import 'package:layblar_app/DTO/DEviceCardMocksDTO.dart';
import 'package:layblar_app/Themes/Styles.dart';
import 'package:layblar_app/Themes/ThemeColors.dart';
import 'package:layblar_app/WIdgets/BlinkingDot.dart';
import 'package:layblar_app/WIdgets/DeviceListItem.dart';


class TimerScreen extends StatefulWidget {


  const TimerScreen({  Key? key }) : super(key: key);


  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {

  // final Stopwatch _stopwatch = Stopwatch();
  // late Timer _timer;
  // bool _isRunning = false;
  // String _result = '00:00:00';
  String selectedDevice = "";

  List<DeviceListItem> mockedItems = DeviceCardMockDTO.generateCards();
  //get our households
  List<DropdownMenuItem<String>> dropdownItems = [];

  List<StopWatchItem> stopwatchItems = [];

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
        child: Stack(
          children: [
           
            Column(
              children: [
                //const InfoBox(),
                
                Expanded(flex: 1, child: getToggleWatchModeSection()),
                Expanded(flex: 2, child: getSetDeviceSection()), 
                //Expanded(flex: 6, child: getStopwatchSection(context)),
                Expanded(
                  flex: 6,
                  child: Container(
                      margin: EdgeInsets.all(8),
                        key: UniqueKey(), // Hier wird ein UniqueKey verwendet

                      child: ListView(
                        children: stopwatchItems,
                      ),
                  ),
                )
            
              ],
            ),
             Align(
              alignment: Alignment.bottomRight,
              child: getSubmitBtnSection(context),  
            ),
          ],
        ),
      );
  }



  Container getToggleWatchModeSection() {
    return Container(
        margin: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 8),
        decoration: Styles.containerDecoration,
        child: Row(
          children: [
            Expanded(flex:1, 
            child: GestureDetector(
              onTap: (){},
              child: Container(
                decoration: Styles.selctedContainerDecoration,
                child:  Center(
                  child: Text("Stopwatch  (" + stopwatchItems.length.toString() + ")" , style: TextStyle(color:  ThemeColors.secondaryBackground)),)),
            ),),
            Expanded(
              flex:1,
              child: GestureDetector(
                onTap: (){},
                child: Container(
                  decoration: null,
                child:  Center(
                  child: Text("Timer (3)", style: TextStyle(color:ThemeColors.textColor),),)),
              ),
            ),
           

          ],
        ),
      );
  }


 

  Widget getSubmitBtnSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric( vertical: 16.0, horizontal: 16.0),
          child: ElevatedButton(
                  onPressed: () => addNewStopWatchItem(stopwatchItems, selectedDevice),
                  style: Styles.primaryButtonRoundedStyle,
                  child:  Text("+", style: Styles.headerTextStyle,),  
                ),
        ),
      ],
    );
  }

  void addNewStopWatchItem(List<StopWatchItem> items, String selectedDevice){

    debugPrint("[-----DEVICE----]"  + selectedDevice);
    if(selectedDevice == ""){
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: ThemeColors.secondaryBackground,
          title: Text("Choose a Device first!", style: Styles.infoBoxTextStyle,),
          actions: [
            ElevatedButton( style: Styles.primaryButtonStyle, onPressed: ()=> Navigator.of(context).pop(), child: Text("Got it!", style: Styles.regularTextStyle,))
          ],
        );
      });
    }else{
      setState(() {
        items.add(StopWatchItem(selectedDevice: selectedDevice));
      });
    }
  }


  Container getSetDeviceSection() {
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



class StopWatchItem extends StatefulWidget {
  const StopWatchItem({
    required this.selectedDevice,
    Key? key,
  }) : super(key: key);

  final String selectedDevice;


  @override
  State<StopWatchItem> createState() => _StopWatchItemState();
}

class _StopWatchItemState extends State<StopWatchItem> {

  final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;
  bool _isRunning = false;
  String _result = '00:00:00';
  String selectedDevice = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _start();
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
          _result = '${_stopwatch.elapsed.inMinutes.toString().padLeft(2, '0')}:${(_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0')}:${(_stopwatch.elapsed.inMilliseconds % 100).toString().padLeft(2, '0')}';
        });
      } else {
        t.cancel();
      }
    });
    _stopwatch.start();
  }
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

  @override
void dispose() {
  _timer.cancel();
  super.dispose();
}
}




