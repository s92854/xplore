import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:gis_google/MainSite/InfoPage.dart';
import 'package:gis_google/MainSite/SearchThemesGoogle.dart';
import 'package:gis_google/MainSite/SettingsPage.dart';

class WelcomePage extends StatefulWidget {

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  bool isThirdTileVisible = false;

  @override
  Widget build(BuildContext context) {
    TextSpan textSpan = TextSpan(
      style: TextStyle(
        fontFamily: 'Arial',
        fontSize: 18,
        color: Colors.black,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Info'),
        centerTitle: true,
        backgroundColor: Colors.cyan.shade300,
      ),
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
            ListTile(
              title: Text('Karte'),
              onTap: () {
                Navigator.pop(context); // Schließt das Menü
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
            SizedBox(height: 40),
            Text('Willkommen bei Xplore',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),),
            SizedBox(height: 25.0),
            Text('Xplore ist eine interaktive, Google Maps basierte Karte mit Geocoding und Geolocalization Features.\nWeitere Infos im "Infos" Tab.',
              textAlign: TextAlign.center,style: TextStyle(fontSize: 18.0),),
            SizedBox(height: 16.0,),
            Text('Damit die App richtig funktioniert, gewähre der App permanenten Zugriff auf deinen Standort.',textAlign: TextAlign.center,style: TextStyle(fontSize: 16.0),),
            SizedBox(height: 20),
            RichText(textAlign: TextAlign.center,
              text: TextSpan(
              children: <InlineSpan> [
                TextSpan(
                  text: 'Über das Hamburger Menü ', style: TextStyle(color: Colors.black),
                ),
                WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Image.asset('assets/hamburger_icon.png', width: 15, height:15),),
                TextSpan(
                  text: ' auf der linken Seite der Appleiste, kann man ganz leicht zwischen den verschiedenen Seiten wechseln.\nÜber', style: TextStyle(color: Colors.black),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Image.asset('assets/mehr_icon.png', width: 15, height:15),),
                TextSpan(
                  text: 'auf der rechten Seite der Appleiste, kann man verschiedene Themes für die Karte einstellen.', style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            ),
            SizedBox(height: 40),
            FloatingActionButton(
              tooltip: 'Karte öffnen',
              backgroundColor: Colors.green.shade700,
              hoverColor: Colors.greenAccent.shade200,
              hoverElevation: 50,
              highlightElevation: 50,
              autofocus: true,
              child: Icon(Icons.map),
                onPressed: (){
                  Navigator.pushNamed(context, '/ThemesAndPlaces');
              },
            ),
            SizedBox(height: 10),
            Text('Klicke hier um zur Karte zu gelangen.')
          ],
        ),
      ),
    );
  }
}
