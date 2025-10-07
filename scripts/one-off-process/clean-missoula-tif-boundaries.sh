# Run from repo root
# sh ./scripts/clean/clean-missoula-tif-boundaries.sh

# Process for Missoula-scale locator map
if [ -f "./scripts/env.sh" ]; then
    # shellcheck source=/dev/null
    . "./scripts/env.sh"
fi

$MAPSHAPER "./data/raw/one-off/city-of-missoula-tif-boundaries.geojson" \
        -proj wgs84 \
        -simplify keep-shapes interval=10 \
        -o gj2008 data/one-off/city-of-missoula-tif-boundaries.geojson