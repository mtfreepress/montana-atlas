
# Run from repo root
# sh ./process-data/raw-clean/clean-mt-reservations.sh

# TODO - clean up data fields

layer_slug="mt-reservations"

# full-scale 
# Filters out off-res trust land
mapshaper "./data/raw-by-source/msl/"${layer_slug}".zip" \
    -proj wgs84 \
    -rename-layers reservations,trust_land \
    -o data/processed/original-resolution/${layer_slug}.geojson target=reservations

#
for scale in 1000 100 10 1; do
    mapshaper "data/processed/original-resolution/${layer_slug}.geojson" \
        -simplify keep-shapes interval=${scale} \
        -o precision=0.00001 data/processed/${scale}m-resolution/${layer_slug}-${scale}m.geojson
done

# Resolutions in meters
for scale in 1000 100 10 1; do
    mapshaper "data/processed/original-resolution/${layer_slug}.geojson" \
        -simplify keep-shapes interval=${scale} \
        -o precision=0.00001 data/processed/${scale}m-resolution/${layer_slug}-${scale}m.geojson
done