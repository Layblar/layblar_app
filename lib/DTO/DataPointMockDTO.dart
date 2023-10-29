import 'dart:math';

class DataPoint {
  final double energyConsumption;
  final DateTime time;

  DataPoint(this.energyConsumption, this.time);
}

List<DataPoint> generateDataPoints() {
  final random = Random();
  final List<DataPoint> dataPoints = [];

  // Aktuelle Uhrzeit als Startzeitpunkt verwenden
  final DateTime startTime = DateTime.now();

  // Generiere Datenpunkte für ca. 6 Stunden (alle 10 Minuten)
  for (int i = 0; i < 36; i++) {
    final double stromverbrauch = random.nextDouble() * 10.0; // Zufälliger Stromverbrauch
    final DateTime uhrzeit = startTime.add(Duration(minutes: i * 10)); // Alle 10 Minuten

    dataPoints.add(DataPoint(stromverbrauch, uhrzeit));
  }

  return dataPoints;
}