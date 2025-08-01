
# Run from repo root
# sh ./scripts/clean/clean-mt-state-boundary.sh

# TODO - clean up data fields

layer_slug="mt-state-boundary"

# initial cleanup at full-scale
mapshaper "./data/raw/msl/"${layer_slug}".zip" \
    -proj wgs84 \
    -o data/processed/original-resolution/${layer_slug}.geojson

# Resolutions in meters
for scale in 1000 100 10 1; do
    mapshaper "data/processed/original-resolution/${layer_slug}.geojson" \
        -simplify keep-shapes interval=${scale} \
        -o precision=0.00001 data/processed/${scale}m-resolution/${layer_slug}-${scale}m.geojson
done
