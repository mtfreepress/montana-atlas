// Produces templates that allow merging of map visuals, insets and custom labels via an SVG for each district
// NOTE: Running this will overwrite any template files that have been hand-customized in Illustrator 

import fs from 'fs';

const writeText = (path, string) => {
    fs.writeFile(path, string, err => {
        if (err) throw err
        console.log('Written to', path)
    })
}

// GENERATE DEFAULTS
// Having a default place label makes it easier to quickly edit template files

const defaultDistricts = (chamber, seats) => {
    return [...Array(seats)].map((d, i) => {
        return {
            key: `${chamber}D-${i + 1}`,
            district: { label: `${chamber}D ${i + 1}`, x: 240, y: 265 },
            places: [
                { label: 'TK', x: 101, y: 135 },
            ],
            locator: { x: 390, y: 460 }
        }
    })
}

// This allows for putting specific place labels into templates in advance
// Left over from an earlier workflow -- it's MUCH easier just to customize in Illustrator
// If this workflow ever needs a major rework, it may be worth writing code to pull hand-specified settings out of the SVG files
// Though find/replace with the existing files has been workable so far

const customize = [
    {
        key: 'HD-1',
        district: { label: 'HD 1', x: 240, y: 265 },
        places: [
            { label: 'Troy', x: 100, y: 362 },
            { label: 'Eureka', x: 428, y: 159 },
        ],
        locator: { x: 390, y: 460 },
    },
]

const districts = [
    ...defaultDistricts('H', 100),
    ...defaultDistricts('S', 50),
]
    .map(district => {
        const match = customize.find(d => d.key === district.key)
        return {
            ...district,
            ...match,
        }
    })

const template = ({
    key,
    district,
    places,
    locator
}) => `<?xml version="1.0" encoding="utf-8"?>
<svg version="1.1" baseProfile="basic" id="map" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
	 x="0px" y="0px" viewBox="0 0 600 600" xml:space="preserve">
	<image overflow="visible" width="1200" height="1200" id="base" xlink:href="../main-maps/${key}-map.png" transform="matrix(0.5 0 0 0.5 0 0)">
	</image>
	<image overflow="visible" width="300" height="200" id="locator" xlink:href="../locator-maps/${key}-locator.png" transform="matrix(0.6667 0 0 0.6667 ${locator.x} ${locator.y})">
	</image>
	<g id="city-labels">
        ${places.map(place => `<text transform="matrix(1 0 0 1 ${place.x} ${place.y})" font-family="Arial-ItalicMT, Arial" font-size="18" font-style="italic" isolation="isolate">${place.label}</text>`).join('\n        ')}
	</g>
	<text id="district" transform="matrix(1 0 0 1 240.0054 265.6763)" fill="#f85028" font-family="Arial-BoldMT, Arial" font-size="48" font-weight="700" isolation="isolate">${district.label}</text>
</svg>`

districts.map(district => {
    const svg = template(district)
    writeText(`./merged-files/${district.key}.svg`, svg)
})
