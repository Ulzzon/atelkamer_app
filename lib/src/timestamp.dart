import 'package:flutter/foundation.dart';

class Timestamp{
  final String timestamp;
  final String week_day;

  Timestamp({
    @required this.timestamp,
    @required this.week_day,
  });

  factory Timestamp.fromJson(Map<String, dynamic> json){
    String timestamp = json['timestamp'] as String;
    String week_day = timestamp.split(",")[0];
    return Timestamp(
      timestamp: timestamp,
      week_day: week_day,
      );
  }
}