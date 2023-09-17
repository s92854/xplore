import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _initialPosition = CameraPosition(target: LatLng(52.54432970969272, 13.35263030002268),
  zoom: -1000, );

  final List<Marker> marker = [];
  final List<Marker> markerList = const[
    Marker(markerId: MarkerId('First'),
    position: LatLng(52.54432970969272, 13.35263030002268),
    infoWindow: InfoWindow(
      title: 'BHT Haus C'
    ),
    ),
    Marker(markerId: MarkerId('Second'),
      position: LatLng(52.51630794352171, 13.377711560314957),
      infoWindow: InfoWindow(
          title: 'Brandenburger Tor'
      ),
    ),
    Marker(markerId: MarkerId('Third'),
      position: LatLng(52.52091289496953, 13.409440555777168),
      infoWindow: InfoWindow(
          title: 'Berliner Fernsehturm'
      ),
    )
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    marker.addAll(markerList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(initialCameraPosition: _initialPosition,
        mapType: MapType.satellite,
        markers: Set<Marker>.of(marker),
        onMapCreated: (GoogleMapController controller)
          {
            _controller.complete(controller);
          },),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_searching),
        onPressed: ()
        async {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
            const CameraPosition(target: LatLng(52.51630794352171, 13.377711560314957),
            zoom: 16,
            )
          ));
          setState(() {

          });
      }
      ),
    );
  }
}
