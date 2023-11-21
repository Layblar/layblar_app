
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:layblar_app/DTO/DEviceCardMocksDTO.dart';
import 'package:layblar_app/DTO/StopWatchHoldItem.dart';
import 'package:layblar_app/Themes/Styles.dart';
import 'package:layblar_app/Themes/ThemeColors.dart';
import 'package:layblar_app/WIdgets/DeviceListItem.dart';
import 'package:layblar_app/WIdgets/StopwatchItem.dart';
import 'package:layblar_app/WIdgets/TimerItem.dart';
import 'package:provider/provider.dart';



class TimerScreen extends StatefulWidget {


  const TimerScreen({  Key? key }) : super(key: key);


  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {

  // late Timer _timer;
  
  String selectedDevice = "";

  List<DeviceListItem> mockedItems = DeviceCardMockDTO.generateCards();
  //get our households
  List<DropdownMenuItem<String>> dropdownItems = [];

  List<StopWatchItem> stopwatchItems = [];
  List<TimerItem> timerItems = [];


  bool isStopWatchViewSelected = true;

      var timeValue = ""; 


  @override
  void initState() {
  super.initState();
  var stopwatchItemsModel = Provider.of<StopwatchItemsModel>(context, listen: false);
  stopwatchItems = stopwatchItemsModel.stopwatchItems;
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

    for (var item in stopwatchItems) {
        if (!item.isPaused) {
          item.stopwatch.start();
        }
      }
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
                  //child: getStopWatchSection(),
                  child: isStopWatchViewSelected? getStopWatchSection(): getTimerSection(),
                )
            
              ],
            ),
             Align(
              alignment: Alignment.bottomRight,
              child: getSubmitBtnSection(context, selectedDevice),  
            ),
          ],
        ),
      );
  }

  Container getTimerSection() {

    return Container(
                  margin: const EdgeInsets.all(8),
                  child: ListView.builder(
                      reverse: false, // Umkehrung der Liste
                      itemCount: timerItems.length,
                      itemBuilder: (context, index) {
                        return timerItems[index];
                      },
            ),
          );
  }

  Container getStopWatchSection() {
    return Container(
            margin: const EdgeInsets.all(8),
            key: UniqueKey(),
              child: ListView.builder(
                reverse: false, // Umkehrung der Liste
                itemCount: stopwatchItems.length,
                itemBuilder: (context, index) {
                  return stopwatchItems[index];
                },
            ),
    );
  }


  void openTimerPicker(String currentDevice){

    if(currentDevice == ""){
      showDialog(context: context, builder: (BuildContext context){
        return chooseDeviceFirstDialog(context);

      });
    }else{
       showDialog(context: context, builder: (BuildContext context){
      return Dialog(
          child: Container(
            decoration: Styles.containerDecoration,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Set Timer for: " + currentDevice,
                  style: Styles.infoBoxTextStyle,
                ),
                const SizedBox(height: 8.0),
                CupertinoTheme(
                  data: CupertinoThemeData(
                    primaryColor: ThemeColors.primary,
                    textTheme: CupertinoTextThemeData(
                      pickerTextStyle: TextStyle(color: ThemeColors.textColor, fontSize: 18),
                    ),
                  ),
                  child: CupertinoTimerPicker(
                    mode: CupertinoTimerPickerMode.hm,
                    onTimerDurationChanged: (value) {
                      setState(() {
                        timeValue = value.toString();
                        debugPrint(timeValue);
                      });
                    },
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        style: Styles.errorButtonStyle,
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text("Cancel", style: Styles.secondaryTextStyle,),
                      ),
                    ),
                     Expanded(
                      flex: 1,
                       child: ElevatedButton(
                        style: Styles.primaryButtonStyle,
                        onPressed: () {
                          //TODO: logic
                              if(timeValue != "0:00:00.000000"){
                                addNewTimerItem(timeValue, selectedDevice);
                              }
                              Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text("Done", style: Styles.secondaryTextStyle,),
                        ),
                     ),
                  ],
                ),
               
              ],
            ),
          ),
        );
    });
    }
   
  }


  void addNewTimerItem(String time, String selectedDevice){
    int seconds = convertTimeStringToSeconds(time);
    debugPrint("[-----seconds---]" + seconds.toString());
    setState(() {
      timerItems.add(TimerItem(selectedDevice: selectedDevice, seconds: seconds));
    });
  }


  int convertTimeStringToSeconds(String timeString) {
  // Zeit in Stunden:Minuten:Sekunden aufteilen
  List<String> timeComponents = timeString.split(":");
  
  // Extrahiere Stunden, Minuten und Sekunden
  int hours = int.parse(timeComponents[0]);
  int minutes = int.parse(timeComponents[1]);
  int seconds = int.parse(timeComponents[2].split(".")[0]); // Entferne Millisekunden
  
  // Berechne die Gesamtzeit in Sekunden
  int totalSeconds = hours * 3600 + minutes * 60 + seconds;
  
  return totalSeconds;
}



  Container getToggleWatchModeSection() {
    return Container(
        margin: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 8),
        decoration: Styles.containerDecoration,
        child: Row(
          children: [
            Expanded(flex:1, 
            child: GestureDetector(
              onTap: (){
                if(!isStopWatchViewSelected){
                  setState(() {
                    isStopWatchViewSelected = true;
                  });
                }
              },
              child: Container(
                decoration: isStopWatchViewSelected? Styles.selctedContainerDecoration: null,
                child:  Center(
                  child: 
                  stopwatchItems.isEmpty? Text("Stopwatch", style: TextStyle(color: isStopWatchViewSelected?  ThemeColors.secondaryBackground:ThemeColors.textColor)): Text("Stopwatch (" + stopwatchItems.length.toString() + ")" , style: TextStyle(color: isStopWatchViewSelected?  ThemeColors.secondaryBackground:ThemeColors.textColor)),)),
            ),),
            Expanded(
              flex:1,
              child: GestureDetector(
                onTap: (){
                  if(isStopWatchViewSelected){
                    setState(() {
                      isStopWatchViewSelected = false;
                    });
                  }
                },
                child: Container(
                  decoration: !isStopWatchViewSelected ?Styles.selctedContainerDecoration: null,
                child:  Center(
                  child:timerItems.isEmpty?  Text("Timer", style: TextStyle(color:isStopWatchViewSelected?  ThemeColors.textColor: ThemeColors.secondaryBackground)): Text("Timer (" + timerItems.length.toString() + ")", style: TextStyle(color: !isStopWatchViewSelected?ThemeColors.secondaryBackground:ThemeColors.textColor),))),
              ),
            ),
           

          ],
        ),
      );
  }

   Container getSetDeviceSection() {
    return Container(
            margin: const EdgeInsets.all(8),
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


  Widget getSubmitBtnSection(BuildContext context, String selectedDevice) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric( vertical: 16.0, horizontal: 16.0),
          child: ElevatedButton(
                  onPressed: () =>isStopWatchViewSelected? addNewStopWatchItem(stopwatchItems, selectedDevice) : openTimerPicker(selectedDevice),
                  style: Styles.primaryButtonRoundedStyle,
                  child:  Text("+", style: Styles.headerTextStyle,),  
                ),
        ),
      ],
    );
  }

  void addNewStopWatchItem(List<StopWatchItem> items, String selectedDevice){

    if(selectedDevice == ""){
      showDialog(context: context, builder: (BuildContext context){
        return chooseDeviceFirstDialog(context);
      });
    }else{

      Stopwatch stopwatch = Stopwatch();
      var stopwatchItemsModel = Provider.of<StopwatchItemsModel>(context, listen: false);

      setState(() {
        var newItem = StopWatchItem(selectedDevice: selectedDevice, stopwatch: stopwatch);
        stopwatchItemsModel.addStopwatchItem(newItem); // Add the last item to the model

        debugPrint("[------ITEMS LEN----]" + items.length.toString());
      });
    }
  }

  AlertDialog chooseDeviceFirstDialog(BuildContext context) {
    return AlertDialog(
        backgroundColor: ThemeColors.secondaryBackground,
        title: Text("Choose a Device first!", style: Styles.infoBoxTextStyle,),
        actions: [
          ElevatedButton( style: Styles.primaryButtonStyle, onPressed: ()=> Navigator.of(context).pop(), child: Text("Got it!", style: Styles.regularTextStyle,))
        ],
      );
  }


 
}










