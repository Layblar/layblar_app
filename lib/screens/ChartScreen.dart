import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:layblar_app/DTO/DataPointMockDTO.dart';

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


  void enableStartTime(){
    isStartTimeEnabled = true;
  }

  void enableEndTime(){
    isStartTimeEnabled = false;
    isEndTimeEnabled = true;
  }

  void onSubmit (){
    isEndTimeEnabled = false;
    startTime = "";
   endTime = "";
  }
  
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Expanded(
          flex: 1, 
          child: LineChart(
            LineChartData(
              
              lineTouchData: LineTouchData(
                 touchCallback: (FlTouchEvent event, LineTouchResponse? lineTouch) {
                  String timeText;
                  final value = lineTouch?.lineBarSpots![0].x;
                  if(value != null){
                    DateTime time = _dataPoints[value.toInt()].time;
                    timeText =  '${time.hour}:${time.minute}';
                    debugPrint("[----time-----]" + time.toString());
                    if(isStartTimeEnabled){
                      setState(() {
                        startTime = timeText;
                      });
                    }
                    if(isEndTimeEnabled){
                      setState(() {
                        endTime = timeText;
                        
                      });
                    }
                  }
              }),
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
            ),
          )
        ),
        Expanded(
          flex:1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: ()=> enableStartTime(), child: Text("choose start Time")),
              ElevatedButton(onPressed: ()=> enableEndTime(), child: Text("choose end Time")),
              Text("Start Time: " + startTime),
              Text("End Time: " + endTime),
              ElevatedButton(onPressed: ()=> onSubmit(), child: Text("Submit"))
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


