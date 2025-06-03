# Run from repo root
# sh ./process-data/raw-clean/make-public-service-commission-districts.sh

# Makes public service commission district boundaries, defined in terms of specific house districts

layer_slug="public-service-commission-districts"

# Merge house districts into PSC districts
# dissolve2 here handles small gaps from HD boundary misalignment
mapshaper ./data/processed/original-resolution/mt-legislative-districts-house.geojson \
    -join ./data/raw-by-source/hand-compiled/hd-to-psc-districts-2024.csv  keys=DistrictNu,house_district \
    -dissolve2 gap-fill-area=10km2 psc_district \
    -o ./data/processed/original-resolution/${layer_slug}.geojson

# Resolutions in meters
for scale in 1000 100 10 1; do
    mapshaper "data/processed/original-resolution/${layer_slug}.geojson" \
        -simplify keep-shapes interval=${scale} \
        -o precision=0.00001 data/processed/${scale}m-resolution/${layer_slug}-${scale}m.geojson
done