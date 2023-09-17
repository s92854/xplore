import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class GoogleMapTheme extends StatefulWidget {

  @override
  State<GoogleMapTheme> createState() => _GoogleMapThemeState();
}

class _GoogleMapThemeState extends State<GoogleMapTheme> {

  String themeForMap = '';

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _initialPosition = CameraPosition(target: LatLng(52.54432970969272, 13.35263030002268),
    zoom: 16);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DefaultAssetBundle.of(context).loadString('themes/DarkTheme.json').then((value)
    {
      themeForMap = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Map Theme'), centerTitle: true, backgroundColor: Colors.cyan.shade300,
        actions: [
          PopupMenuButton(
              itemBuilder: (context) =>
              [
                PopupMenuItem(
                  onTap: (){
                    _controller.future.then((value)
                    {
                      DefaultAssetBundle.of(context).loadString('themes/AubergineTheme.json').then((style)
                      {
                        value.setMapStyle(style);
                      });
                    });
                  },
                    child: const Text('Aubergine Theme'),),
                PopupMenuItem(
                  onTap: (){
                    _controller.future.then((value)
                    {
                      DefaultAssetBundle.of(context).loadString('themes/DarkTheme.json').then((style)
                      {
                        value.setMapStyle(style);
                      });
                    });
                  },
                  child: const Text('Dark Theme'),),
                PopupMenuItem(
                  onTap: (){
                    _controller.future.then((value)
                    {
                      DefaultAssetBundle.of(context).loadString('themes/DefaultTheme.json').then((style)
                      {
                        value.setMapStyle(style);
                      });
                    });
                  },
                  child: const Text('Default Theme'),),
                PopupMenuItem(
                  onTap: (){
                    _controller.future.then((value)
                    {
                      DefaultAssetBundle.of(context).loadString('themes/NightTheme.json').then((style)
                      {
                        value.setMapStyle(style);
                      });
                    });
                  },
                  child: const Text('Night Theme'),),
                PopupMenuItem(
                  onTap: (){
                    _controller.future.then((value)
                    {
                      DefaultAssetBundle.of(context).loadString('themes/RetroTheme.json').then((style)
                      {
                        value.setMapStyle(style);
                      });
                    });
                  },
                  child: const Text('Retro Theme'),),
                PopupMenuItem(
                  onTap: (){
                    _controller.future.then((value)
                    {
                      DefaultAssetBundle.of(context).loadString('themes/SilverTheme.json').then((style)
                      {
                        value.setMapStyle(style);
                      });
                    });
                  },
                  child: const Text('Silver Theme'),),
                PopupMenuItem(
                  onTap: () {setState(() {
                    _mapType = MapType.satellite;
                  });
                      },
                  child: const Text('Satellite Image'),),
              ],),
        ],
      ),
      body: SafeArea(
         child: GoogleMap(initialCameraPosition: _initialPosition,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller)
          {
            controller.setMapStyle(themeForMap);
            _controller.complete(controller);
          },),
      ),
    );
  }
  MapType _mapType = MapType.satellite;
}
