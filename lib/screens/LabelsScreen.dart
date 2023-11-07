import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:layblar_app/Themes/ThemeColors.dart';

import '../Themes/Styles.dart';

class LabelsScreen extends StatefulWidget {
  const LabelsScreen({ Key? key }) : super(key: key);

  @override
  State<LabelsScreen> createState() => _LabelsScreenState();
}

//einf ne lsite von dem ganzen mist den wir gelabelt haben (ev bearbeiten/löschen?)
class _LabelsScreenState extends State<LabelsScreen> {

  bool isTodaySelected =true;
  bool isWeekSelected = false;
  bool isMonthSelected = false;


  Map<String, String> labelMocks = {
    "13:24": "Kaffeemaschine Saeco",
    "15:26": "TV",
    "16:59": "Kühlschrank",
  };


  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Expanded(flex: 1, child: getTimeFilterSection()),
        Expanded(flex: 8, child: Container(
          margin: const EdgeInsets.all(8),
          decoration: Styles.containerDecoration,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Text("Here you can see all the Devices you've labeled", style: Styles.infoBoxTextStyle,),
                 SizedBox(height: 16,),
                 Expanded(
                   child: ListView.builder(
                    itemCount: labelMocks.length,
                    itemBuilder: ((context, index) {
                      String key = labelMocks.keys.elementAt(index);
                     return Column(
                       children: [
                         ListTile(
                            title: Text("$key" + ": " + "${labelMocks[key]}", style: Styles.regularTextStyle,)
                         ),
                          Divider(height: 2, color: ThemeColors.textColor,)
                       ],
                     );
                   })
                   ),
                 )
              ],
            ),
          ),
        ))
      ],
    );
     
  }





  Container getTimeFilterSection() {

    void toggleTimeFilter(String time){

      debugPrint("[------HALLLOOOOO]");
    if(time == "day"){
      setState(() {
        isTodaySelected =true;
        isWeekSelected = false;
        isMonthSelected = false;
      });
    }else if(time == "week"){
      setState(() {
        isTodaySelected =false;
        isWeekSelected = true;
        isMonthSelected = false;
      });
    }else if(time == "month"){
      setState(() {
        isTodaySelected =false;
        isWeekSelected = false;
        isMonthSelected = true;
      });
    }
    
  }
    return Container(
          margin: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 8),
          decoration: Styles.containerDecoration,
          child: Row(
            children: [
             Expanded(flex:1, 
              child: GestureDetector(
                onTap: ()=> toggleTimeFilter("day"),
                child: Container(
                  decoration: isTodaySelected?Styles.selctedContainerDecoration:null,
                  child:  Center(
                    child: Text("Today" , style: TextStyle(color: isTodaySelected? ThemeColors.secondaryBackground: ThemeColors.textColor)),)),
              ),),
              Expanded(
                flex:1,
                child: GestureDetector(
                  onTap: ()=> toggleTimeFilter("week"),
                  child: Container(
                    decoration: isWeekSelected?Styles.selctedContainerDecoration:null,
                  child:  Center(
                    child: Text("This Week", style: TextStyle(color: isWeekSelected?ThemeColors.secondaryBackground: ThemeColors.textColor),),)),
                ),
              ),
              Expanded(flex:1, 
              child: GestureDetector(
                onTap: ()=> toggleTimeFilter("month"),
                child: Container(
                  decoration: isMonthSelected?Styles.selctedContainerDecoration:null,
                  child:  Center(
                    child: Text("This Month" , style: TextStyle(color: isMonthSelected?ThemeColors.secondaryBackground: ThemeColors.textColor)),)),
              ),),

            ],
          ),
        );
  }
}