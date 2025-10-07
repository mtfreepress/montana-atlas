
# Run from repo root
# sh ./scripts/clean/clean-mt-legislative-districts.sh
# Note: Source data includes both House and Senate districts

# TODO - clean up data fields


layer_slug="mt-legislative-districts"

# Load shared env helpers for MAPSHAPER
if [ -f "./scripts/env.sh" ]; then
    # supress not following (SC1091) warning
    # shellcheck source=/dev/null
    . "./scripts/env.sh"
fi


# full-scale 
# Run only if ZIP exists
ms_if_exists "./data/raw/msl/${layer_slug}.zip" \
    -proj wgs84 \
    -rename-layers house,senate \
    -o gj2008 data/processed/original-resolution/${layer_slug}-house.geojson target=house \
    -o gj2008 data/processed/original-resolution/${layer_slug}-senate.geojson target=senate

# House Districts

# Resolutions in meters
for scale in 1000 100 10 1; do
    $MAPSHAPER "data/processed/original-resolution/${layer_slug}-house.geojson" \
        -simplify keep-shapes interval=${scale} \
        -o gj2008 precision=0.00001 data/processed/${scale}m-resolution/${layer_slug}-house-${scale}m.geojson
done


# Senate Districts
# Resolutions in meters
for scale in 1000 100 10 1; do
    $MAPSHAPER "data/processed/original-resolution/${layer_slug}-senate.geojson" \
        -simplify keep-shapes interval=${scale} \
        -o gj2008 precision=0.00001 data/processed/${scale}m-resolution/${layer_slug}-senate-${scale}m.geojson
done

# Combined
# Resolutions in meters
for scale in 1000 100 10 1; do
    $MAPSHAPER -i "data/processed/original-resolution/${layer_slug}-house.geojson" "data/processed/original-resolution/${layer_slug}-senate.geojson" \
        -rename-layers house,senate \
        -merge-layers target=house,senate name=districts \
        -simplify keep-shapes interval=${scale} \
        -o gj2008 precision=0.00001 data/processed/${scale}m-resolution/${layer_slug}-combined-${scale}m.geojson
done
