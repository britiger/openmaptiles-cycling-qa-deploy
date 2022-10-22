# Beschreibung cycling-qa Farben und Tags

## Kennzeichung der Radwege

Fahhradstraße: 
 - Farbe: Blau leuchtend
 - Tag: bicycle_road = yes
 
Optionaler Radweg:
 - Frabe: Blau gestrichelt
 - Tag: traffic_sign traffic_sign:both traffic_sign:left traffic_sign:right enthält DE:1022-10
 
Benutzungspflichtiger Radweg:
 - Farbe: Blau Linie
 - Tag: traffic_sign traffic_sign:both traffic_sign:left traffic_sign:right enthällt DE:240 DE:237 DE:244.1 DE:241

## Kennzeichnung der Straßen

Die Einfährbung erfolgt in Abhängigkeit von der Fahrtrichtung

Die Darstellung erfolgt nur für folgende Straßen:
 - motorroad != yes
 - highway = primary seconday tertiary

### Nutzungsart der Radwege an Straßen

Optionaler Radweg vorhanden:
 - Farbe: Türkis
 - Tags: 
     - bicycle bicycle:backward bicycle:forward = optional_sidepath oder
     - sidewalk:bicycle sidewalk:bicycle:left sidewalk:bicycle:both = yes

Benutzungspflichtiger Radweg vorhanden:
 - Farbe: Grün
 - Tags: bicycle bicycle:backward bicycle:forward = use_sidepath

Radfahren verboten (Radweg nicht vorhanden)
 - Frabe: Rot gestrichelt
 - Tags: bicyle bicycle:backward bicycle:forward = no

### Position der Radwege

Radwegführung auf der Straße:
 - Farbe: Gelbgrün
 - Tags: cycleway cycleway:both cycleway:left cycleway:right = lane shared_lane share_busway

Informationen zur Position fehlen:
 - Farbe: Orange
 - Tags:
     - bicycle != no und
     - cycleway cycleway:both cycleway:left cycleway:right ist nicht gesetzt

Radweg ist vorhanden (Information zur Nutzungsart fehlt):
 - Farbe: Grün gestrichelt
 - Tags: 
     - cycleway cycleway:both cycleway:left cycleway:right ist track seperate und 
     - bicycle bicycle:backward bicycle:forward != use_sidepath optional_sidepath oder sidewalk:bicycle sidewalk:bicycle:left sidewalk:bicycle:both != yes

Straße ohne Radwegeinfrastruktur:
 - Farbe: 
     - Rot leuchtend (bei maxspeed <= 70)
     - Mangenta leuchtend (bei maxspeed > 70)
     - Orange leuchtend (maxspeed nicht vorhanden)
 - Tags: cycleway cycleway:both cycleway:left cycleway:right ist no
