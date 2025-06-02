
# Convert all images from SVG to PNG with imagemagick
# Needs to be run from this directory for links to work correctly
# sh convert-to-png.sh

# NOTE: SVGs out of Adobe Illustrator need to be saved w/ Advanced Options >> CSS Properties set to "Presentation Attributes"
# Otherwise AI trying to store styling in CSS classes confuses imagemagick

mogrify -format png *.svg
mv *.png ../merged-temp/
# This isn't working as of 5/20/2025

# Convert single file by name
# magick -format png ./HD-1-test.svg 
# magick HD-1-test.svg HD-1-test.png