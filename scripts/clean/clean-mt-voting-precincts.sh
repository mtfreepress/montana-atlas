
# Run from repo root
# sh ./scripts/clean/clean-mt-voting-precincts.sh

# TODO - clean up data fields

layer_slug="mt-voting-precincts"

# initial cleanup at full-scale
mapshaper "./data/raw/msl/"${layer_slug}".zip" \
    -proj wgs84 \
    -o data/processed/original-resolution/${layer_slug}.geojson

# Resolutions in meters
# No 1000m scale here because these geographies are too fine for that
for scale in 100 10 1; do
    mapshaper "data/processed/original-resolution/${layer_slug}.geojson" \
        -simplify keep-shapes interval=${scale} \
        -o precision=0.00001 data/processed/${scale}m-resolution/${layer_slug}-${scale}m.geojson
done
