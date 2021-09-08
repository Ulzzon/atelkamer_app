import 'dart:convert';
import 'dart:typed_data';

import 'package:atelkamera_app/src/timestamp.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HttpService {
  final String backendBaseUrl = "5d45g38hm1.execute-api.eu-west-1.amazonaws.com";
  final Uri timestampUrl = Uri.https("5d45g38hm1.execute-api.eu-west-1.amazonaws.com", "/prod");
  

  Future<List<Timestamp>> getTimeStamps() async{
    Response response = await get(timestampUrl);

    if(response.statusCode == 200){
      List<dynamic> body = jsonDecode(response.body);

      List<Timestamp> timestamps = body.map((dynamic item) => Timestamp.fromJson(item)).toList();

      return timestamps;
    } else{
      throw "Can't get timestamps";
    }
  }

  Future<Uint8List> getImage(String imageId) async{
    Map<String, String> query = {'id': imageId};
    Uri imageUrl = Uri.https(backendBaseUrl, "/prod/image", query);
    
    Response response = await get(imageUrl);

    if(response.statusCode == 200){
      Uint8List bytes = base64Decode(response.body);
      
      return bytes;
    } else{
      throw "Can't get timestamps";
    }
  }

  Future<List<Uint8List>> getImageRange(DateTimeRange imageRange) async{
    imageRange.start.toIso8601String();
    Map<String, String> query = {'start': imageRange.start.toIso8601String(), 
      'end': imageRange.end.toIso8601String()};
    Uri imageUrl = Uri.https(backendBaseUrl, "/prod/image", query);
    
    Response response = await get(imageUrl);
    
    if(response.statusCode == 200){
      List<String> imageList = _convertToArray(response.body);
      List<Uint8List> decodedImageList = [];
      for (final base64Image in imageList) 
        decodedImageList.add(base64Decode(base64Image));
      
      return decodedImageList;
    } else{
      throw "Can't get timestamps";
    }
  }

  List<String> _convertToArray(String imageArrayString){
    String a = imageArrayString.replaceAll("\"", "");
    String trimArray = a.replaceAll("[", "");
    String listReady = trimArray.replaceAll("]", "");
    return listReady.split(",");
  }
}