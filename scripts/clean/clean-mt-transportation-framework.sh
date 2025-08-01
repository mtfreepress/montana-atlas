# Run from repo root
# sh ./scripts/clean/clean-mmt-transportation-framework.sh

# fcode indicates USGS flow type 
# visibility represents approx display scale for filtering
# data dictionary here: https://www.usgs.gov/ngp-standards-and-specifications/national-hydrography-dataset-nhd-data-dictionary-feature-domains

# initial cleanup at full-scale
# Doing some filtering here to avoid massive file sizes
mapshaper "./data/raw/msl/mt-transportation-framework.zip" \
    -proj wgs84 \
    -rename-layers roads target=RoadCenterLine \
    -dissolve fields=LSt_Name,LSt_Typ,RoadClass,St_Name,St_PosTyp, target=roads\
    -filter "['Primary','Secondary','Local'].includes(this.properties.RoadClass)" target=roads \
    -o precision=0.00001 data/processed/original-resolution/mt-roads.geojson target=roads

# TODO - export highways separately (via street names?)

for scale in 1000 100 10 1; do
    mapshaper "data/processed/original-resolution/mt-roads.geojson" \
        -simplify keep-shapes interval=${scale} \
        -o precision=0.00001 data/processed/${scale}m-resolution/mt-roads-${scale}m.geojson
done