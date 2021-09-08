import 'dart:typed_data';

import 'package:atelkamera_app/src/http_service.dart';
import 'package:flutter/material.dart';



class ActivityPage extends StatelessWidget{
  final List images = [
    '/tmp/PIC_2021_03_03_T13-28.JPG',
    '/images/PIC_2021_03_19_T04-05.JPG',
    '/images/PIC_2021_03_19_T03-31.JPG'
  ];

  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    DateTime dateTimeNow = DateTime.now();
    DateTime yesterday = dateTimeNow.subtract(const Duration(days: 1));
    return Scaffold(
      body: 
        ListView.builder(
          itemBuilder: (context, index) {
            return Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: 300,
            child: FutureBuilder(
                    future: httpService.getImageRange(imageRange),
                    builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot){

                    }

            }
          },
          children: [
          Text("ActivityLog"),
          
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: 300,
            child: ListView.builder(
              
              itemBuilder: (BuildContext context, int index){
                return Padding(
                  padding: EdgeInsets.all(20),
                  child: FutureBuilder(
                    future: httpService.getImage(images[index]),
                    builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot){
                      if(snapshot.hasData){
                        Uint8List imageBytes = snapshot.data;
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Image.memory(imageBytes),
                            ),
                            Text('data'),
                          ],
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                  ); 
                },
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
            ),
          ),
        ]
      )
    );
  }
}




/*                FutureBuilder(
              future: httpService.getImage('/tmp/PIC_2021_03_01_T20-14.JPG'),
              builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot){
                if(snapshot.hasData){
                  Uint8List imageBytes = snapshot.data;

                  return Image.memory(imageBytes);

                }
                return Center(child: CircularProgressIndicator());
                },
            ),
              ],*/