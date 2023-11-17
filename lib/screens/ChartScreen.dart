
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:layblar_app/DTO/DEviceCardMocksDTO.dart';
import 'package:layblar_app/DTO/DataPointMockDTO.dart';
import 'package:layblar_app/Themes/Styles.dart';
import 'package:layblar_app/Themes/ThemeColors.dart';
import 'package:syncfusion_flutter_charts/charts.dart' hide LabelPlacement;
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:intl/intl.dart';


import '../WIdgets/DeviceListItem.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({ Key? key }) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {

  final List<DataPoint> _dataPoints = generateDataPoints();
  final List<DeviceListItem> cardMocks = DeviceCardMockDTO.generateCards();

  final belowBarDataGradient = LinearGradient(colors: [ThemeColors.primary.withOpacity(0.8), ThemeColors.secondary.withOpacity(0.8)]);


 
  String startTime = "";
  String endTime = "";

  bool isStartTimeEnabled = false;
  bool isEndTimeEnabled = false;

  int? selectedStartIndex;
  int? selectedEndIndex;
  List<ShowingTooltipIndicators> selectedSpots =[];
  List<LineBarSpot> showingSpots = [];

  bool isTodaySelected =true;
  bool isWeekSelected = false;
  bool isMonthSelected = false;

  String selectedDevice = "";
  bool isDeviceSelected = false;

  bool isChartSelectionEnabled = true;

  List<DeviceListItem> mockedItems = DeviceCardMockDTO.generateCards();
  List<DropdownMenuItem<String>> dropdownItems = [];


  @override
  void initState() {
  super.initState();
  selectedDevice = mockedItems[0].title;
  dropdownItems = mockedItems.map((element) {
    return DropdownMenuItem(
      child: ListTile(
        leading: Image.network(element.imgUrl),
        title: Text(element.title, style: Styles.regularTextStyle),
      ),
      value: element.title,
    );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {



    DateTime _dateMin = _dataPoints[0].time;


    DateTime _dateMax = _dataPoints[_dataPoints.length - 1].time;
    SfRangeValues _dateValues = SfRangeValues(_dateMin, _dateMax);

    return  Column(
      children: [
        Expanded(
          flex: 1,
          child:getSetDeviceSection(),
        ),
        Expanded(
          flex: 1,
          child: getTimeFilterSection()
        ),
        Expanded(
          flex: 5,
          child: getChartWithSliderSection(_dateMin, _dateMax, _dateValues),
        ),
        Expanded(
          flex: 2,
          child: SizedBox(
            width: double.infinity,
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getTimeSection(),
                getResetSubmitBtnSection(),
              ]
            )
          ),
        )
      ],
    );
  }

  Container getSetDeviceSection() {
    return Container(
              margin: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 0),
                decoration: Styles.containerDecoration,
                child: Row(
                  children: [
                   
                    Expanded(flex: 5, child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(onPressed: ()=> showDropDownList(), child:  Text(selectedDevice== ""?"Choose Device":"Change Device",  style: Styles.secondaryTextStyle), style: Styles.secondaryButtonStyle,),
                    )),
                     Expanded(flex: 5, 
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.check_circle, size: 36, color: selectedDevice!= ""?ThemeColors.secondary : ThemeColors.primaryDisabled,),
                          const SizedBox(width: 8,),
                          Flexible(child: Text(selectedDevice == "" ? "No Device selected" : selectedDevice, overflow: TextOverflow.ellipsis,))
                        ],
                      ),
                    )),
                  ],
                ),
              );
  }

   void showDropDownList(){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        backgroundColor: ThemeColors.secondaryBackground,
        title:  Text("Chose your Device from the List below.", style: Styles.infoBoxTextStyle,),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: mockedItems.map((e) => ListTile(
            title: Text(e.title, style: Styles.regularTextStyle,),
            leading: e.imgUrl != "" ? Image.network(e.imgUrl) : null,
            onTap: () {
                        setState(() {
                          selectedDevice = e.title;
                        });
                        Navigator.of(context).pop();
                      },
          ))
          .toList()
        ),
      );
    });
  }

   Container getTimeFilterSection() {

    void toggleTimeFilter(String time){
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
                  margin: const EdgeInsets.all(8),
                  decoration: isTodaySelected?Styles.selctedContainerDecoration:null,
                  child:  Center(
                    child: Text("Today" , style: TextStyle(color: isTodaySelected? ThemeColors.secondaryBackground: ThemeColors.textColor)),)),
              ),),
              Expanded(
                flex:1,
                child: GestureDetector(
                  onTap: ()=> toggleTimeFilter("week"),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: isWeekSelected?Styles.selctedContainerDecoration:null,
                  child:  Center(
                    child: Text("This Week", style: TextStyle(color: isWeekSelected?ThemeColors.secondaryBackground: ThemeColors.textColor),),)),
                ),
              ),
              Expanded(flex:1, 
              child: GestureDetector(
                onTap: ()=> toggleTimeFilter("month"),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: isMonthSelected?Styles.selctedContainerDecoration:null,
                  child:  Center(
                    child: Text("This Month" , style: TextStyle(color: isMonthSelected?ThemeColors.secondaryBackground: ThemeColors.textColor)),)),
              ),),

            ],
          ),
        );
  }

  

  Container getChartWithSliderSection(DateTime _dateMin, DateTime _dateMax, SfRangeValues _dateValues) {
    return Container(
          child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                // ignore: missing_required_param
                child: SfRangeSelector(
                  min: _dateMin,
                  max: _dateMax,
                  initialValues: _dateValues,
                  interval: 1,
                  dateIntervalType: DateIntervalType.hours,
                  dateFormat: DateFormat.H(),
                  showTicks: false,
                  showLabels: false,
                  onChanged: (SfRangeValues values){
                    setState(() { 
                      startTime = DateFormat('HH:mm').format(values.start);
                      endTime =  DateFormat('HH:mm').format(values.end);
                    });
                  },
                  child: SizedBox(
                    child: SfCartesianChart(
                      margin: EdgeInsets.zero,
                      primaryXAxis: DateTimeAxis(
                        minimum: _dateMin,
                        maximum: _dateMax,
                        isVisible: true,
                      ),
                      primaryYAxis: NumericAxis(
                        name: "kw/h",
                        isVisible: true, 
                        maximum: (getMaxEngeryConsumtion(_dataPoints) + 1) //for a little extra padding ;)
                      ),
                      series: <SplineAreaSeries<DataPoint, DateTime>>[
                        SplineAreaSeries<DataPoint, DateTime>(
                          gradient: belowBarDataGradient,
                            dataSource: _dataPoints,
                            xValueMapper: (DataPoint p, int index) => p.time,
                            yValueMapper: (DataPoint p, int index) => p.energyConsumption)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

   Container getTimeSection() {
    return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.all(8),
                decoration: Styles.containerDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                  children: [

                     Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                           const Expanded(flex: 3, child:  Text("Start:")),
                          Expanded(
                            flex: 7,
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              decoration:Styles.primaryBackgroundContainerDecoration,
                              child: Center(
                                child: Text(startTime)))),
                        ],
                      ),
                    ),
                   Expanded(
                     flex: 1, 
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Row(
                            children: [
                              const Expanded(flex: 3, child:  Text("End:")),
                              Expanded(
                                flex: 7,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  decoration:Styles.primaryBackgroundContainerDecoration,
                                  child: Center(
                                    child: Text(endTime)))),
                            ],
                          ),
                     ),
                   ),
                   
                    
                  ],
                )
              );
  }

  Container getResetSubmitBtnSection() {
    return Container(
                margin: const EdgeInsets.only(left: 8, right: 8),
                decoration: Styles.containerDecoration,
                child: Row(
                  children: [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(onPressed: ()=> onReset(), child:  Text("Reset", style: Styles.secondaryTextStyle,), style: Styles.errorButtonStyle,),
                    )),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(onPressed: ()=> onSubmit(), child:  Text("Save Label" , style: Styles.secondaryTextStyle), style: Styles.primaryButtonStyle,),
                    )),
                  ],
                ),
              );
  }


  void enableStartTime(){
    isEndTimeEnabled = false;
    isStartTimeEnabled = true;
  }

  void enableEndTime(){
    isStartTimeEnabled = false;
    isEndTimeEnabled = true;
  }

  void onSubmit (){
    setState(() {
      isEndTimeEnabled = false;
      isStartTimeEnabled = false;
      startTime = "";
      endTime = "";
      selectedStartIndex = null;
      selectedEndIndex = null;
    });
  }

  void onReset (){
    setState(() {
      isEndTimeEnabled = false;
      isStartTimeEnabled = false;
      startTime = "";
      endTime = "";
      selectedStartIndex = null;
      selectedEndIndex = null;
      selectedDevice = "";
    });
  }

  
  

  

  

 
 

 

 

}




