import 'dart:math';




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
    final DateTime time = startTime.add(Duration(minutes: i * 10)); // Alle 10 Minuten

    dataPoints.add(DataPoint(time, energyConsumption));
  }

  return dataPoints;
}