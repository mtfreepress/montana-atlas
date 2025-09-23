# Run from repo root
# sh ./scripts/clean/clean-missoula-tif-boundaries.sh

# Process for Missoula-scale locator map
mapshaper "./data/raw/one-off/city-of-missoula-tif-boundaries.geojson" \
    -proj wgs84 \
    -simplify keep-shapes interval=10 \
    -o gj2008 data/one-off/city-of-missoula-tif-boundaries.geojson