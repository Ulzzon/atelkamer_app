import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'day_series.dart';

class DayChart extends StatelessWidget{
  final List<DaySeries> data;

  DayChart({@required this.data});

  @override
  Widget build(BuildContext context) {

    List<charts.Series<DaySeries, String>> series
    = [
      charts.Series(
        id: "Days",
        data: data,
        domainFn: (DaySeries series, _) =>
        series.day,
        measureFn: (DaySeries series, _) =>
        series.images,
        colorFn: (DaySeries series, _) =>
        series.barColor,
        )
    ];
    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text("Day Chart",
              style: Theme.of(context).textTheme.bodyText2,
              ),
              Expanded(child: 
                charts.BarChart(series, 
                animate: true,
                )
              )
            ],
          ),
        )
      )
    );
  }
}