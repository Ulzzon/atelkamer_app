import 'dart:typed_data';

import 'package:atelkamera_app/src/day_chart.dart';
import 'package:atelkamera_app/src/day_series.dart';
import 'package:atelkamera_app/src/http_service.dart';
import 'package:atelkamera_app/src/timestamp.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;



class HomePage extends StatelessWidget{

  final List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  final List<DaySeries> data = [
    DaySeries(day: 'Monday', 
    images: 40, 
    barColor: charts.ColorUtil.fromDartColor(Colors.green)
    ),
    DaySeries(day: 'Tuesday', 
    images: 60, 
    barColor: charts.ColorUtil.fromDartColor(Colors.green)
    ),
    DaySeries(day: 'Wednesday', 
    images: 10, 
    barColor: charts.ColorUtil.fromDartColor(Colors.green)
    ),
    DaySeries(day: 'Thursday', 
    images: 90, 
    barColor: charts.ColorUtil.fromDartColor(Colors.green)
    ),
    DaySeries(day: 'Friday', 
    images: 100, 
    barColor: charts.ColorUtil.fromDartColor(Colors.green)
    ),
  ];

  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
        ListView(children: [
          Text("ActivityLog"),
          FutureBuilder(
            future: httpService.getTimeStamps(),
            builder: (BuildContext context, AsyncSnapshot<List<Timestamp>> snapshot){
              if(snapshot.hasData){
                List<Timestamp> timestamps = snapshot.data;
                List<DaySeries> dayseries = [];
                for (var day in weekdays) {
                  Iterable<Timestamp> dayStamps = timestamps.where((stamp) => (stamp.week_day.contains(day)));
                  dayseries.add(DaySeries(day: day, images: dayStamps.length, barColor: charts.ColorUtil.fromDartColor(Colors.green)));
                }
                return DayChart(data: dayseries);
/*                return Container(
                  height: 400,
                  padding: EdgeInsets.all(20),
                  child: 
                  ListView(
                    children: timestamps
                    .map((Timestamp stamp) => ListTile(
                      title: Text(stamp.week_day),
                      )
                    ).toList(),
                  )
                );
  */            }
              return Center(child: CircularProgressIndicator());
              },
          ),
        ]
      )
    );
  }


}