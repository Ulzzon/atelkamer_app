import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class DaySeries{
  final String day;
  final int images;
  final charts.Color barColor;

  DaySeries({
    @required this.day,
    @required this.images,
    @required this.barColor,
  });
}