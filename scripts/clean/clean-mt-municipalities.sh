# Run from repo root
# sh ./scripts/clean/clean-mt-municipalities.sh

# Note -- raw boundaries here include Butte-Silver Bow and Anaconda Deer-Lodge as incorporated municipalities 
# TODO - figure out how to handle this elegantly for various situations

layer_slug="mt-municipalities"

mapshaper "./data/raw/msl/"${layer_slug}".zip" \
    -proj wgs84 \
    -rename-layers nogeo,municipalties \
    -o data/processed/original-resolution/${layer_slug}.geojson target=municipalties

# City centroid points
# TODO -- add special handling for Butte/Anaconda
mapshaper "data/processed/original-resolution/${layer_slug}.geojson" \
    -points \
    -o data/processed/points/${layer_slug}-points.geojson

# Boundaries
# Resolutions in meters
for scale in 1000 100 10 1; do
    mapshaper "data/processed/original-resolution/${layer_slug}.geojson" \
        -simplify keep-shapes interval=${scale} \
        -o precision=0.00001 data/processed/${scale}m-resolution/${layer_slug}-${scale}m.geojson
done