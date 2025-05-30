
# Run from repo root
# sh ./process-data/raw-clean/clean-mt-legislative-districts.sh

# TODO - clean up data fields

layer_slug="mt-legislative-districts"

# full-scale 
mapshaper "./data/raw-by-source/msl/"${layer_slug}".zip" \
    -proj wgs84 \
    -rename-layers house,senate \
    -o data/processed/original-resolution/${layer_slug}-house.geojson target=house \
    -o data/processed/original-resolution/${layer_slug}-senate.geojson target=senate

# House Districts

# 1000 meter / 1km resolution
mapshaper "data/processed/original-resolution/${layer_slug}-house.geojson" \
    -simplify keep-shapes interval=1000 \
    -o precision=0.00001 data/processed/1000m-resolution/${layer_slug}-house-1000m.geojson

# 100 meter resolution
mapshaper "data/processed/original-resolution/${layer_slug}-house.geojson" \
    -simplify keep-shapes interval=100 \
    -o precision=0.00001 data/processed/100m-resolution/${layer_slug}-house-100m.geojson

# 10 meter resolution
mapshaper "data/processed/original-resolution/${layer_slug}-house.geojson" \
    -simplify keep-shapes interval=10 \
    -o precision=0.00001 data/processed/10m-resolution/${layer_slug}-house-10m.geojson
    
# 1 meter resolution
mapshaper "data/processed/original-resolution/${layer_slug}-house.geojson" \
    -simplify keep-shapes interval=1 \
    -o precision=0.00001 data/processed/1m-resolution/${layer_slug-house}-1m.geojson


# Senate Districts

# 1000 meter / 1km resolution
mapshaper "data/processed/original-resolution/${layer_slug}-senate.geojson" \
    -simplify keep-shapes interval=1000 \
    -o precision=0.00001 data/processed/1000m-resolution/${layer_slug}-senate-1000m.geojson

# 100 meter resolution
mapshaper "data/processed/original-resolution/${layer_slug}-senate.geojson" \
    -simplify keep-shapes interval=100 \
    -o precision=0.00001 data/processed/100m-resolution/${layer_slug}-senate-100m.geojson

# 10 meter resolution
mapshaper "data/processed/original-resolution/${layer_slug}-senate.geojson" \
    -simplify keep-shapes interval=10 \
    -o precision=0.00001 data/processed/10m-resolution/${layer_slug}-senate-10m.geojson
    
# 1 meter resolution
mapshaper "data/processed/original-resolution/${layer_slug}-senate.geojson" \
    -simplify keep-shapes interval=1 \
    -o precision=0.00001 data/processed/1m-resolution/${layer_slug-senate}-1m.geojson
    

    
