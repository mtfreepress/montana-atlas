
# Run from repo root
# sh ./scripts/clean/clean-mt-voting-precincts.sh

# TODO - clean up data fields

layer_slug="mt-voting-precincts"

# Load shared env helpers for MAPSHAPER
if [ -f "./scripts/env.sh" ]; then
    # supress not following (SC1091) warning
    # shellcheck source=/dev/null
    . "./scripts/env.sh"
fi

# initial cleanup at full-scale
ms_if_exists "./data/raw/msl/${layer_slug}.zip" \
    -proj wgs84 \
    -o gj2008 data/processed/original-resolution/${layer_slug}.geojson

# Resolutions in meters
# No 1000m scale here because these geographies are too fine for that
for scale in 100 10 1; do
    $MAPSHAPER "data/processed/original-resolution/${layer_slug}.geojson" \
        -simplify keep-shapes interval=${scale} \
        -o gj2008 precision=0.00001 data/processed/${scale}m-resolution/${layer_slug}-${scale}m.geojson
done
