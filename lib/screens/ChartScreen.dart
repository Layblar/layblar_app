import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:layblar_app/DTO/DataPointMockDTO.dart';
import 'package:layblar_app/Themes/Styles.dart';
import 'package:layblar_app/Themes/ThemeColors.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({ Key? key }) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {

  final List<DataPoint> _dataPoints = generateDataPoints();

  String startTime = "";
  String endTime = "";

  bool isStartTimeEnabled = false;
  bool isEndTimeEnabled = false;

  int? selectedStartIndex;
  int? selectedEndIndex;
  List<ShowingTooltipIndicators> selectedSpots =[];
  List<LineBarSpot> showingSpots = [];

//TODO:VALIDATION
//bugfix: wen man auf endtime drückt und dann auf start setzt es beide
  void enableStartTime(){
    isStartTimeEnabled = true;
  }

  void enableEndTime(){
    isStartTimeEnabled = false;
    isEndTimeEnabled = true;
  }

  void onSubmit (){
    isEndTimeEnabled = false;
    setState(() {
      startTime = "";
      endTime = "";
      selectedStartIndex = null;
      selectedEndIndex = null;
    });
    
  }
  
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 0),
            decoration: Styles.containerDecoration
          )
        ),
        Expanded(
          flex: 5, 
          child: Container(
            margin: const EdgeInsets.only(left: 8, top:8, right: 8, bottom:16),
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
                          tooltips.add(LineTooltipItem(timeText, TextStyle(color: Colors.white)));
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
                  maxY: getMaxY(),
                  lineBarsData: [
                    getChartData()
                  ],
                  showingTooltipIndicators: selectedSpots,

                ),
              ),
            ),
          )
        ),
        Expanded(
          flex:4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: ()=> enableStartTime(), child: const Text("choose start Time"), style: Styles.primaryButtonStyle,),
              ElevatedButton(onPressed: ()=> enableEndTime(), child: const Text("choose end Time"), style: Styles.secondaryButtonStyle,),
              Text("Start Time: " + startTime),
              Text("End Time: " + endTime),
              ElevatedButton(onPressed: ()=> onSubmit(), child: const Text("Submit"), style: Styles.primaryButtonStyle,)
            ],
          ),
        )
      ],
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
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, interval: 1)),
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
        border: Border.all(color: const Color(0xff37434d), width: 1),
      );
  }

  FlGridData getGridData(){
    return FlGridData(show: false);
  }

  LineChartBarData getChartData(){
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
          color: Colors.blue, // Farbe der Linie
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
        );
  }

  double getMaxY (){
    return _dataPoints.map((point) => point.energyConsumption).reduce((a, b) => a > b ? a : b) + 1; // Maximaler Stromverbrauch + 1
  }
}


