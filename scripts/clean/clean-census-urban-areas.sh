layer_slug="census-urban-areas-2020"

mapshaper "./data/raw/us-census/"${layer_slug}".zip" \
    -proj wgs84 \
    -filter "this.properties.NAME20.slice(-2) === 'MT'" \
    -o gj2008 data/processed/original-resolution/${layer_slug}.geojson

# Boundaries
# Resolutions in meters
for scale in 1000 100 10 1; do
    mapshaper "data/processed/original-resolution/${layer_slug}.geojson" \
        -simplify keep-shapes interval=${scale} \
        -o gj2008 precision=0.00001 data/processed/${scale}m-resolution/${layer_slug}-${scale}m.geojson
done