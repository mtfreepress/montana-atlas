
# Run from repo root
# sh ./scripts/clean/clean-national-parks.sh

layer_slug="national-parks"

# initial cleanup at full-scale
mapshaper "./data/raw/msl/"${layer_slug}".zip" \
    -proj wgs84 \
    -o gj2008 data/processed/original-resolution/${layer_slug}.geojson

# Version filtered to just Yellowstone and Glacier
mapshaper data/processed/original-resolution/${layer_slug}.geojson \
    -filter "this.properties.UNIT_TYPE === 'National Park'" \
    -o gj2008 data/processed/original-resolution/${layer_slug}-ynp-gnp-only.geojson

# Resolutions in meters
for scale in 1000 100 10 1; do
    mapshaper "data/processed/original-resolution/${layer_slug}.geojson" \
        -clip data/processed/original-resolution/mt-state-boundary.geojson \
        -simplify keep-shapes interval=${scale} \
        -o gj2008 precision=0.00001 data/processed/${scale}m-resolution/${layer_slug}-${scale}m.geojson
done

for scale in 1000 100 10 1; do
    mapshaper "data/processed/original-resolution/${layer_slug}-ynp-gnp-only.geojson" \
        -simplify keep-shapes interval=${scale} \
        -o gj2008 precision=0.00001 data/processed/${scale}m-resolution/${layer_slug}-ynp-gnp-only-${scale}m.geojson
done
