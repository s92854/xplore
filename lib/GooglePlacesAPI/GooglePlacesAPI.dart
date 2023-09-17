import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GooglePlacesAPI extends StatefulWidget {

  @override
  State<GooglePlacesAPI> createState() => _GooglePlacesAPIState();
}

class _GooglePlacesAPIState extends State<GooglePlacesAPI> {

  bool isSuggestionsVisible = false;
  String themeForMap = '';
  String _currentMapTheme = 'themes/DarkTheme.json';
  late GoogleMapController _mapController;
  Set<Marker> _markers = {};
  String tokenForSession = '37465';
  var uuid = const Uuid();
  List<dynamic> listForPlaces = [];
  late TextEditingController _controller = TextEditingController();
  final Completer<GoogleMapController> _gMapController = Completer();
  static const CameraPosition _initialPosition = CameraPosition(target: LatLng(52.54432970969272, 13.35263030002268),
      zoom: 16);
  void makeSuggestion(String input) async
  {
    String googlePlacesAPIKey = 'API_KEY';
    String groundURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$groundURL?input=$input&key=$googlePlacesAPIKey&sessiontoken=$tokenForSession';

    var responseResult = await http.get(Uri.parse(request));
    var Resultdata = responseResult.body.toString();

    print('Results');
    print(Resultdata);

    if(responseResult.statusCode == 200) {
      setState(() {
        listForPlaces = jsonDecode(responseResult.body.toString()) ['predictions'];
      });
    } else {
      throw Exception('Showing data failed, Try Again');
    }
  }

  void onModify(){
    if(tokenForSession == null) {
      setState(() {
        tokenForSession = uuid.v4();
      });
    }
    makeSuggestion(_controller.text);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      onModify();
    });
    DefaultAssetBundle.of(context).loadString('themes/DarkTheme.json').then((value)
    {
      themeForMap = value;
    });
  }

  void _applyMapTheme(String themePath) {
    if (_mapController != null) {
      DefaultAssetBundle.of(context).loadString(themePath).then((value)
      {
        _mapController.setMapStyle(value);
        setState(() {
          themeForMap = value;
        });
      });
      print('Applied theme: $themeForMap');
    }
  }

  @override
  Widget build(BuildContext context) {

    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Google Maps Search'),
          centerTitle: true,
        actions: [
          PopupMenuButton(itemBuilder: (context) =>
          [
            PopupMenuItem(
              onTap: (){
                _gMapController.future.then((value)
                {
                  DefaultAssetBundle.of(context).loadString('themes/AubergineTheme.json').then((style)
                  {
                    value.setMapStyle(style);
                    setState(() {
                      //themeForMap = style;
                      _applyMapTheme('themes/AubergineTheme.json');
                      //_currentMapTheme = 'themes/AubergineTheme.json';
                    });
                  });
                });
              },
              child: const Text('Aubergine Theme'),),
            PopupMenuItem(
              onTap: (){
                _gMapController.future.then((value)
                {
                  DefaultAssetBundle.of(context).loadString('themes/DarkTheme.json').then((style)
                  {
                    value.setMapStyle(style);
                    setState(() {
                      themeForMap = style;
                      _applyMapTheme('themes/DarkTheme.json');
                    });
                  });
                });
              },
              child: const Text('Dark Theme'),),
            PopupMenuItem(
              onTap: (){
                _gMapController.future.then((value)
                {
                  DefaultAssetBundle.of(context).loadString('themes/DefaultTheme.json').then((style)
                  {
                    value.setMapStyle(style);
                    setState(() {
                      themeForMap = style;
                      _applyMapTheme('themes/DefaultTheme.json');
                    });
                  });
                });
              },
              child: const Text('Default Theme'),),
            PopupMenuItem(
              onTap: (){
                _gMapController.future.then((value)
                {
                  DefaultAssetBundle.of(context).loadString('themes/NightTheme.json').then((style)
                  {
                    value.setMapStyle(style);
                    setState(() {
                      themeForMap = style;
                      _applyMapTheme('themes/NightTheme.json');
                    });
                  });
                });
              },
              child: const Text('Night Theme'),),
            PopupMenuItem(
              onTap: (){
                _gMapController.future.then((value)
                {
                  DefaultAssetBundle.of(context).loadString('themes/RetroTheme.json').then((style)
                  {
                    value.setMapStyle(style);
                    setState(() {
                      themeForMap = style;
                      _applyMapTheme('themes/RetroTheme.json');
                    });
                  });
                });
              },
              child: const Text('Retro Theme'),),
            PopupMenuItem(
              onTap: (){
                _gMapController.future.then((value)
                {
                  DefaultAssetBundle.of(context).loadString('themes/SilverTheme.json').then((style)
                  {
                    value.setMapStyle(style);
                    setState(() {
                      themeForMap = style;
                      _applyMapTheme('themes/SilverTheme.json');
                    });
                  });
                });
              },
              child: const Text('Silver Theme'),),
          ],),
          ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.tealAccent, Colors.teal],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.5],
                tileMode: TileMode.clamp,
              ),
          ),
        ),
        ),
        body: Column(
          children: [
            TextFormField(
          onTap: () {
            isSuggestionsVisible = !isSuggestionsVisible;},
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Search',
              ),
            ),
            SizedBox(
                  height: isSuggestionsVisible ? 200 : 0,
                  child: ListView.builder(
                    itemCount: listForPlaces.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {
                          List<Location> locations = await locationFromAddress(
                            listForPlaces[index]['description'],
                          );

                          if (locations.isNotEmpty) {
                            final LatLng selectedLatLng = LatLng(
                              locations.last.latitude,
                              locations.last.longitude,
                            );

                            // Move the camera to the selected location
                            _mapController.animateCamera(
                              CameraUpdate.newLatLngZoom(selectedLatLng, 15),
                            );

                            // Add a marker at the selected location
                            Marker marker = Marker(
                              markerId: const MarkerId('selectedLocation'),
                              position: selectedLatLng,
                              infoWindow: const InfoWindow(title: 'Selected Location'),
                            );

                            setState(() {
                              _markers.clear();
                              _markers.add(marker);
                              isSuggestionsVisible = false;
                            });
                          }
                        },
                        title: Text(listForPlaces[index]['description']),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(0.0, 0.0),
                      zoom: 15.0,
                    ),
                    //mapType: MapType.normal,
                    onMapCreated: (GoogleMapController controller) {
                      setState(() {
                        _mapController = controller;
                        _controller = controller as TextEditingController;
                        controller.setMapStyle(themeForMap);
                        _gMapController.complete(controller);
                      });
                    },
                    markers: _markers,
                    //mapType: _mapType,
                  ),
                ),
              ],
          )
    )
    );
  }
  //MapType _mapType = MapType.normal;
}
