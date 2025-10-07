#!/usr/bin/env bash
set -euo pipefail

# Install npm deps locally
if [ -f package.json ]; then
  echo "Installing npm packages (local)"
  npm install
else
  echo "No package.json found. Running npm init and installing mapshaper"
  npm init -y
  npm install --save mapshaper
fi

echo "npm packages installed."

echo "Setting all .sh files to executable (+x) from hard-coded list..."
# Hard-coded list
# Use `find . -type f -name '*.sh' -not -path './.git/*' -print | sort` to generate and copy them all in here (or add any new ones by hand)
sh_files=(
  "./list-large-files.sh"
  "./scripts/clean-all.sh"
  "./scripts/clean/clean-census-urban-areas.sh"
  "./scripts/clean/clean-managed-areas.sh"
  "./scripts/clean/clean-mt-congressional-districts.sh"
  "./scripts/clean/clean-mt-counties.sh"
  "./scripts/clean/clean-mt-legislative-districts.sh"
  "./scripts/clean/clean-mt-municipalities.sh"
  "./scripts/clean/clean-mt-reservations.sh"
  "./scripts/clean/clean-mt-school-districts.sh"
  "./scripts/clean/clean-mt-state-boundary.sh"
  "./scripts/clean/clean-mt-transportation-framework.sh"
  "./scripts/clean/clean-mt-voting-precincts.sh"
  "./scripts/clean/clean-national-hydrography-dataset.sh"
  "./scripts/clean/clean-national-parks.sh"
  "./scripts/clean/make-public-service-commission-districts.sh"
  "./scripts/env.sh"
  "./scripts/fetch-all.sh"
  "./scripts/fetch/fetch-census-boundaries.sh"
  "./scripts/fetch/fetch-mt-administrative-boundaries.sh"
  "./scripts/fetch/fetch-mt-transportation-framework.sh"
  "./scripts/fetch/fetch-national-hydrography-dataset.sh"
  "./scripts/one-off-process/clean-missoula-tif-boundaries.sh"
  "./setup.sh"
  "./static-map-framework/legislative-districts/merge-files/convert-to-png.sh"
)

count=0
for f in "${sh_files[@]}"; do
  if [ -f "$f" ]; then
    chmod +x "$f" || true
    echo " + chmod +x $f"
    count=$((count+1))
  else
    echo " - skipping missing: $f"
  fi
done

echo "Finished setting executable bit on $count files (from hard-coded list)."