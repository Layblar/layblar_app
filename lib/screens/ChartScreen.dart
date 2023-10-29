import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
  @override
  _ZoomableChartState createState() => _ZoomableChartState();
}

class _ZoomableChartState extends State<ZoomableChart> {
  double zoomLevel = 1.0; // Initial zoom level

  // Mock data points
  List<FlSpot> dataPoints = [
    FlSpot(0, 3),
    FlSpot(1, 1),
    FlSpot(2, 4),
    FlSpot(3, 2),
    FlSpot(4, 5),
    FlSpot(5, 3),
    FlSpot(6, 6),
  ];

  @override
  Widget build(BuildContext context) {
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
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: 6 * zoomLevel, // Adjust max X based on zoom level
          minY: 0,
          maxY: 6,
          lineBarsData: [
            LineChartBarData(
              spots: dataPoints,
              isCurved: true,
              belowBarData: BarAreaData(show: false),
              dotData: FlDotData(show: true),
              show: true,
            ),
          ],
        ),
      ),
    );
  }
}