# Run from repo root
# sh ./scripts/clean/clean-national-hydrography-dataset.sh

# fcode indicates USGS flow type 
# visibility represents approx display scale for filtering
# data dictionary here: https://www.usgs.gov/ngp-standards-and-specifications/national-hydrography-dataset-nhd-data-dictionary-feature-domains

# Load shared env helpers (sets MAPSHAPER to local node_modules binary when present)
if [ -f "./scripts/env.sh" ]; then
    # shellcheck source=/dev/null
    . "./scripts/env.sh"
else
    # Fallback: try global mapshaper if env file missing
    MAPSHAPER="mapshaper"
fi

layer_slug="mt-waterways"

# initial cleanup at full-scale
# Doing some filtering here to avoid massive file sizes
ms_if_exists "./data/raw/usgs/mt-national-hydrography-dataset.zip" \
    -proj wgs84 \
    -merge-layers target=NHDFlowline_0,NHDFlowline_1,NHDFlowline_2 \
    -rename-layers waterbody,streamarea,streamline target=NHDWaterbody,NHDArea,NHDFlowline \
    -comment Filter streamline to only named streams as proxy for notability\
    -filter "this.properties.gnis_name !== ''" target=streamline\
    -o gj2008 precision=0.00001 data/processed/original-resolution/${layer_slug}-water-bodies.geojson target=waterbody \
    -o gj2008 precision=0.00001 data/processed/original-resolution/${layer_slug}-stream-areas.geojson target=streamarea \
    -o gj2008 precision=0.00001 data/processed/original-resolution/${layer_slug}-stream-lines.geojson target=streamline
    # -info save-to="./data/raw/usgs/nhd-layers.json"


# Streamlines
# Doing some custom stuff here, hence no for loop
mt_boundary="data/processed/original-resolution/mt-state-boundary.geojson"

# original and clipped paths for each data type
orig_stream_lines="data/processed/original-resolution/${layer_slug}-stream-lines.geojson"
clipped_stream_lines="${orig_stream_lines%.geojson}-mt-clipped.geojson"

orig_stream_areas="data/processed/original-resolution/${layer_slug}-stream-areas.geojson"
clipped_stream_areas="${orig_stream_areas%.geojson}-mt-clipped.geojson"

orig_water_bodies="data/processed/original-resolution/${layer_slug}-water-bodies.geojson"
clipped_water_bodies="${orig_water_bodies%.geojson}-mt-clipped.geojson"

# clip each original only once if the original exists (ms_if_exists prints a skip message)
ms_if_exists "$orig_stream_lines" -clip "$mt_boundary" -o gj2008 precision=0.00001 "$clipped_stream_lines"
ms_if_exists "$orig_stream_areas" -clip "$mt_boundary" -o gj2008 precision=0.00001 "$clipped_stream_areas"
ms_if_exists "$orig_water_bodies" -clip "$mt_boundary" -o gj2008 precision=0.00001 "$clipped_water_bodies"

# prefer clipped if it exists, otherwise fall back to original
if [ -f "$clipped_stream_lines" ]; then
    STREAM_LINES_INPUT="$clipped_stream_lines"
else
    STREAM_LINES_INPUT="$orig_stream_lines"
fi

if [ -f "$clipped_stream_areas" ]; then
    STREAM_AREAS_INPUT="$clipped_stream_areas"
else
    STREAM_AREAS_INPUT="$orig_stream_areas"
fi

if [ -f "$clipped_water_bodies" ]; then
    WATER_BODIES_INPUT="$clipped_water_bodies"
else
    WATER_BODIES_INPUT="$orig_water_bodies"
fi

${MAPSHAPER} "$STREAM_LINES_INPUT" \
        -filter "this.properties.visibility >= 200000" \
        -simplify keep-shapes interval=1 \
        -dissolve fields=gnis_id,gnis_name,fcode,visibility \
        -o gj2008 precision=0.00001 data/processed/1m-resolution/${layer_slug}-stream-lines-1m.geojson
${MAPSHAPER} "$STREAM_LINES_INPUT" \
        -filter "this.properties.visibility >= 500000" \
        -simplify keep-shapes interval=10 \
        -dissolve fields=gnis_id,gnis_name,fcode,visibility \
        -o gj2008 precision=0.00001 data/processed/10m-resolution/${layer_slug}-stream-lines-10m.geojson
${MAPSHAPER} "$STREAM_LINES_INPUT" \
        -filter "this.properties.visibility >= 5000000" \
        -simplify keep-shapes interval=100 \
        -dissolve fields=gnis_id,gnis_name,fcode,visibility \
        -o gj2008 precision=0.00001 data/processed/100m-resolution/${layer_slug}-stream-lines-100m.geojson
${MAPSHAPER} "$STREAM_LINES_INPUT" \
        -filter "this.properties.visibility >= 5000000" \
        -comment Filter just to things big enough to be called rivers \
        -filter "(this.properties.gnis_name.includes('River')) || (['Clark Fork'].includes(this.properties.gnis_name))" \
        -simplify keep-shapes interval=1000 \
        -dissolve fields=gnis_id,gnis_name,fcode,visibility \
        -o gj2008 precision=0.00001 data/processed/1000m-resolution/${layer_slug}-stream-lines-1000m.geojson



# # Stream areas
# Resolutions in meters
${MAPSHAPER} "$STREAM_AREAS_INPUT" \
    -simplify keep-shapes interval=1 \
    -o gj2008 precision=0.00001 data/processed/1m-resolution/${layer_slug}-stream-areas-1m.geojson
${MAPSHAPER} "$STREAM_AREAS_INPUT" \
    -filter "this.properties.areasqkm >= 0.01" \
    -simplify keep-shapes interval=10 \
    -o gj2008 precision=0.00001 data/processed/10m-resolution/${layer_slug}-stream-areas-10m.geojson
${MAPSHAPER} "$STREAM_AREAS_INPUT" \
    -filter "this.properties.areasqkm >= 1" \
    -simplify keep-shapes interval=100 \
    -o gj2008 precision=0.00001 data/processed/100m-resolution/${layer_slug}-stream-areas-100m.geojson
${MAPSHAPER} "$STREAM_AREAS_INPUT" \
    -filter this.properties."areasqkm >= 5" \
    -simplify keep-shapes interval=1000 \
    -o gj2008 precision=0.00001 data/processed/1000m-resolution/${layer_slug}-stream-areas-1000m.geojson


# Water bodies
${MAPSHAPER} "$WATER_BODIES_INPUT" \
    -filter "this.properties.areasqkm >= 0.01" \
    -simplify keep-shapes interval=1 \
    -o gj2008 precision=0.00001 data/processed/1m-resolution/${layer_slug}-water-bodies-1m.geojson
${MAPSHAPER} "$WATER_BODIES_INPUT" \
    -filter "this.properties.areasqkm >= 1" \
    -simplify keep-shapes interval=10 \
    -o gj2008 precision=0.00001 data/processed/10m-resolution/${layer_slug}-water-bodies-10m.geojson
${MAPSHAPER} "$WATER_BODIES_INPUT" \
    -filter "this.properties.areasqkm >= 10" \
    -simplify keep-shapes interval=100 \
    -o gj2008 precision=0.00001 data/processed/100m-resolution/${layer_slug}-water-bodies-100m.geojson
${MAPSHAPER} "$WATER_BODIES_INPUT" \
    -filter this.properties."areasqkm >= 50" \
    -simplify keep-shapes interval=1000 \
    -o gj2008 precision=0.00001 data/processed/1000m-resolution/${layer_slug}-water-bodies-1000m.geojson