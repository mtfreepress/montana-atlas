
# Run from repo root
# sh ./scripts/clean/clean-mt-congressional-districts.sh

# TODO - clean up data fields

layer_slug="mt-congressional-districts"

# Load shared env helpers for MAPSHAPER
if [ -f "./scripts/env.sh" ]; then
    # shellcheck source=/dev/null
    . "./scripts/env.sh"
fi

# initial cleanup at full-scale
ms_if_exists "./data/raw/msl/${layer_slug}.zip" \
    -proj wgs84 \
    -o gj2008 data/processed/original-resolution/${layer_slug}.geojson

# Resolutions in meters
for scale in 1000 100 10 1; do
    $MAPSHAPER "data/processed/original-resolution/${layer_slug}.geojson" \
        -simplify keep-shapes interval=${scale} \
        -o gj2008  precision=0.00001 data/processed/${scale}m-resolution/${layer_slug}-${scale}m.geojson
done