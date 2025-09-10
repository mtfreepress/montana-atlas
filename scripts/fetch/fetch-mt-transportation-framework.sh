# Not well-labeled and huge
# curl https://ftpgeoinfo.msl.mt.gov/Data/Spatial/MSDI/Transportation/TransportationFramework_shp.zip \
#     --output "./data/raw/msl/mt-transportation-framework.zip"

# # On-system routes -- major highways
## Doesn't appear to be downloading all paths
# curl "https://services1.arcgis.com/dKlvxNSUvl36IGMp/arcgis/rest/services/Montana_On_System_Routes_OD/FeatureServer/0/query?outFields=*&where=1%3D1&f=geojson" \
#     --output "./data/raw/mdt/mdt-on-system-routes.geojson"

# # # Off-system routes -- local streets
## Doesn't appear to be downloading all paths
# curl "https://services1.arcgis.com/dKlvxNSUvl36IGMp/arcgis/rest/services/Montana_Off_System_Routes_OD/FeatureServer/0/query?outFields=*&where=1%3D1&f=geojson" \
#     --output  "./data/raw/mdt/mdt-off-system-routes.geojson"

echo "MDT highway data is manual download because Eric got fed up dealing with their API"
# On-system routes — data/raw/mdt/Montana_On_System_Routes.zip
# https://gis-mdt.hub.arcgis.com/datasets/b91ee6635f0d47e18173ed206d382719_0/explore?location=46.477160%2C-110.229273%2C7.47

# Off-system routes - data/raw/mdt/Montana_Off_System_Routes.zip
# https://gis-mdt.hub.arcgis.com/datasets/37445e45aa3f43ca878e7c89cbb0dee2_0/explore?location=46.205833%2C-111.920170%2C7.87