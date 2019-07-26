## Vector Data

library(sf)

shp <- 'data/cb_2016_us_county_5m'
counties <- st_read(
    shp,
    stringsAsFactors = FALSE)

head(counties)
class(counties)

sesync <- st_sfc(st_point(
    c(-76.503394, 38.976546)),
    crs = st_crs(counties))

class(sesync)
sesync
st_crs(counties)
st_bbox(counties)

## Bounding box

plot(counties$geometry)

library(dplyr)
counties_md <- filter(
    counties,
    STATEFP == '24')

plot(counties_md$geometry)

## Grid

grid_md <- st_make_grid(counties_md,
                        n = 4)

## Plot Layers

plot(grid_md)
plot(counties_md['ALAND'],
     add = TRUE)
plot(sesync, col = "green",
     pch = 20, add = TRUE)

st_within(sesync, counties_md)

## Coordinate Transforms

shp <- 'data/huc250k'
huc <- st_read(
    shp,
    stringsAsFactors = FALSE)

st_crs(counties_md)$proj4string

st_crs(huc)$proj4string

prj <- '+proj=aea +lat_1=29.5 +lat_2=45.5 \
    +lat_0=23 +lon_0=-96 +x_0=0 +y_0=0    \
    +ellps=GRS80 +towgs84=0,0,0,0,0,0,0   \
    +units=m +no_defs'

counties_md <- st_transform(
    counties_md,
    crs = prj)

huc <- st_transform(
    huc,
    crs = prj)

sesync <- st_transform(
    sesync,
    crs = prj)

plot(counties_md$geometry)

plot(huc$geometry,
     border = 'blue', add = TRUE)

plot(sesync, col = 'green',
     pch = 20, add = TRUE)

## Geometric Operations

state_md <- st_union(counties_md)
plot(state_md)

huc_md <- st_intersection(
    huc,
    state_md)

plot(state_md)
plot(huc_md, border = 'blue',
     col = NA, add = TRUE)

## Raster Data

library(raster)
nlcd <- raster("data/nlcd_agg.grd")

nlcd

plot(nlcd)


## Crop

extent <- matrix(st_bbox(huc_md), nrow=2)
nlcd <- crop(nlcd, extent)
plot(nlcd)
plot(huc_md, col = NA, add = TRUE)

## Raster data attributes

nlcd[1, 1]
head(nlcd@data@attributes[[1]])

nlcd_attr <- nlcd@data@attributes 
lc_types <- nlcd_attr[[1]]$Land.Cover.Class

levels(lc_types)

## Raster math

nlcd_81 <- nlcd == 81
plot(nlcd_81)

pasture <- mask(nlcd, nlcd == 81,
                maskvalue = FALSE)
plot(pasture)

freq(nlcd_81)
freq(pasture)

nlcd_agg <- aggregate(nlcd,
                      fact = 25, fun = modal)
nlcd_agg@legend <- nlcd@legend
plot(nlcd_agg)

## Mixing rasters and vectors: prelude

sesync_sp <- as(sesync, "Spatial")
huc_md_sp <- as(huc_md, "Spatial")
counties_md_sp <- as(counties_md, "Spatial")

class(sesync_sp)

## Mixing rasters and vectors

plot(nlcd)
plot(sesync_sp, col = 'green',
     pch = 16, cex = 2, add = TRUE)


sesync_lc <- extract(nlcd, sesync_sp)
lc_types[sesync_lc + 1]

county_nlcd <- extract(nlcd_agg,
                       counties_md_sp[1,])
table(county_nlcd)

#dimension - 30 polygons
dim(huc_md)

modal_lc <- extract(nlcd_agg,
                    huc_md_sp, fun = modal)
huc_md_sp$modal_lc <- lc_types[modal_lc + 1]

head(huc_md_sp)

## Leaflet

library(leaflet)

lf = leaflet()
class(lf)

leaflet() %>%
    addTiles() %>%
    setView(lng = -77, lat = 39, 
            zoom = 7)

leaflet() %>%
    addTiles() %>%
    addPolygons(
        data = st_transform(huc_md, 4326)) %>%
    setView(lng = -77, lat = 39, 
            zoom = 7)


leaflet() %>%
    addTiles() %>%
    addWMSTiles(
        "http://mesonet.agron.iastate.edu/cgi-bin/wms/nexrad/n0r.cgi",
        layers = "nexrad-n0r-900913", group = "base_reflect",
        options = WMSTileOptions(format = "image/png", transparent = TRUE),
        attribution = "Weather data © 2012 IEM Nexrad") %>%
    setView(lng = -77, lat = 39, 
            zoom = 7)