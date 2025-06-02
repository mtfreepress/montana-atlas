
# Convert all images from SVG to PNG with imagemagick
# Needs to be run from this directory for links to work correctly
# sh convert-to-png.sh

# NOTE: SVGs out of Adobe Illustrator need to be saved w/ Advanced Options >> CSS Properties set to "Presentation Attributes"
# Otherwise AI trying to store styling in CSS classes confuses imagemagick

mogrify -format png -density 192 -resize 100% *.svg

# Convert single file by name -- for testing
# mogrify -format png -density 192 -resize 100% ./HD-1.svg 

# Move resulting files from this folder to the output one
mv *.png ../../../outputs-atlas/legislative-districts/