# Run from repo root
# sh ./scripts/clean/clean-mmt-transportation-framework.sh

# Prior effort to use MSL Montana Transportation framework was unworkable -- large file, messy fields
# # initial cleanup at full-scale
# # Doing some filtering here to avoid massive file sizes
# mapshaper "./data/raw/msl/mt-transportation-framework.zip" \
#     -proj wgs84 \
#     -rename-layers roads target=RoadCenterLine \
#     -dissolve fields=LSt_Name,LSt_Typ,RoadClass,St_Name,St_PosTyp, target=roads\
#     -filter "['Primary','Secondary','Local'].includes(this.properties.RoadClass)" target=roads \
#     -o gj2008 precision=0.00001 data/processed/original-resolution/mt-roads.geojson target=roads


# Highways
mapshaper "./data/raw/mdt/Montana_On_System_Routes.zip" \
    -proj wgs84 \
    -rename-layers highways target=MT_Statewide_Routes \
    -o gj2008 precision=0.00001 data/processed/original-resolution/mt-highways.geojson target=highways

# Local roads
mapshaper "./data/raw/mdt/Montana_Off_System_Routes.zip" \
    -proj wgs84 \
    -rename-layers streets target=MT_Statewide_Routes \
    -o gj2008 precision=0.00001 data/processed/original-resolution/mt-local-roads.geojson target=streets

# Combine together 
mapshaper data/processed/original-resolution/mt-highways.geojson data/processed/original-resolution/mt-local-roads.geojson combine-files \
    -merge-layers \
    -o gj2008 precision=0.00001 data/processed/original-resolution/mt-all-roads.geojson

# Exports

for scale in 1000 100 10 1; do
    mapshaper "data/processed/original-resolution/mt-highways.geojson" \
        -simplify keep-shapes interval=${scale} \
        -o gj2008 precision=0.00001 data/processed/${scale}m-resolution/mt-highways-${scale}m.geojson
done

for scale in 1000 100 10 1; do
    mapshaper "data/processed/original-resolution/mt-local-roads.geojson" \
        -simplify keep-shapes interval=${scale} \
        -o gj2008 precision=0.00001 data/processed/${scale}m-resolution/mt-local-roads-${scale}m.geojson
done

for scale in 1000 100 10 1; do
    mapshaper "data/processed/original-resolution/mt-all-roads.geojson" \
        -simplify keep-shapes interval=${scale} \
        -o gj2008 precision=0.00001 data/processed/${scale}m-resolution/mt-all-roads-${scale}m.geojson
done

## Filter to small files for specific counties
# To make for easier imports for local mapping

for scale in 10 1; do
    # TODO - figure out how to insert county variable in filter function and set up a nested for loop w/ multiple counties
    county="YELLOWSTONE"
    mapshaper "data/processed/original-resolution/mt-all-roads.geojson" \
        -simplify keep-shapes interval=${scale} \
        -filter 'COUNTY == "YELLOWSTONE"' \
        -o gj2008 precision=0.00001 data/processed/${scale}m-resolution/${county}/mt-all-roads-${scale}m.geojson

    county="MISSOULA"
    mapshaper "data/processed/original-resolution/mt-all-roads.geojson" \
        -simplify keep-shapes interval=${scale} \
        -filter 'COUNTY == "MISSOULA"' \
        -o gj2008 precision=0.00001 data/processed/${scale}m-resolution/${county}/mt-all-roads-${scale}m.geojson

    county="GALLATIN"
    mapshaper "data/processed/original-resolution/mt-all-roads.geojson" \
        -simplify keep-shapes interval=${scale} \
        -filter 'COUNTY == "GALLATIN"' \
        -o gj2008 precision=0.00001 data/processed/${scale}m-resolution/${county}/mt-all-roads-${scale}m.geojson

    county="FLATHEAD"
    mapshaper "data/processed/original-resolution/mt-all-roads.geojson" \
        -simplify keep-shapes interval=${scale} \
        -filter 'COUNTY == "FLATHEAD"' \
        -o gj2008 precision=0.00001 data/processed/${scale}m-resolution/${county}/mt-all-roads-${scale}m.geojson

    county="CASCADE"
    mapshaper "data/processed/original-resolution/mt-all-roads.geojson" \
        -simplify keep-shapes interval=${scale} \
        -filter 'COUNTY == "CASCADE"' \
        -o gj2008 precision=0.00001 data/processed/${scale}m-resolution/${county}/mt-all-roads-${scale}m.geojson

    county="LEWIS-AND-CLARK"
    mapshaper "data/processed/original-resolution/mt-all-roads.geojson" \
        -simplify keep-shapes interval=${scale} \
        -filter 'COUNTY == "LEWIS AND CLARK"' \
        -o gj2008 precision=0.00001 data/processed/${scale}m-resolution/${county}/mt-all-roads-${scale}m.geojson

done