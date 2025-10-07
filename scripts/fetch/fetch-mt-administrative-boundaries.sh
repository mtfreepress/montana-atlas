# Data from https://msl.mt.gov/geoinfo/msdi/administrative_boundaries/
# Run from repo root
# sh ./scripts/raw-fetch/fetch-mt-administrative-boundaries.sh

# State border
curl https://ftpgeoinfo.msl.mt.gov/Data/Spatial/MSDI/AdministrativeBoundaries/MontanaStateBoundary_shp.zip \
    --output "./data/raw/msl/mt-state-boundary.zip"

# Counties
curl https://ftpgeoinfo.msl.mt.gov/Data/Spatial/MSDI/AdministrativeBoundaries/MontanaCounties_shp.zip \
    --output "./data/raw/msl/mt-counties.zip"

# City/town boundaries
curl https://ftpgeoinfo.msl.mt.gov/Data/Spatial/MSDI/AdministrativeBoundaries/MontanaIncorporatedCitiesTowns_shp.zip \
    --output "./data/raw/msl/mt-municipalities.zip"

# Reservation boundaries
curl https://ftpgeoinfo.msl.mt.gov/Data/Spatial/MSDI/AdministrativeBoundaries/MontanaReservations_shp.zip \
    --output "./data/raw/msl/mt-reservations.zip"

# School districts
curl https://ftpgeoinfo.msl.mt.gov/Data/Spatial/MSDI/AdministrativeBoundaries/MontanaSchoolDistricts_shp.zip \
    --output "./data/raw/msl/mt-school-districts.zip"

# Congressional districts
curl https://ftpgeoinfo.msl.mt.gov/Data/Spatial/MSDI/AdministrativeBoundaries/MontanaCongressionalDistricts_shp.zip \
    --output "./data/raw/msl/mt-congressional-districts.zip"

# Legislative districts
curl https://ftpgeoinfo.msl.mt.gov/Data/Spatial/MSDI/AdministrativeBoundaries/MontanaLegislativeDistricts_shp.zip \
    --output "./data/raw/msl/mt-legislative-districts.zip"

# Voting precincts
curl https://ftpgeoinfo.msl.mt.gov/Data/Spatial/MSDI/AdministrativeBoundaries/MontanaVotingPrecincts_shp.zip \
    --output "./data/raw/msl/mt-voting-precincts.zip"

# Managed areas
#   "Boundary of state, federal, local, and privately managed areas in Montana including wilderness, 
#    wild and scenic rivers, wildlife management areas, etc."
curl https://ftpgeoinfo.msl.mt.gov/Data/Spatial/MSDI/AdministrativeBoundaries/MontanaManagedAreas_shp.zip \
    --output "./data/raw/msl/managed-areas.zip"

# National Parks w MT nexus
curl https://ftpgeoinfo.msl.mt.gov/Data/Spatial/MSDI/AdministrativeBoundaries/NationalParkServiceAdminBoundaries_shp.zip \
    --output "./data/raw/msl/national-parks.zip"