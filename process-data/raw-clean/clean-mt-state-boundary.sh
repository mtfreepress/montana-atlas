
# Run from repo root
# sh ./process-data/raw-clean/clean-mt-state-boundary.sh

# TODO - clean up data fields

layer_slug="mt-state-boundary"

# initial cleanup at full-scale
mapshaper "./data/raw-by-source/msl/"${layer_slug}".zip" \
    -proj wgs84 \
    -o data/processed/original-resolution/${layer_slug}.geojson

# 1000 meter / 1km resolution
mapshaper data/processed/original-resolution/${layer_slug}.geojson \
    -simplify keep-shapes interval=1000 \
    -o precision=0.00001 data/processed/1000m-resolution/${layer_slug}-1000m.geojson

# 100 meter resolution
mapshaper data/processed/original-resolution/${layer_slug}.geojson \
    -simplify keep-shapes interval=100 \
    -o precision=0.00001 data/processed/100m-resolution/${layer_slug}-100m.geojson

# 10 meter resolution
mapshaper data/processed/original-resolution/${layer_slug}.geojson \
    -simplify keep-shapes interval=10 \
    -o precision=0.00001 data/processed/10m-resolution/${layer_slug}-10m.geojson
    
# 1 meter resolution
mapshaper data/processed/original-resolution/${layer_slug}.geojson \
    -simplify keep-shapes interval=1 \
    -o precision=0.00001 data/processed/1m-resolution/${layer_slug}-1m.geojson
    
