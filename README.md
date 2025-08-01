# Montana Atlas

A framework for taking publicly available GIS data and using it to generate static .png maps in Montana Free Press's house style. As of July 2025 this is a work in progress.

## Tools used here
- **Git Large File Storage** -- For storing larger data files in this repository.
- **[Mapshaper](https://github.com/mbloch/mapshaper)** - Command line tool for cleaning up and (importantly!) optimizing GIS data to different resolutions
- **QGIS** -- Open-source GIS software
- **Adobe Illustrator** -- for editing SVG files (e.g. adding custom labels to maps)
- **Image Magick** - Command line tool for working with images (we use it here to convert editable SVG files to publishable PNG files)

## General workflow

- GIS data from various sources is fetched via scripts in `process/fetch`, stored in `data/raw`. Git LFS is used for storing large files.
- GIS data reformatted via Mapshaper-powered bash scripts in `process/clean`, stored in `data/processed`
- (TK) QGIS project files import and style the data layers appropriate for a given (TODO: Set up standardized styling somehow?). The [QGIS Atlas](https://www.qgistutorials.com/en/docs/3/automating_map_creation.html) functionality is used to generate basemaps and any necessary insets (e.g. where-in-Montana? locators) as text-free .pngs
- SVG files are used to combine PNG basemaps with any text elements (e.g. location names). We use this approach because QGIS's built-in labeling system is hard to work with at the scale of the tens of maps we're producing.
- ImageMagick scripting is used to convert SVG files to .pngs for publication

## Repo organization

- `data` -- GIS data layers that feed into these maps
    - `raw` -- Original data files downloaded from official sources. These are often very large files and provided in inconvenient/inconsistent coordinate reference systems.
    - `processed` -- Versions of commonly used data files cleaned up so they're easier to use, formatted as WGS84 projection .geojson files. These are organized by the scale of their intended use to help us balance file size vs. detail in projects are "zoomed in" to different extents (1m, 10m, 100m 1000m resolutions). The 1000m resolution is suitable for maps that show the entire state but will be too coarse for community-level maps. The 10m map should be ideal for city/town-level views. The original source resolution file is also available.
    - `one-off` -- Data for one-off map projects that doesn't/shouldn't fit in the `processed` data pipeline

- `scripts` -- Scripts for gathering, organizing and cleaning GIS data
    - `fetch` - Scripts for fetching data from official sources
        - `sh .scripts/fetch-all.sh` fetches current version of all raw data (run at repo initialization)
    - `clean` - Scripts for converting raw data files to standardized form
        - `sh .scripts/clean-all.sh` runs every cleaning script.

- `static-map-framework` -- Workflow for transforming cleaned GIS data to standardized static (.png) atlas maps.
    - DETAILS TK

- `static-map-outputs` -- Final versions of standardized maps for common geographies (congressional districts, counties, etc.)
    - (TODO) `statewide`
    - (TODO) `counties` -- Montana's 56 counties
    - (TODO) `congressional-districts` -- Montana's two U.S. House districts
    - `legislative-districts` -- Montana's 100 state House and 50 state Senate districts
    - (TODO) `public-service-commission-districts` -- Montana's five utility regulation board districts
    - (TODO) `reservations` -- Montana's eight tribal nations

- `one-offs` -- One-off maps for particular projects where using the standardized data is convenient.

## Workflows (TODO)

### Sourcing/cleaning/organizing commonly used GIS data

TK (be sure to add Git LFS instructions here)

### Generating atlas maps

### Generating one-off maps for specific projects

## Data layers and house styling

TK 

## Useful Git LTS commands

Note Git LTS keeps track of what it's doing via .gitattributes

- `git lfs ls-files` -- list all current LFS files in repo
- `git lfs track` -- "proper" way to add a large file to LFS (do before committing large file locally)
- `git lfs migrate import --include "<path>"` -- add an existing (i.e. already git-tracked/committed) file to LFS
- `git lfs migrate export --include "<path or pattern, e.g. "*.sh">"` -- remove file(s) from LFS tracking
- `git lfs pull` -- replaces LFS pointers left behind after `git lfs migrate import` with full files locally

Useful documentation
- https://github.com/git-lfs/git-lfs/wiki/Tutorial
- https://stackoverflow.com/questions/48699293/how-do-i-disable-git-lfs
- https://github.com/git-lfs/git-lfs/issues/2594