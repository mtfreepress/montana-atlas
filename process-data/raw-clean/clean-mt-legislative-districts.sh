
# Run from repo root
# sh ./process-data/raw-clean/clean-mt-legislative-districts.sh
# Note: Source data includes both House and Senate districts

# TODO - clean up data fields

layer_slug="mt-legislative-districts"


# full-scale 
mapshaper "./data/raw-by-source/msl/"${layer_slug}".zip" \
    -proj wgs84 \
    -rename-layers house,senate \
    -o data/processed/original-resolution/${layer_slug}-house.geojson target=house \
    -o data/processed/original-resolution/${layer_slug}-senate.geojson target=senate

# House Districts

# Resolutions in meters
for scale in 1000 100 10 1; do
    mapshaper "data/processed/original-resolution/${layer_slug}-house.geojson" \
        -simplify keep-shapes interval=${scale} \
        -o precision=0.00001 data/processed/${scale}m-resolution/${layer_slug}-house-${scale}m.geojson
done


# Senate Districts
# Resolutions in meters
for scale in 1000 100 10 1; do
    mapshaper "data/processed/original-resolution/${layer_slug}-senate.geojson" \
        -simplify keep-shapes interval=${scale} \
        -o precision=0.00001 data/processed/${scale}m-resolution/${layer_slug}-senate-${scale}m.geojson
done
