# Documentation and more for modified version of OpenMapTiles for cycling QA


* You need to clone the OpenMapTiles Cycling QA repo:
```bash
git clone https://github.com/britiger/openmaptiles-cycling-qa
```

## Related Content
* [Configuration file for OpenMapTiles](config/)
* [QGIS Style file](qgis/)

## Configuration of external Database
* Install PostgreSQL 14 and postgis for [offical repository](https://wiki.postgresql.org/wiki/Apt): 
```bash
apt install postgresql-14 \
postgresql-14-postgis-3 \
postgresql-server-dev-14
```
* Clone and install required extensions:
```bash
git clone https://github.com/giggls/mapnik-german-l10n.git
git clone https://github.com/pramsey/pgsql-gzip.git

# install depend debian packages (see INSTALL.md/README.md in repo)

# create packages
cd mapnik-german-l10n
make deb
cd ../pgsql-gzip
make deb # If you have an error with gpgsign, you can ignore it
cd ..

#  Install extensions 
dpkg -i postgresql-14-gzip_1.0.1_amd64.deb
dpkg -i postgresql-14-osml10n_2.5.10_amd64.deb
```
* Create database and user for OpenMapTiles using `psql`:
```
-- OpenMapTiles / imposm3 uses old library, so only md5 is supported
-- To create a user with md5 instead of scram-sha-256
-- you have to set it while creation/modification to  md5
SET password_encryption = 'md5';

-- Create user and a SECURE password
CREATE USER omt PASSWORD 'omt' LOGIN;
CREATE DATABASE omt OWNER omt;

-- Connect to db and add extensions
CREATE EXTENSION hstore;
CREATE EXTENSION postgis;
CREATE EXTENSION gzip;
CREATE EXTENSION osml10n CASCADE;
```
* Modify `postgres.conf` and `pg_hba.conf` to access form docker:
```
$ grep listen postgresql.conf
listen_addresses = '*'		# what IP address(es) to listen on;

$ grep 172 pg_hba.conf
host    omt             omt             172.0.0.0/8           md5
```
* Restart Database: `systemctl restart postgresql`
* Modify and check you enviroment file:
```
$ grep PG openmaptiles-cycling-qa/.env 
PGDATABASE=omt
PGUSER=omt
PGPASSWORD=omt
PGHOST=192.168.0.8
PGPORT=5436
PGHOSTS_LIST=
```
* Prefill the database:
```bash
# go to openMapTiles
cd openmaptiles-cycling-qa
make import-data
```

## Initial import
* We using the default `quickstart.sh`
* Need to create a replication/update config for you regio first:
```bash
region=germany
mkdir data

# sample with hourly updates from planet
cat <<EOF >>${region}.repl.json
{
  "replication_url": "http://planet.openstreetmap.org/replication/hour/",
  "replication_interval": "1h"
}
EOF
```
* Now start processing the data:
```
./quickstart.sh ${region}
```
* After successful finish you have the tiles in `data/tiles.mbtiles`

## Update
* Start process for updating the data:
```bash
# The parameter area= is optional (requied if you have multiples osm-files in data directory)
make start-update-osm area=${region}
```
* Check status of updates:
```bash
docker logs -f $(basename `pwd`)_update-osm_1
```
* Note: If you processing updates and generate tiles it is possible to a get deadlock and the process run out of sync.
* Stop update process:
```bash
make stop-update-osm
```
* Generate list of tiles in OpenMapTiles data directory:
```bash
cd data

source ../.env ; \
sort ./*/*.tiles | uniq | \
python3 ../../openmaptiles-cycling-qa-deploy/tools/multitiler/tile_multiplier.py ${MIN_ZOOM} ${MAX_ZOOM} >> tiles.txt \
&& rm ./*/*.tiles

cd ..
```
* Start generate updated tiles:
```bash
docker-compose run generate-changed-vectortiles && rm data/tiles.txt
```
