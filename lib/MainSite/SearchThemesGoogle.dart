import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gis_google/MainSite/InfoPage.dart';
import 'package:gis_google/MainSite/SettingsPage.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ThemesAndPlaces extends StatefulWidget {
  @override
  State<ThemesAndPlaces> createState() => _MapWithThemesAndPlacesState();
}

class _MapWithThemesAndPlacesState extends State<ThemesAndPlaces> {

  // Definieren von Sichtbarkeiten
  bool isThirdTileVisible = false;
  bool isSuggestionsVisible = false;

  String themeForMap = ''; // Leeren themeString erstellen, um Themes zu wechseln
  String tokenForSession = '37465'; // Geocoding Token

  // Erstellung des Uuid
  var uuid = const Uuid();
  List<dynamic> listForPlaces = [];

  // Definieren der versch. Controller
  TextEditingController _controller = TextEditingController();
  final Completer<GoogleMapController> _gMapController = Completer();
  GoogleMapController? _mapController;

  // Definieren der Marker
  Set<Marker> _markers = {};
  MapType _mapType = MapType.normal;
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(52.54432970969272, 13.35263030002268),
    zoom: 16,
  );

  final List<Marker> marker = [];
  final List<Marker> markerList = const[Marker(markerId: MarkerId('First'),position: LatLng(52.54493956012626, 13.354306644470789),infoWindow: InfoWindow(title: 'Home'))];

  // App Start
  @override
  void initState() {
    super.initState();
    //_markers.addAll(markerList);
    _controller.addListener(() {
      onModify();
    });
    DefaultAssetBundle.of(context).loadString('themes/DarkTheme.json').then((value) {
      themeForMap = value;
    });
    packData();
  }

  // GPS-Berechtigungsabfrage
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

  // Abfrage der Userlocation
  packData()
  {
    getUserLocation().then((value) async
    {
      print('My location');
      print('${value.latitude}, ${value.longitude}');

      // Erstellung des Markers, Zoom auf Position
      _markers.add(
          Marker(markerId: const MarkerId('Position'),
              position: LatLng(value.latitude, value.longitude),
              infoWindow: const InfoWindow(
                title: 'Meine Position',
              ))
      );
      CameraPosition cameraPosition = CameraPosition(
          target: LatLng(value.latitude, value.longitude),
          zoom: 18
      );
      final GoogleMapController controller = await _gMapController.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {

      });
    });
  }

  // Vorschläge, (reverse) Geocoding
  void makeSuggestion(String input) async {
    String googlePlacesAPIKey = 'API_KEY';
    String groundURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$groundURL?input=$input&key=$googlePlacesAPIKey&sessiontoken=$tokenForSession';

    var responseResult = await http.get(Uri.parse(request)); // Suche
    var Resultdata = responseResult.body.toString();

    // Wenn erfolgreich, dann liefere Liste mit Vorschlägen zurück
    if (responseResult.statusCode == 200) {
      setState(() {
        listForPlaces = jsonDecode(responseResult.body.toString())['predictions'];
      });
      // Ansonsten Fehlermeldung
    } else {
      throw Exception('Showing data failed, Try Again');
    }
  }

  void onModify() {
    if (tokenForSession == null) {
      setState(() {
        tokenForSession = uuid.v4();
      });
    }
    makeSuggestion(_controller.text);
  }

  // Kartenthemewechsel
  void _applyMapTheme(String themePath) {
    if (_mapController != null) {
      DefaultAssetBundle.of(context).loadString(themePath).then((value) {
        _mapController!.setMapStyle(value);
        setState(() {
          themeForMap = value;
        });
      });
    }
  }

  // Seitenlayout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps Suche'),
        centerTitle: true,
        backgroundColor: Colors.cyan.shade300,
        actions: [
          // Dreipunkte-Menü
          PopupMenuButton(
            itemBuilder: (context) => [
              // Einzelne Einträge (Themes)
              PopupMenuItem(
                onTap: () {
                  // Lade Theme
                  _gMapController.future.then((value) {
                    DefaultAssetBundle.of(context)
                        .loadString('themes/AubergineTheme.json')
                        .then((style) {
                      value.setMapStyle(style);
                      setState(() {
                        _applyMapTheme('themes/AubergineTheme.json');
                      });
                    });
                  });
                },
                child: const Text('Aubergine Theme'),
              ),
              PopupMenuItem(
                onTap: () {
                  _gMapController.future.then((value) {
                    DefaultAssetBundle.of(context)
                        .loadString('themes/DarkTheme.json')
                        .then((style) {
                      value.setMapStyle(style);
                      setState(() {
                        _applyMapTheme('themes/DarkTheme.json');
                      });
                    });
                  });
                },
                child: const Text('Dark Theme'),
              ),
              PopupMenuItem(
                onTap: () {
                  _gMapController.future.then((value) {
                    DefaultAssetBundle.of(context)
                        .loadString('themes/DefaultTheme.json')
                        .then((style) {
                      value.setMapStyle(style);
                      setState(() {
                        _applyMapTheme('themes/DefaultTheme.json');
                      });
                    });
                  });
                },
                child: const Text('Default Theme'),
              ),
              PopupMenuItem(
                onTap: () {
                  _gMapController.future.then((value) {
                    DefaultAssetBundle.of(context)
                        .loadString('themes/NightTheme.json')
                        .then((style) {
                      value.setMapStyle(style);
                      setState(() {
                        _applyMapTheme('themes/NightTheme.json');
                      });
                    });
                  });
                },
                child: const Text('Night Theme'),
              ),
              PopupMenuItem(
                onTap: () {
                  _gMapController.future.then((value) {
                    DefaultAssetBundle.of(context)
                        .loadString('themes/RetroTheme.json')
                        .then((style) {
                      value.setMapStyle(style);
                      setState(() {
                        _applyMapTheme('themes/RetroTheme.json');
                      });
                    });
                  });
                },
                child: const Text('Retro Theme'),
              ),
              PopupMenuItem(
                onTap: () {
                  _gMapController.future.then((value) {
                    DefaultAssetBundle.of(context)
                        .loadString('themes/SilverTheme.json')
                        .then((style) {
                      value.setMapStyle(style);
                      setState(() {
                        _applyMapTheme('themes/SilverTheme.json');
                      });
                    });
                  });
                },
                child: const Text('Silver Theme'),
              ),
            ],
          ),
        ],
      ),
      // Burger-Menü (Dreistrichemenü)
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Hauptmenü'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            // Einzelne Einträge des Menüs
            ListTile(
              title: Text('Karte'),
              onTap: () {
                Navigator.pop(context); // Schließt das Menü
                // Wechsel zu anderer Seite
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ThemesAndPlaces()),
                );
              },
            ),
            ListTile(
              title: Text('Info'),
              onTap: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => InfoPage()),
                );
              },
            ),
            ListTile(
              title: Text('Position aktualisieren'),
              onTap: (){
                packData();
              },
            ),
            // Placeholder "Einstellungen". Mit visible=false aktuell nicht sichtbar
            Visibility(
              visible: isThirdTileVisible,
              child: ListTile(
                title: Text('Einstellungen'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          // Suchfeld
          TextFormField(
            onTap: () {
              setState(() {
                isSuggestionsVisible = true;
              });
            },
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Suchen',
            ),
          ),
          // Vorschlägebox
          SizedBox(
            // Erst wenn auf Suchleiste draufgeklickt wird, ist Vorschlägebox sichtbar
            height: isSuggestionsVisible ? 225 : 0,
            child: ListView.builder(
              itemCount: listForPlaces.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () async {
                    // Warte auf Texteingabe durch Benutzer, bis locationFromAddress() ausgeführt wird
                    List<Location> locations = await locationFromAddress(
                      listForPlaces[index]['description'],
                    );

                    // Bei Klick auf eine Location wird Lat und Lon übergeben
                    if (locations.isNotEmpty) {
                      final LatLng selectedLatLng = LatLng(
                        locations.last.latitude,
                        locations.last.longitude,
                      );

                      // Animation zu vorher ausgewählter Lat und Lon
                      _mapController!.animateCamera(
                        CameraUpdate.newLatLngZoom(selectedLatLng, 15),
                      );

                      // Erstellen eines Markers für Lat und Lon
                      Marker marker = Marker(
                        markerId: const MarkerId('selectedLocation'),
                        position: selectedLatLng,
                        infoWindow: const InfoWindow(title: 'Ausgewählter Ort'),
                      );

                      // Wieder Deaktivieren der Vorschlägebox und Platzieren des vorher erstellten Markers
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
          // Google Maps Widget
          Expanded(
            child: GoogleMap(
              initialCameraPosition: _initialPosition,
              onMapCreated: (GoogleMapController controller) {
                setState(() {
                  _mapController = controller;
                  _gMapController.complete(controller);
                });
              },
              mapType: _mapType,
              markers: _markers,
            ),
          ),
        ],
      ),
    );
  }
}