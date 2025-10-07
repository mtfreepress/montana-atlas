#!/usr/bin/env bash

# Common environment helpers for repo scripts
# Export MAPSHAPER pointing to local node_modules binary when available,
# otherwise fall back to global `mapshaper` in PATH.

if [ -z "${MAPSHAPER:-}" ]; then
  MAPSHAPER_CANDIDATE="./node_modules/.bin/mapshaper"
  if [ -x "$MAPSHAPER_CANDIDATE" ]; then
    MAPSHAPER="$MAPSHAPER_CANDIDATE"
  else
    MAPSHAPER="mapshaper"
  fi
  export MAPSHAPER
fi

# Helper: run mapshaper only if the given source file exists.
# Usage: ms_if_exists <source-path> [mapshaper-args...]
ms_if_exists() {
  src="$1"
  shift || true
  if [ -f "$src" ]; then
    "$MAPSHAPER" "$src" "$@"
  else
    echo "Skipping: source missing $src"
  fi
}
