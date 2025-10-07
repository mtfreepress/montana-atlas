
# Run from repo root
# sh ./scripts/clean/clean-mt-reservations.sh

# TODO - clean up data fields

layer_slug="mt-reservations"

# Load shared env helpers for MAPSHAPER
if [ -f "./scripts/env.sh" ]; then
    # supress not following (SC1091) warning
    # shellcheck source=/dev/null
    . "./scripts/env.sh"
fi

# full-scale 
# Filters out off-res trust land
ms_if_exists "./data/raw/msl/${layer_slug}.zip" \
    -proj wgs84 \
    -rename-layers reservations,trust_land \
    -o gj2008 data/processed/original-resolution/${layer_slug}.geojson target=reservations

#
for scale in 1000 100 10 1; do
    $MAPSHAPER "data/processed/original-resolution/${layer_slug}.geojson" \
        -simplify keep-shapes interval=${scale} \
        -o gj2008 precision=0.00001 data/processed/${scale}m-resolution/${layer_slug}-${scale}m.geojson
done

# Resolutions in meters (duplicate loop retained from original; also use $MAPSHAPER)
for scale in 1000 100 10 1; do
    $MAPSHAPER "data/processed/original-resolution/${layer_slug}.geojson" \
        -simplify keep-shapes interval=${scale} \
        -o gj2008 precision=0.00001 data/processed/${scale}m-resolution/${layer_slug}-${scale}m.geojson
done