
import 'package:flutter/material.dart';
import 'package:layblar_app/DTO/DEviceCardMocksDTO.dart';
import 'package:layblar_app/DTO/StopWatchHoldItem.dart';
import 'package:layblar_app/Themes/Styles.dart';
import 'package:layblar_app/Themes/ThemeColors.dart';
import 'package:layblar_app/WIdgets/DeviceListItem.dart';
import 'package:layblar_app/WIdgets/StopwatchItem.dart';
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


  bool isStopWatchViewSelected = true;

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
                  child: isStopWatchViewSelected? getStopWatchSection(): Container(
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        //section for the timer
                        //lsit fo rthe timer items.
                      ],
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
                  stopwatchItems.isEmpty? Text("Stopwatch", style: TextStyle(color: isStopWatchViewSelected?  ThemeColors.secondaryBackground:ThemeColors.textColor)): Text("Stopwatch  (" + stopwatchItems.length.toString() + ")" , style: TextStyle(color: isStopWatchViewSelected?  ThemeColors.secondaryBackground:ThemeColors.textColor)),)),
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
                  child: Text("Timer (3)", style: TextStyle(color:isStopWatchViewSelected?  ThemeColors.textColor: ThemeColors.secondaryBackground),),)),
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

      Stopwatch stopwatch = Stopwatch();
      var stopwatchItemsModel = Provider.of<StopwatchItemsModel>(context, listen: false);

      setState(() {
        var newItem = StopWatchItem(selectedDevice: selectedDevice, stopwatch: stopwatch);
        stopwatchItemsModel.addStopwatchItem(newItem); // Add the last item to the model

        debugPrint("[------ITEMS LEN----]" + items.length.toString());
      });
    }
  }


 
}










