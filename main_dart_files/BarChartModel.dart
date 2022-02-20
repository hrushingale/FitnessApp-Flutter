import 'package:charts_flutter/flutter.dart' as charts;

class BarChartModel{

  final charts.Color color;

  String set;
  int reps;


  BarChartModel({required this.set,required this.reps,required this.color});
}
