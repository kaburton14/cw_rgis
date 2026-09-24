## Vector 1

if (!require(pacman)) install.packages("pacman")

pacman::p_load(tidyverse,
               sf,
               mapview)

rm(list = ls())



sf_nc_county <- st_read(dsn = "data/nc.shp",
                        quiet = TRUE)


st_write(sf_nc_county,
         dsn = "data/sf_nc_county.shp",
         append = FALSE)

saveRDS(sf_nc_county,
        file = "data/sf_nc_county.rds")

sf_nc_county <- readRDS(file = "data/sf_nc_county.rds")



sf_site <- readRDS("data/sf_finsync_nc.rds")

mapview(
  sf_site,
  col.regions = "black", # points fill color
  legend = FALSE
)



# select the first 10

sf_site_f10 <- sf_site %>% 
  slice(1:10)

mapview(
  sf_site_f10,
  col.regions = "pink",
  legend = FALSE
)

sf_str <- readRDS("data/sf_stream_gi.rds")


mapview(
  sf_str,
  color = "steelblue",
  legend = FALSE)

sf_nc_county <- readRDS("data/sf_nc_county.rds")

mapview(
  sf_nc_county,
  col.regions = "grey",
  legend = FALSE)


#choose "guildford" county, then map

sf_nc_gi <- sf_nc_county %>% 
  filter(county == "guilford")

mapview(sf_nc_gi, 
        col.regions = "grey",
        legend = FALSE)



# static map in ggplot format ---------------------------------------------

ggplot() +
  geom_sf(data = sf_nc_county)

ggplot() +
  geom_sf(data = sf_nc_county) +
  geom_sf(data = sf_str)

ggplot() +
  geom_sf(data = sf_nc_county) +
  geom_sf(data = sf_str) +
  geom_sf(data = sf_site)



## Exercise 

sf_str_as <- readRDS("data/sf_stream_as.rds")


print(sf_str_as)
print(sf_nc_county)
## sf_str_as and sf_nc_county both have a CRS of 84



ggplot() +
  geom_sf(data = sf_nc_county) +
  geom_sf (data = sf_str_as)

sf_nc_as <- sf_nc_county %>% 
  filter(county == "ashe")

ggplot()+ 
  geom_sf(data = sf_nc_as)+
  geom_sf(data = sf_str_as)
