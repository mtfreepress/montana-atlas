# Run from repo root
# sh ./scripts/clean/clean-national-hydrography-dataset.sh

# fcode indicates USGS flow type 
# visibility represents approx display scale for filtering
# data dictionary here: https://www.usgs.gov/ngp-standards-and-specifications/national-hydrography-dataset-nhd-data-dictionary-feature-domains

layer_slug="mt-waterways"

# initial cleanup at full-scale
# Doing some filtering here to avoid massive file sizes
mapshaper "./data/raw/usgs/mt-national-hydrography-dataset.zip" \
    -proj wgs84 \
    -merge-layers target=NHDFlowline_0,NHDFlowline_1,NHDFlowline_2 \
    -rename-layers waterbody,streamarea,streamline target=NHDWaterbody,NHDArea,NHDFlowline \
    -comment Filter streamline to only named streams as proxy for notability\
    -filter "this.properties.gnis_name !== ''" target=streamline\
    -o precision=0.00001 data/processed/original-resolution/${layer_slug}-water-bodies.geojson target=waterbody \
    -o precision=0.00001 data/processed/original-resolution/${layer_slug}-stream-areas.geojson target=streamarea \
    -o precision=0.00001 data/processed/original-resolution/${layer_slug}-stream-lines.geojson target=streamline
    # -info save-to="./data/raw/usgs/nhd-layers.json"


# Streamlines
# Doing some custom stuff here, hence no for loop
mapshaper "data/processed/original-resolution/${layer_slug}-stream-lines.geojson" \
        -filter "this.properties.visibility >= 200000" \
        -simplify keep-shapes interval=1 \
        -dissolve fields=gnis_id,gnis_name,fcode,visibility \
        -o precision=0.00001 data/processed/1m-resolution/${layer_slug}-stream-lines-1m.geojson
mapshaper "data/processed/original-resolution/${layer_slug}-stream-lines.geojson" \
        -filter "this.properties.visibility >= 500000" \
        -simplify keep-shapes interval=10 \
        -dissolve fields=gnis_id,gnis_name,fcode,visibility \
        -o precision=0.00001 data/processed/10m-resolution/${layer_slug}-stream-lines-10m.geojson
mapshaper "data/processed/original-resolution/${layer_slug}-stream-lines.geojson" \
        -filter "this.properties.visibility >= 5000000" \
        -simplify keep-shapes interval=100 \
        -dissolve fields=gnis_id,gnis_name,fcode,visibility \
        -o precision=0.00001 data/processed/100m-resolution/${layer_slug}-stream-lines-100m.geojson
mapshaper "data/processed/original-resolution/${layer_slug}-stream-lines.geojson" \
        -filter "this.properties.visibility >= 5000000" \
        -comment Filter just to things big enough to be called rivers \
        -filter "(this.properties.gnis_name.includes('River')) || (['Clark Fork'].includes(this.properties.gnis_name))" \
        -simplify keep-shapes interval=1000 \
        -dissolve fields=gnis_id,gnis_name,fcode,visibility \
        -o precision=0.00001 data/processed/1000m-resolution/${layer_slug}-stream-lines-1000m.geojson



# # Stream areas
# Resolutions in meters
mapshaper "data/processed/original-resolution/${layer_slug}-stream-areas.geojson" \
    -simplify keep-shapes interval=1 \
    -o precision=0.00001 data/processed/1m-resolution/${layer_slug}-stream-areas-1m.geojson
mapshaper "data/processed/original-resolution/${layer_slug}-stream-areas.geojson" \
    -filter "this.properties.areasqkm >= 0.01" \
    -simplify keep-shapes interval=10 \
    -o precision=0.00001 data/processed/10m-resolution/${layer_slug}-stream-areas-10m.geojson
mapshaper "data/processed/original-resolution/${layer_slug}-stream-areas.geojson" \
    -filter "this.properties.areasqkm >= 1" \
    -simplify keep-shapes interval=100 \
    -o precision=0.00001 data/processed/100m-resolution/${layer_slug}-stream-areas-100m.geojson
mapshaper "data/processed/original-resolution/${layer_slug}-stream-areas.geojson" \
    -filter this.properties."areasqkm >= 5" \
    -simplify keep-shapes interval=1000 \
    -o precision=0.00001 data/processed/1000m-resolution/${layer_slug}-stream-areas-1000m.geojson


# Water bodies
mapshaper "data/processed/original-resolution/${layer_slug}-water-bodies.geojson" \
    -filter "this.properties.areasqkm >= 0.01" \
    -simplify keep-shapes interval=1 \
    -o precision=0.00001 data/processed/1m-resolution/${layer_slug}-water-bodies-1m.geojson
mapshaper "data/processed/original-resolution/${layer_slug}-water-bodies.geojson" \
    -filter "this.properties.areasqkm >= 1" \
    -simplify keep-shapes interval=10 \
    -o precision=0.00001 data/processed/10m-resolution/${layer_slug}-water-bodies-10m.geojson
mapshaper "data/processed/original-resolution/${layer_slug}-water-bodies.geojson" \
    -filter "this.properties.areasqkm >= 10" \
    -simplify keep-shapes interval=100 \
    -o precision=0.00001 data/processed/100m-resolution/${layer_slug}-water-bodies-100m.geojson
mapshaper "data/processed/original-resolution/${layer_slug}-water-bodies.geojson" \
    -filter this.properties."areasqkm >= 50" \
    -simplify keep-shapes interval=1000 \
    -o precision=0.00001 data/processed/1000m-resolution/${layer_slug}-water-bodies-1000m.geojson