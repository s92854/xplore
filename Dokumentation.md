# Dokumentation zur App "Xplore"

## Aufgabenstellung
Die Aufgabenstellung stellte mir frei, ob ich eine App oder Webanwendung als Abschlussprojekt erstellen möchte. Beides ist heutzutage weit verbreitet. Für das Hosten einer Webseite ist eine Domain zu mieten/ kaufen. Daher fiel meine Entscheidung auf die (Android) App.

## Lösungsansatz 1 [VERWORFEN]

<img src="https://github.com/s92854/xplore/assets/134683810/8773e9d8-3834-4933-b796-17acb50c68ba" alt="drawing" width="500"/>

&nbsp;

Da die Aufgabenstellung viel kreativen Freiraum ließ, wollte ich anfangs eine zu komplexe App erstellen. Diese sollte neben der Karte und dem Geocoding auch eine API verwenden, die den CO2-Ausstoß der eingegebenen Route berechnet.
Als Kartenservice überlegte ich mir Mapbox zu verwenden, da diese laut Anbieterdokumentationen sehr einfach zu bedienen und zu programmieren ist, sowie eine gute dreidimensionale Karte bietet.

<img src="https://github.com/s92854/xplore/assets/134683810/14e91780-fa33-4233-8f00-21b21e0a9824" alt="drawing" width="500"/>

&nbsp;

Ich entschied mich zu Beginn der Programmierarbeiten für die Programmiersprache Kotlin. Es dauerte eine Weile, bis es mir gelang, eine Mapboxkarte in der App zum Laufen zu bekommen, da ab Mapboxversion 10, die Paketnamen geändert wurden und die richtige Dokumentationsseite, auf der der aktuelle Implementierungscode steht, schwer zu finden war.
Anschließend versuchte ich den Geocoder zu implementieren. Doch aufgrund von Versionsinkompatibilitäten gelang dies nicht. Ich fuhr fort und wollte die Searchbox von Mapbox implementieren. Selbes Problem! Als ich die API für die CO2-Emission einbinden wollte, musste ich feststellen, dass diese mittlerweile gelöscht wurde.
Nach Einbindung einer Startseite, sowie eines FloatingActionButton's, der dazu diente, zur Startseite zurückzukehren, sah der Kartenteil der App mittlerweile so aus:

<img src="https://github.com/s92854/xplore/assets/134683810/9284a645-ba21-449d-9a10-a2d93d83679d" alt="drawing" height="500"/>

&nbsp;

Nachdem ich ca. 4 Wochen vergebens nach allen für mich möglichen Lösungen gesucht habe, musste ich diese Version der App aufgeben und startete mit einem völlig neuen Ansatz.

## Lösungsansatz 2 [FINAL]
Ich installierte die Erweiterung Flutter und stieg auf die Google Maps Services um. Nachdem ich innerhalb weniger Minuten den für die Google Maps Services nötigen API Key angefordert und die Google Karte implementiert hatte, baute ich nach und nach alle Funktionen ein, die ich für die zweite Version der App geplant hatte. Diese sind unter dem nächsten Punkt zu finden.

## Installation, Bedienung und Funktionen von Xplore
Die App Xplore wird per Android .apk Datei [hier](https://github.com/s92854/xplore/releases/tag/update2) zur freien Installation bereitgestellt. Zusätzlich ist der Quellcode auf [Github](https://github.com/s92854/xplore) einsehbar. In den Android Einstellungen muss "Installation aus unsicheren Quellen" aktiviert werden. Anschließend kann die heruntergeladene Datei durch Öffnen dieser installiert werden.

Über das während der Installation erstellte Starticon auf dem mobilen Endgerät, kann die App geöffnet werden. Folgender Startbildschirm mit Instruktionen und Erläuterungen erscheint:

<img src="https://github.com/s92854/xplore/assets/134683810/a1a6e26a-3e85-4e10-8414-155e2a2a5540" alt="drawing" height="500"/>

&nbsp;

Über das Hamburger Menü sind nun folgende Funktionen, wie im Screenshot dargestellt, verfügbar:

<img src="https://github.com/s92854/xplore/assets/134683810/24710c8a-2bfa-46c6-9add-e62c46c5afcd" alt="drawing" height="500"/>

&nbsp;

Der Menüpunkt "Position aktualisieren" führt eine erneute Positionsabfrage des Gerätes durch, setzt einen Marker an die aktuellen Koordinaten und bewegt die darstellende Kartenkamera zum derzeitigen Standpunkt, falls die Ansicht der dargestellten Parameter (Latitude, Longitude, Zoom), ggf. aus der Suchfunktion, von der aktuellen Position abweicht.

Der Menüpunkt "Info" öffnet eine Informationsseite zur App.

<img src="https://github.com/s92854/xplore/assets/134683810/ee5e4aad-f825-4e06-bdc7-eedd180bbac0" alt="drawing" height="500"/>

&nbsp;

Der Button mit dem Kartensymbol, ebenso wie die Registerkarte "Karte" im Hamburger Menü, leitet einen zur eingebunden Google Karte weiter.
Auf dieser Seite muss zunächst die Berechtigung zur Standortabfrage erteilt werden.

<img src="https://github.com/s92854/xplore/assets/134683810/e9d49265-485f-4cd4-8df1-cc62f915a394" alt="drawing" height="500"/>

&nbsp;

Nun besteht auf der Seite einerseits die Möglichkeit die Suchfunktion mit Autofill zu nutzen, sowie über das Popupmenü mit den drei Punkten in der Appleiste, das Design der Karte mittels Auswahl vorgegebener Themes zu ändern.

<img src="https://github.com/s92854/xplore/assets/134683810/a7bee283-fac7-4d8b-9ddb-816b2b7429e8" alt="drawing" height="500"/>

&nbsp;

Beim Klicken auf das Textfeld der Suchfunktion, öffnet sich die Autofillbox. Bei Eingabe von mindestens einem Buchstaben, schlägt die Suchfunktion einem Orte, Straßen und Points of Interest vor.

<img src="https://github.com/s92854/xplore/assets/134683810/4fee71a4-c3ac-43f2-841e-27278a714d9a" alt="drawing" height="500"/>

&nbsp;

Die App kann jederzeit mit androidüblichen Mitteln beendet werden.

## Anmerkungen
Beim wiederholten Aufruf der Karte öffnet sich ein Berechtigungsdialog bezüglich der Gültigkeit der erteilten Berechtigung der App. Hier ist es sinnvoll "Jederzeit gestatten" (Allow all the time) auszuwählen, damit sich dieser Dialog nicht jedes Mal öffnet.

<img src="https://github.com/s92854/xplore/assets/134683810/a0fd9475-3fff-4d52-910f-d38919d3a90e" alt="drawing" height="500"/>
