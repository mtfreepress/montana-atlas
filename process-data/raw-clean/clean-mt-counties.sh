
# Run from repo root
# sh ./process-data/raw-clean/clean-mt-counties.sh

# TODO - clean up data fields

layer_slug="mt-counties"

# initial cleanup at full-scale
mapshaper "./data/raw-by-source/msl/"${layer_slug}".zip" \
    -proj wgs84 \
    -rename-layers shapes,lines \
    -o data/processed/original-resolution/${layer_slug}.geojson target=shapes

# Resolutions in meters
for scale in 1000 100 10 1; do
    mapshaper "data/processed/original-resolution/${layer_slug}.geojson" \
        -simplify keep-shapes interval=${scale} \
        -o precision=0.00001 data/processed/${scale}m-resolution/${layer_slug}-${scale}m.geojson
done