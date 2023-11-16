
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:layblar_app/DTO/DEviceCardMocksDTO.dart';
import 'package:layblar_app/DTO/DataPointMockDTO.dart';
import 'package:layblar_app/Themes/Styles.dart';
import 'package:layblar_app/Themes/ThemeColors.dart';
import 'package:syncfusion_flutter_charts/charts.dart' hide LabelPlacement;
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../WIdgets/DeviceListItem.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({ Key? key }) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {

  final List<DataPoint> _dataPoints = generateDataPoints();
  final List<DeviceListItem> cardMocks = DeviceCardMockDTO.generateCards();

   DateTime _dateMin = DateTime.now();
   DateTime _dateMax = DateTime.now(); 

   late SfRangeValues _dateValues;

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

  bool isChartSelectionEnabled = false;

  List<DeviceListItem> mockedItems = DeviceCardMockDTO.generateCards();
  List<DropdownMenuItem<String>> dropdownItems = [];



  




  @override
  void initState() {
  super.initState();

  _dateMin = _dataPoints[0].time;
  _dateMax = _dataPoints[_dataPoints.length -1].time;
  _dateValues = SfRangeValues(_dateMin, _dateMax);

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
    return  Column(
      children: [
        Expanded(
          flex: 1,
          child: getTimeFilterSection()
        ),
        Expanded(
          flex: 4, 
          child: Container(
            child: Center(
              child: SfRangeSelector(
                min: _dateMin,
                max: _dateMax,
                initialValues: _dateValues,
                labelPlacement: LabelPlacement.betweenTicks,
                interval: 1,
                showTicks: true,
                showLabels: true,
                child: SizedBox(
                  child: SfCartesianChart(
                    margin: EdgeInsets.zero,
                    primaryXAxis: DateTimeAxis(
                      minimum: _dateMin,
                      maximum: _dateMax,
                      isVisible: false,
                    ),
                    primaryYAxis: NumericAxis(
                      isVisible: true,
                    ),
                    series: [
                      SplineSeries(dataSource: _dataPoints, xValueMapper: (DataPoint p, int index) => p.time, yValueMapper: (DataPoint p, int index)=> p.energyConsumption)
                    ],
                  ),
                ),
              )
            )
          )
        ),
        Expanded(
          flex:4,
          child: SizedBox(
            width: double.infinity,
            child: isChartSelectionEnabled ? getEnabledChartView():getDisabledChartView(),
          ),
        )
      ],
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
    });
  }

  


  Widget getEnabledChartView(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
                getStartTimeSection(),
                getEndTimeSection(),
                getSetDeviceSection(),
                getResetSubmitBtnSection(),
      ]
    );
  }

  Widget getDisabledChartView(){
    return Center(child: Text("For this project, the chart selection was disabled", style: Styles.regularTextStyle,));
  }

  Container getChartSection() {
    return Container(
          margin: const EdgeInsets.only(left: 8, top:8, right: 8, bottom:0),
          decoration:Styles.containerDecoration,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LineChart(
              LineChartData(
                
                lineTouchData: LineTouchData(
                   touchCallback: (FlTouchEvent event, LineTouchResponse? lineTouch) {

                     if (lineTouch == null || lineTouch.lineBarSpots == null) {
                      return;
                    }
                    String timeText;
                    final value = lineTouch.lineBarSpots![0].x;
                    DateTime time = _dataPoints[value.toInt()].time;
                    timeText =  '${time.hour}:${time.minute}';
                    if(isStartTimeEnabled){
                      setState(() {
                        startTime = timeText;
                        selectedStartIndex = lineTouch.lineBarSpots![0].spotIndex;

                        //showingSpots.add(LineBarSpot(_dataPoints[value.toInt()]));
                        //selectedSpots.add(selectedStartIndex);
                      });
                    }
                    if(isEndTimeEnabled){
                      setState(() {
                        endTime = timeText;
                        selectedEndIndex = lineTouch.lineBarSpots![0].spotIndex;    
                      });
                    }
                },
                touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: ThemeColors.primary,
                    getTooltipItems: (List<LineBarSpot> touchedSpots) {
                      final List<LineTooltipItem> tooltips = [];
                      for (final LineBarSpot touchedSpot in touchedSpots) {
                        final DateTime time = _dataPoints[touchedSpot.x.toInt()].time;
                        final String timeText = '${time.hour}:${time.minute}';
                        tooltips.add(LineTooltipItem(timeText, TextStyle(color: ThemeColors.textColor)));
                      }
                      return tooltips;
                    },
                  ),
                  ),
                gridData: getGridData(),
                titlesData: getTilesData(),
                borderData: getBorderData(),
                minX: 0,
                maxX: _dataPoints.length.toDouble() - 1, // Anzahl der Datenpunkte - 1
                minY: 0,
                //maxY: getMaxY(),
                maxY: 11,
                lineBarsData: [
                  getChartData()
                ],
                showingTooltipIndicators: selectedSpots,

              ),
            ),
          ),
        );
  }

  Container getSetDeviceSection() {
    return Container(
                margin: const EdgeInsets.only(left: 8, right: 8),
                decoration: Styles.containerDecoration,
                child: Row(
                  children: [
                    Expanded(flex: 5, 
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.check_circle, size: 36, color: selectedDevice!= ""?ThemeColors.tertiary : ThemeColors.primaryDisabled,),
                          const SizedBox(width: 8,),
                          Flexible(child: Text(selectedDevice == "" ? "No Device selected" : selectedDevice, overflow: TextOverflow.ellipsis,))
                        ],
                      ),
                    )),
                    Expanded(flex: 5, child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(onPressed: ()=> showDropDownList(), child: const Text("Set Device"), style: Styles.tertiaryButtonStyle,),
                    )),
                  ],
                ),
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
                      child: ElevatedButton(onPressed: ()=> onReset(), child: const Text("Reset"), style: Styles.errorButtonStyle,),
                    )),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(onPressed: ()=> onSubmit(), child: const Text("Submit"), style: Styles.primaryButtonStyle,),
                    )),
                  ],
                ),
              );
  }

  void showDropDownList(){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        backgroundColor: ThemeColors.secondaryBackground,
        title:  Text("Select Device", style: Styles.infoBoxTextStyle,),
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

  Container getEndTimeSection() {
    return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.all(8),
                decoration: Styles.containerDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 5,
                      child: ElevatedButton(
                        onPressed: ()=> enableEndTime(), 
                        child: const Text("Set End Time"), 
                        style: Styles.secondaryButtonStyle,
                      ),
                    ),
                    Expanded(flex: 1,child: Container()),
                    Expanded(
                      flex: 4,
                      child: Row(
                        children: [
                          Expanded(flex: 1, child:  Text("End Time:")),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration:Styles.primaryBackgroundContainerDecoration,
                              child: Center(
                                child: Text(endTime)))),
                        ],
                      ),
                    )
                    
                  ],
                )
              );
  }

  Container getStartTimeSection() {
    return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.all(8),
                decoration: Styles.containerDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 5,
                      child: ElevatedButton(
                        onPressed: ()=> enableStartTime(), 
                        child: const Text("Set Start Time"), 
                        style: Styles.primaryButtonStyle,
                      ),
                    ),
                    Expanded(flex: 1,child: Container()),
                    Expanded(
                      flex: 4,
                      child: Row(
                        children: [
                           Expanded(flex: 1, child:  Text("Start Time:")),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration:Styles.primaryBackgroundContainerDecoration,
                              child: Center(
                                child: Text(startTime)))),
                        ],
                      ),
                    )
                    
                  ],
                )
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


  



  //chart setup/customization stuff
  Widget getTitles (double value, TitleMeta meta){
    String timeText;
    int index = value.toInt();
    DateTime time = _dataPoints[index].time;
    timeText =  '${time.hour}:${time.minute}';

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(timeText),
    );
  }

  FlTitlesData getTilesData(){
    return FlTitlesData(
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, interval: 1, reservedSize: 28)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),

        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 6,
            getTitlesWidget: getTitles
          ),
        ),
      );
  }

  FlBorderData getBorderData(){
    return FlBorderData(
        show: true,
        border: Border.all(color: ThemeColors.primaryBackground, width: 1),
      );
  }

  FlGridData getGridData(){
    return FlGridData(show: false);
  }

  LineChartBarData getChartData(){
    final chartGradient = LinearGradient(colors: [ThemeColors.primary.withOpacity(0.8), ThemeColors.secondary.withOpacity(0.8)]);
    final belowBarDataGRadient = LinearGradient(colors: [ThemeColors.primary.withOpacity(0.2), ThemeColors.secondary.withOpacity(0.2)]);
    return LineChartBarData(
          spots: _dataPoints
              .asMap()
              .entries
              .map((entry) => FlSpot(
                    entry.key.toDouble(), // x-Achse: Index der Datenpunkte
                    entry.value.energyConsumption, // y-Achse: Stromverbrauch
                  ))
              .toList(),
          isCurved: true,
          gradient: chartGradient, // Farbe der Linie
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: belowBarDataGRadient
          ),
        );
  }

  double getMaxY (){
    return _dataPoints.map((point) => point.energyConsumption).reduce((a, b) => a > b ? a : b) + 1; // Maximaler Stromverbrauch + 1
  }
}




