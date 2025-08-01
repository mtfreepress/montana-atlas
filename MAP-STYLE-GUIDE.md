# MTFP map style guide

This document is an effort to articulate styling standards that serve as a starting point for MTFP-branded maps. These won't always be the right styles to use, but are intended to be a "sensible default" so we don't have to think about what colors etc. to use when we don't have a good reason to do something else.

These styles can be used either in maps generated within a GIS program like QGIS or JavaScript interfaces like Observable Plot maps. They've been initially developed in QGIS.

Some of these styles will be stored in a QGIS styles database `mtfp-qgis-styles.db`. As of Aug. 2025, Eric is still experimenting with that technology.

This will probably be a living thing as we hone our cartography brand. This guide was last updated in Aug. 2025 (and is still WIP).

## General guidelines

The Coordinate Reference System or CRS (i.e. the standard used to map points on a spherical earth to 2D drawings) is a common gotcha in GIS work. Data from public sources is stored in all sorts of CRS formats, which causes all sorts of problems. The scripting in our Montana atlas framework standardizes the GIS data we store on the WGS84 (aka EPSG:4326) CRS framework, which is generally the default for GPS systems.

However, because WGS84 maps look weird at the Montana scale (the state is squished like someone has stepped on it), we typically use the NAD83 / Montana CRS (EPSG:32100) for MTFP maps — this gives Montana-level maps familiar proportions and is identifiable by the state's northern border being curved slightly. Another CRS to be aware of, commonly used for interactive web maps, is WGS 84/Pseudo-Mercator (EPSG:3857). It also gives Montana-scale maps decent proportions, but plots the northern border of the state as a flat line, which Eric thinks is less fun.

QGIS mapping also has a couple styling gotchas to be aware of. Many style features (e.g. line stroke widths) are defined in mm by default, which can cause features in the map preview (i.e. the interface you design in) to look much different when you export them for publication, depending on export size and zoom level. We generally use pixel widths instead, since those are the units used in most web design work.

## Suggested styling for particular types of things

Not all of these layers need to be on all maps.

- Focus objects - The key thing shown on the map. Use a thick "MTFP orange" (`#f85028`) line to emphasize that this is the key thing for readers to look at, perhaps 3px to 8px wide depending on context. Sometimes a partially transparent MTFP orange fill is also helpful.

- Administrative borders that aren't the focus of the map (counties, legislative districts, etc.) -- generally a black or gray or white outline. Adjusting transparency can help. Be careful that these are distingushable from highways if using similar colors.

- Background color - The "default" color for anywhere on the map where there isn't a feature e.g. the whole state in a state-level map. Some sort of light tan (i.e. `#eae3dc`) is often the best color for this to create a subtle distinction between the white background of the not-map part of the image.

- Highways - Generally use some sort of thin darkish gray line (e.g. `#555555`, 1-2px wide) to indicate these. It is often effective to make highway layers partially transparent so they don't interfere with the key map content. Low-scale maps (i.e. zoomed out, like a map of the whole state) often benefit from showing only major highways while higher-scale maps (e.g. specific to a particular town) often benefit from more transportation grid detail. When showing a lot of transportation grid detail it's often helpful to use line width or transparency to differentiate between major roads (e.g. interstate highways) and minor ones (e.g. secondary highways or city streets). This can be done with graduated symbols in QGIS or custom rendering functions with JavaScript-based maps.

- Urban areas - e.g. boundaries from the census bureau. Semi-transparent brown fill (`#7e6b4c`, 60% opacity), 1px 100% opacity outline of the same brown.

- Public land areas - e.g. USFS/BLM/national parks. Semi-transparent green fill (`#66894d`, 30% opacity), no stroke.

- Water bodies - Large lakes/reservoirs for wide-area maps (filter by acreage to display only large water bodies depending on map scale). The USGS "stream-areas" data includes outlines of larger streams and rivers, which can be useful for small-area maps. Fill color `#94bcd0` with a slightly darker 1px `#85aabd` border.

- Reservations - Semi-transparent purple fill (`#7e6397`, 40% opacity), same color stroke 1px 100% opacity for outline.

