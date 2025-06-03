# Data from https://msl.mt.gov/geoinfo/msdi/administrative_boundaries/
# Run from repo root
# sh ./process-data/raw-fetch/fetch-mt-administrative-boundaries.sh

# State border
curl https://ftpgeoinfo.msl.mt.gov/Data/Spatial/MSDI/AdministrativeBoundaries/MontanaStateBoundary_shp.zip \
    --output "./data/raw-by-source/msl/mt-state-boundary.zip"

# Counties
curl https://ftpgeoinfo.msl.mt.gov/Data/Spatial/MSDI/AdministrativeBoundaries/MontanaCounties_shp.zip \
    --output "./data/raw-by-source/msl/mt-counties.zip"

# City/town boundaries
curl https://ftpgeoinfo.msl.mt.gov/Data/Spatial/MSDI/AdministrativeBoundaries/MontanaIncorporatedCitiesTowns_shp.zip \
    --output "./data/raw-by-source/msl/mt-municipalities.zip"

# Reservation boundaries
curl https://ftpgeoinfo.msl.mt.gov/Data/Spatial/MSDI/AdministrativeBoundaries/MontanaReservations_shp.zip \
    --output "./data/raw-by-source/msl/mt-reservations.zip"

# School districts
curl https://ftpgeoinfo.msl.mt.gov/Data/Spatial/MSDI/AdministrativeBoundaries/MontanaSchoolDistricts_shp.zip \
    --output "./data/raw-by-source/msl/mt-school-districts.zip"

# Congressional districts
curl https://ftpgeoinfo.msl.mt.gov/Data/Spatial/MSDI/AdministrativeBoundaries/MontanaCongressionalDistricts_shp.zip \
    --output "./data/raw-by-source/msl/mt-congressional-districts.zip"

# Legislative districts
curl https://ftpgeoinfo.msl.mt.gov/Data/Spatial/MSDI/AdministrativeBoundaries/MontanaLegislativeDistricts_shp.zip \
    --output "./data/raw-by-source/msl/mt-legislative-districts.zip"

# Voting precincts
curl https://ftpgeoinfo.msl.mt.gov/Data/Spatial/MSDI/AdministrativeBoundaries/MontanaVotingPrecincts_shp.zip \
    --output "./data/raw-by-source/msl/mt-voting-precincts.zip"

# Managed areas
#   "Boundary of state, federal, local, and privately managed areas in Montana including wilderness, 
#    wild and scenic rivers, wildlife management areas, etc."
curl https://ftpgeoinfo.msl.mt.gov/Data/Spatial/MSDI/AdministrativeBoundaries/MontanaManagedAreas_shp.zip \
    --output "./data/raw-by-source/msl/managed-areas.zip"

# National Parks w MT nexus
curl https://ftpgeoinfo.msl.mt.gov/Data/Spatial/MSDI/AdministrativeBoundaries/NationalParkServiceAdminBoundaries_shp.zip \
    --output "./data/raw-by-source/msl/national-parks.zip"