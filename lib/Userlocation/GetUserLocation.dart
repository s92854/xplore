import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gis_google/GooglePlacesAPI/GooglePlacesAPI.dart';

class GetUserLocation extends StatefulWidget {

  @override
  State<GetUserLocation> createState() => _GetUserLocationState();
}

class _GetUserLocationState extends State<GetUserLocation> {

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _initialPosition = CameraPosition(target: LatLng(52.54493956012626, 13.354306644470789),
    zoom: 18, );

  final List<Marker> marker = [];
  final List<Marker> markerList = const[
  Marker(markerId: MarkerId('First'),
    position: LatLng(52.54493956012626, 13.354306644470789),
    infoWindow: InfoWindow(
        title: 'Home'
    ),
  )];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    marker.addAll(markerList);
    //packData();
  }
  
  Future<Position> getUserLocation() async
  {
    await Geolocator.requestPermission().then((value)
    {
      
    }).onError((error, stackTrace)
    {
      print('Error$error');
    });
    return await Geolocator.getCurrentPosition();
  }

  packData()
  {
    getUserLocation().then((value) async
    {
      print('My location');
      print('${value.latitude}, ${value.longitude}');

      marker.add(
        Marker(markerId: const MarkerId('Second'),
        position: LatLng(value.latitude, value.longitude),
        infoWindow: const InfoWindow(
          title: 'My Location',
        ))
      );
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 18
      );
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: _initialPosition,
              mapType: MapType.satellite,
              markers: Set<Marker>.of(marker),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Positioned(
              bottom: 10.0,
              right: 170.0,
              child: FloatingActionButton(
                tooltip: 'Locate User',
                backgroundColor: Colors.greenAccent,
                hoverColor: Colors.green,
                autofocus: true,
                highlightElevation: 50,
                hoverElevation: 50,
                child: const Icon(Icons.location_searching),
                onPressed: () {
                  packData();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }}
