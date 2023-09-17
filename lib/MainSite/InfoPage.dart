import 'package:flutter/material.dart';
import 'package:gis_google/MainSite/SearchThemesGoogle.dart';
import 'package:gis_google/MainSite/SettingsPage.dart';

class InfoPage extends StatefulWidget {

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {

  bool isThirdTileVisible = false;
  String gitname = 'xplore';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info'),
        centerTitle: true,
        backgroundColor: Colors.cyan.shade300,
      ),
      drawer: Drawer(
        // Hier können Sie die Inhalte Ihres Hamburger-Menüs hinzufügen
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Hauptmenü'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Karte'),
              onTap: () {
                // Hier können Sie zur Startseite Ihrer App navigieren
                Navigator.pop(context); // Schließt das Menü
                // Hier können Sie zur Startseite Ihrer App navigieren
                // Beispiel:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ThemesAndPlaces()),
                );
              },
            ),
            ListTile(
              title: Text('Info'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => InfoPage()),
                );
              },
            ),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text('Über Xplore',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),),
            SizedBox(height: 16.0),
            Text('Diese App wurde von Nico Haupt im 2. Semester an der BHT als Abschlussprojekt für das Modul GIS Geländepraktikum erstellt.',
            textAlign: TextAlign.center,style: TextStyle(fontSize: 16.0),),
            SizedBox(height: 16.0,),
            Text('Als Karten-, Geocoding- und Geolocationservice werden die Google-APIs verwendet.\nDer gesamte Quellcode ist auf Github zu finden. Als Programmiersprache wurde Flutter verwendet.\nEs erfolgt kein weiterer Support für die App.',textAlign: TextAlign.center,style: TextStyle(fontSize: 16.0),),
            SizedBox(height: 40),
            Image.asset('assets/github.png', width: 100,height: 100),
            SizedBox(height: 5.0),
            Text('https://github.com/s92854/$gitname',textAlign: TextAlign.center,style: TextStyle(fontSize: 16.0),),
            SizedBox(height: 150.0),
            Image.asset('assets/bht_anthrazit.png',alignment: Alignment.center,width: 300,height: 75),
          ],
        ),
      ),
    );
  }
}