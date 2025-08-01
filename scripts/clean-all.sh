
# Run from repo root
# sh /scripts/clean-all.sh

# TODO Set this up so it just runs every shell script in ./scripts/clean?

# Admin boundaries
sh ./scripts/clean/clean-mt-state-boundary.sh
sh ./scripts/clean/clean-mt-counties.sh
sh ./scripts/clean/clean-mt-reservations.sh
sh ./scripts/clean/clean-mt-school-districts.sh
sh ./scripts/clean/clean-mt-municipalities.sh
sh ./scripts/clean/clean-managed-areas.sh

# Political boundaries
sh ./scripts/clean/clean-mt-legislative-districts.sh
sh ./scripts/clean/clean-mt-congressional-districts.sh
sh ./scripts/clean/clean-mt-voting-precincts.sh
# Political districts -- composed of other boundaries
sh ./scripts/clean/make-public-service-commission-districts.sh

# Census Bureau data
sh ./scripts/clean/clean-census-urban-areas.sh

# USGS
# (slow)
sh ./scripts/clean/clean-national-hydrography-dataset.sh

#Roads
 sh ./scripts/clean/clean-mt-transportation-framework.sh