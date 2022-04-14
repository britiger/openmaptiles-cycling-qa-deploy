# QGIS Style

This is a QGIS Style which is converted by [mapbox2qgis](https://github.com/wonder-sk/mapbox2qgis.git) and modified to display colored cycling related tagging.

After opening the `tiles.mbtiles` you can load the style in the properties.

To get a better overview there are prefer to display major roads.

Description of colors in style:
- purple glow: roads maxspeed > 70 and no cycleway
- red glow: roads without cycleway
- green glow: bicycle road
- green neon: bicycle lane / shared lane on road 
- cyan: optional bicycle track existing
- green: mandatory bicycle track exiting or is a bicycle track
- Colors which show missing information:
  - orange glow: road without cycleway, without defined maxspeed in source
  - orange: bicycle tagging missing in source
  - green dashed: bicycle track existing but no information about mandatory nor optional
