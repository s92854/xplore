import 'package:flutter/material.dart';
import 'package:gis_google/MainSite/InfoPage.dart';
import 'package:gis_google/MainSite/SearchThemesGoogle.dart';

class SettingsPage extends StatefulWidget {

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool isThirdTileVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Einstellungen'),
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
      body: Center(
        child: Text('Diese Seite ist noch leer.'),
      ),
    );
  }
}