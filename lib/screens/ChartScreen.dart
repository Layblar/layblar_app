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
  @override
  Widget build(BuildContext context) {
    return  ZoomableChart();
  }
}


class ZoomableChart extends StatefulWidget {
  const ZoomableChart({Key? key}) : super(key: key);

  @override
  _ZoomableChartState createState() => _ZoomableChartState();
}

class _ZoomableChartState extends State<ZoomableChart> {
  double zoomLevel = 1.0; // Initial zoom level

  List<DataPoint> _dataPoints = generateDataPoints();

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

  
  @override
  Widget build(BuildContext context) {
      debugPrint(_dataPoints.length.toString());

    return GestureDetector(
      onScaleUpdate: (details) {
        // Detect zooming gesture
        setState(() {
          zoomLevel = details.scale.clamp(1.0, 3.0); // Limit the zoom level
        });
      },
      child: LineChart(
       LineChartData(
        gridData: FlGridData(show: false),

       titlesData: FlTitlesData(
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
        ),
        
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1),
        ),
        minX: 0,
        maxX: _dataPoints.length.toDouble() - 1, // Anzahl der Datenpunkte - 1
        minY: 0,
        maxY: _dataPoints.map((point) => point.energyConsumption).reduce((a, b) => a > b ? a : b) + 1, // Maximaler Stromverbrauch + 1
        lineBarsData: [
          LineChartBarData(
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
          ),
        ],
      ),
    
      ),
    );
  }
}