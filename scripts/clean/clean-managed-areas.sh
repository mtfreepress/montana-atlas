# Run from repo root
# sh ./scripts/clean/clean-managed-areas.sh

# initial cleanup at full-scale
mapshaper "./data/raw/msl/managed-areas.zip" \
    -proj wgs84 \
    -o data/processed/original-resolution/managed-areas-all.geojson

# Types of managed lands in here. Oh, wow...
<<comment
- Area of Critical Environmental Concern (BLM)
- Bison Range (CSKT)
- Conservation Area (USFWS)
- Experimental (Various)
- Fee Management Unit (Nature Conservancy)
- Fish Hatchery (USFWS)
- Fishing Access Site (MTFWP)
- Historical Area (USFS)
- Military Reservation (USGS)
- National Forest (USFS)
- National Historic Site (NPS)
- National Monument (NPS/BLM)
- National Natural Landmark (USFS)
- National Park (NPS)
- National Recreation Area (USFS)
- National Recreation Area (NPS)
- National Wildlife Refuge (USFWS)
- Natural Area (various)
- Other Lands with Wilderness Characteristics (BLM)
- Outstanding Natural Area (BLM)
- Park (Cities)
- Preserve (TNC?)
- Primitive Area (??)
- Privately Owned Conservation Land (???)
- Proposed Research Natural Area (??)
- Ranger District (USFS)
- Recreation Area (USFS)
- Research Natural Area (USFS)
- Special Inderest Area (USFS)
- State Forest (DNRC)
- State Park (MTFWP)
- Trust Lands (tribes)
- Waterfowl Production Area (USFWS)
- Wild and Scenic River (USFS)
- Wild Horse Range (BLM)
- Wilderness Area (mostly USFS)
- Wilderness Charateristic Protection Area (BLM)
- Wilderness Study Area (USFS)
- Wildlife Habitat Protection Area (FWP)
- Wildlife Management Area (FWP)
comment

# National Forests
mapshaper data/processed/original-resolution/managed-areas-all.geojson \
    -filter "this.properties.UNITTYPE === 'National Forest'" \
    -o data/processed/original-resolution/national-forests.geojson

for scale in 100 10 1; do
    mapshaper "data/processed/original-resolution/national-forests.geojson" \
        -simplify keep-shapes interval=${scale} \
        -o precision=0.00001 data/processed/${scale}m-resolution/national-forests-${scale}m.geojson
done

# TODO -- more possibilities here