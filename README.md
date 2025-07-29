# Montana Atlas

A framework for taking publicly available GIS data and using it to generate static .png maps in Montana Free Press's house style. As of July 2025 this is a work in progress.

## Tools used here
- **QGIS** -- Open-source GIS software
- **Adobe Illustrator** -- for editing SVG files (e.g. adding custom labels to maps)
- **[Mapshaper](https://github.com/mbloch/mapshaper)** - Command line tool for cleaning up and (importantly!) optimizing GIS data to different resolutions
- **Image Magick** - Command line tool for working with images (we use it here to convert editable SVG files to publishable PNG files)
- **Git Large File Storage** -- For storing larger data files in this repository.

## General workflow

- GIS data from various sources fetched via scripts in `process-data/raw-fetch`, stored in `data/raw-by-source`
- GIS data reformatted via Mapshaper-powered bash scripts in `process-data/raw-clean`, stored in `data/processed`
- (TK) QGIS project files import and style the data layers appropriate for a given (TODO: Set up standardized styling somehow?). The [QGIS Atlas](https://www.qgistutorials.com/en/docs/3/automating_map_creation.html) functionality is used to generate basemaps and any necessary insets (e.g. where-in-Montana? locators) as text-free .pngs
- SVG files are used to combine PNG basemaps with any text elements (names, )
- ImageMagick scripting is used to convert SVG files to .pngs for publication

## Repo organization

- `data` -- GIS data layers that feed into these maps
    - `raw-by-source` -- Original data files downloaded from official sources. These are often very large files and provided in inconvenient/inconsistent coordinate reference systems.
    - `processed` -- Versions of commonly used data files cleaned up so they're easier to use, formatted as WGS84 projection .geojson files. These are organized by the scale of their intended use to help us balance file size vs. detail in projects are "zoomed in" to different extents (1m, 10m, 100m 1000m resolutions). The 1000m resolution is suitable for maps that show the entire state but will be too coarse for community-level maps. The 10m map should be ideal for city/town-level views. The original source resolution file is also available.
    - `one-off` -- Data for one-off map projects that doesn't/shouldn't fit in the `processed` data pipeline

- `process-data` -- Scripts for gathering, organizing and cleaning GIS data
    - `raw-data-fetch` - Scripts for fetching data from official sources
    - `raw-data-clean` - Scripts for converting raw data files to standardized form

- `process-atlas` -- Workflow for transforming cleaned GIS data to standardized atlas maps
    - DETAILS TK

- `outputs-atlas` -- Final versions of standardized maps for common geographies (congressional districts, counties, etc.)
    - `statewide`
    - `counties` -- Montana's 56 counties
    - `congressional-districts` -- Montana's two U.S. House districts
    - `legislative-districts` -- Montana's 100 state House and 50 state Senate districts
    - `public-service-commission-districts` -- Montana's five utility regulation board districts
    - `reservations` -- Montana's eight tribal nations

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