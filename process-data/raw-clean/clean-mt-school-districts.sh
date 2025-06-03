# Run from repo root
# sh ./process-data/raw-clean/clean-mt-school-districts.sh

# TODO - clean up data fields

layer_slug="mt-school-districts"

# initial cleanup at full-scale
mapshaper "./data/raw-by-source/msl/"${layer_slug}".zip" \
    -proj wgs84 \
    -rename-layers elementary,county_data,enrollment_data,secondary,unified \
    -o data/processed/original-resolution/${layer_slug}-elementary.geojson target=elementary \
    -o data/processed/original-resolution/${layer_slug}-secondary.geojson target=secondary \
    -o data/processed/original-resolution/${layer_slug}-unified.geojson target=unified \

# Filter to large high schools

large_hs_list="['BILLINGS HIGH SCHOOL','GREAT FALLS HIGH SCHOOL','MISSOULA HIGH SCHOOL','BOZEMAN HIGH SCHOOL','HELENA HIGH SCHOOL','FLATHEAD HIGH SCHOOL','BUTTE HIGH SCHOOL','BELGRADE HIGH SCHOOL']"
mapshaper data/processed/original-resolution/${layer_slug}-secondary.geojson \
    -filter "${large_hs_list}.includes(this.properties.NAME)" \
    -o data/processed/original-resolution/large-high-school-districts.geojson

# Resolutions in meters
for scale in 1000 100 10 1; do
    mapshaper "data/processed/original-resolution/large-high-school-districts.geojson" \
        -simplify keep-shapes interval=${scale} \
        -o precision=0.00001 data/processed/${scale}m-resolution/large-high-school-districts-${scale}m.geojson
done