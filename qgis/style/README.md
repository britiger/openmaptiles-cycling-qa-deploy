# QGIS Style

This is a QGIS Style which is converted by [mapbox2qgis](https://github.com/wonder-sk/mapbox2qgis.git) and modified to display colored cycling related tagging.

After opening the `tiles.mbtiles` you can load the style in the properties.

To get a better overview there are prefer to display major roads.

Description of colors in style:
- purple glow: roads maxspeed > 70 and no cycleway
- red glow: roads without cycleway
- blue glow: bicycle road
- green neon: bicycle lane / shared lane on road 
- cyan: optional bicycle track existing
- green: mandatory bicycle track exiting 
- blue: this is a bicycle track which you have to use
- red dotted: non motorway where bicycle are forbidden
- Colors which show missing information:
  - orange glow: road without any cycleway, without defined maxspeed in source (OpenStreetMap)
  - orange: bicycle tagging missing in source
  - green dashed: bicycle track existing but no information about mandatory nor optional cycleway
