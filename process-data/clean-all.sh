
# Run from repo root
# sh /process-data/clean-all.sh

# Admin boundaries
sh ./process-data/raw-clean/clean-mt-state-boundary.sh
sh ./process-data/raw-clean/clean-mt-counties.sh
sh ./process-data/raw-clean/clean-mt-reservations.sh
sh ./process-data/raw-clean/clean-mt-school-districts.sh
sh ./process-data/raw-clean/clean-mt-municipalities.sh
sh ./process-data/raw-clean/clean-managed-areas.sh

# Political boundaries
sh ./process-data/raw-clean/clean-mt-legislative-districts.sh
sh ./process-data/raw-clean/clean-mt-congressional-districts.sh
sh ./process-data/raw-clean/clean-mt-voting-precincts.sh
# Political districts -- composed of other boundaries
sh ./process-data/raw-clean/make-public-service-commission-districts.sh

# Census Bureau data
sh ./process-data/raw-clean/clean-census-urban-areas.sh

# USGS
# (slow)
sh ./process-data/raw-clean/clean-national-hydrography-dataset.sh

#Roads
 sh ./process-data/raw-clean/clean-mt-transportation-framework.sh