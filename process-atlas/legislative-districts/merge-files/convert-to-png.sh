
# Convert all images from SVG to PNG with imagemagick
# Needs to be run from this directory for links to work correctly
# sh convert-to-png.sh
# mogrify -format png *.svg
# This isn't working as of 5/20/2025

# Convert single file by name
mogrify -format png ./HD-1-test.svg