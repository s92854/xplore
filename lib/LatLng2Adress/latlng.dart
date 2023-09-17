import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLatLngToAdress extends StatefulWidget {

  @override
  State<ConvertLatLngToAdress> createState() => _ConvertLatLngToAdressState();
}

class _ConvertLatLngToAdressState extends State<ConvertLatLngToAdress> {

  String placeM = '';
  String addressOnScreen = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange, Colors.teal],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(placeM,
            textScaleFactor: 1.5,),
            Text(addressOnScreen,
            textScaleFactor: 1.5,),
            GestureDetector(
              onTap: ()
              async
              {
                List<Location> location = await locationFromAddress('Berlin, Germany');
                
                List<Placemark> placemark = await placemarkFromCoordinates(52.54432970969272, 13.35263030002268);
                setState(() {
                  placeM = '${placemark.reversed.last.locality}, ${placemark.reversed.last.country}';
                  addressOnScreen = '${location.last.longitude}, ${location.last.latitude}';
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                    ),
                  child: const Center(
                    child: Text('Hit to Convert'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
