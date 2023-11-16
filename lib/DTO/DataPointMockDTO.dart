import 'dart:math';
import 'package:intl/intl.dart';




class DataPoint {
  final DateTime time;
    final double energyConsumption;


  DataPoint(this.time, this.energyConsumption);
}

List<DataPoint> generateDataPoints() {
  final random = Random();
  final List<DataPoint> dataPoints = [];

  // Aktuelle Uhrzeit als Startzeitpunkt verwenden
  final DateTime startTime = DateTime.now();

  // Generiere Datenpunkte für ca. 6 Stunden (alle 10 Minuten)
  for (int i = 0; i < 36; i++) {
    final double energyConsumption = random.nextDouble() * 10.0; // Zufälliger Stromverbrauch
    final DateTime unformattedTime = startTime.add(Duration(minutes: i * 10)); // Alle 10 Minuten
    String formattedDateString = DateFormat('yyyy:MM:dd:HH:mm').format(unformattedTime);

    DateTime parsedDateTime = DateFormat('yyyy:MM:dd:HH:mm').parse(formattedDateString);



    dataPoints.add(DataPoint(parsedDateTime, energyConsumption));
  }

  return dataPoints;
}


double getMaxEngeryConsumtion(List<DataPoint> dataPoints){

  double max = 0;;

  for (var p in dataPoints) {
    if(p.energyConsumption > max){
      max = p.energyConsumption;
    }
  }
  return max;

}