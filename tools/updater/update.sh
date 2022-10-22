#!/bin/bash

#
# Run Update tiles
#

# try flock
exec 43>/tmp/update_omt.lock
flock -n -x 43
if [ $? -ne 0 ]
then
  echo "Already running."
  exit 0
fi

cd /opt/openmaptiles-cycling-qa

# Stop Downloading diffs while updating tiles
make stop-update-osm

cd data

# Generate all tiles to replace using tile_multitiler
source ../.env ; \
sort ./*/*.tiles | uniq | \
python3 ../../openmaptiles-cycling-qa-deploy/tools/multitiler/tile_multiplier.py ${MIN_ZOOM} ${MAX_ZOOM} > tiles.txt \
&& sudo rm ./*/*.tiles

# split tiles.txt into levels - not needed anymore but better to see process
for lvl in `seq ${MIN_ZOOM} ${MAX_ZOOM}`
do
  grep "^${lvl}/" tiles.txt >> tiles.${lvl}.txt
done

cd  ..

# update level by level
for lvl in `seq ${MIN_ZOOM} ${MAX_ZOOM}`
do
  echo `date` Start Process Level ${lvl} - $(cat data/tiles.${lvl}.txt | wc -l) Tiles ...
  cp data/tiles.${lvl}.txt data/tiles.txt
  docker-compose run generate-changed-vectortiles && rm data/tiles.${lvl}.txt && rm data/tiles.txt
done

echo `date` Finish

# Starting downloading diffs into database
make start-update-osm

# make fast replace without blocking
mv data/tiles.mbtiles data/tiles_online.mbtiles
docker restart mbtileserver
cp data/tiles_online.mbtiles data/tiles.mbtiles
