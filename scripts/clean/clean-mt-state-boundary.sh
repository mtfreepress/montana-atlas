
# Run from repo root
# sh ./scripts/clean/clean-mt-state-boundary.sh

# TODO - clean up data fields

layer_slug="mt-state-boundary"

# Load shared env helpers for MAPSHAPER
if [ -f "./scripts/env.sh" ]; then
    # shellcheck source=/dev/null
    . "./scripts/env.sh"
fi

# initial cleanup at full-scale
# gj2008 flag should ensure geojson are wound in the correct direction

$MAPSHAPER_CANDIDATE="./data/raw/msl/${layer_slug}.zip"
ms_if_exists "$MAPSHAPER_CANDIDATE" \
    -proj wgs84 \
    -o gj2008 data/processed/original-resolution/${layer_slug}.geojson

# Resolutions in meters
for scale in 1000 100 10 1; do
    $MAPSHAPER "data/processed/original-resolution/${layer_slug}.geojson" \
        -simplify keep-shapes interval=${scale} \
        -o gj2008 precision=0.00001 data/processed/${scale}m-resolution/${layer_slug}-${scale}m.geojson
done
