if (!require(pacman)) install.packages("pacman")

pacman::p_load(tidyverse,
               terra,
               tidyterra,
               mapview,
               stars)


# raster data format ------------------------------------------------------
# rast() is a function to read data from your directory
(spr_ex <- rast("data/spr_example.tif"))


#writeRaster() is a function to export raster data
writeRaster(x = spr_ex,
            filename = "data/spr_elev.tif",
            overwrite = TRUE)


# visualize raster data; geom_spatraster() (from "tidyterre" package)

ggplot() +
  geom_spatraster(
    data = spr_ex)


#if you want mapview() function to work 
star_ex <- st_as_stars(spr_ex)
mapview(star_ex)


# data type in raster -----------------------------------------------------

v_elev <- values(spr_ex)
extract(spr_ex, y = cbind(6.0000, 50.0000))
extract(spr_ex, y = cbind(5.9,49.9999))
extract(spr_ex, y = cbind(6.13, 49.67))


# extract multiple points

df_point <- tibble(
  lon = c(6, 5.9),
  lat = c(50,49.96)
)

extract(spr_ex, y = df_point)

# discrete data
spr_for <- rast("data/spr_forest_nc.tif")

ggplot() +
  geom_spatraster(data = spr_for)

unique(spr_for)

v_binary <- values(spr_for)
mean(v_binary) * 100

# multiple classes- code values with multiple categories

(spr_land <- rast("data/spr_land_reclass.tif"))

unique(spr_land)

# 1001 = forest
# 1010 = crop
# 1100 = urban
unique(spr_land)

#coordinate, lon -79.8063 lat 36.0701 (sulv building)

extract(spr_land, cbind(-79.8063, 36.0701))

# Reclass
#- matrix for category mapping
(cm <- cbind(c(0, 1001, 1010, 1100),
             c(0, 1, 0, 0)))

spr_bin <- classify(spr_land,
         rcl = cm)
unique(spr_bin)

v_bin <- values(spr_bin)
mean(v_bin) * 100

#calculate  % cropland
# write a conversion matrix
# left, original value
# right, value after conversion
cm_crop <- cbind(
  c(0,1001,1010,1100),
  c(0,0,1,0)
)

spr_crop <- classify(
  x = spr_land,
  rcl = cm_crop)

v_crop <- values(spr_crop)
mean(v_crop) *100

#calculate % urban
cm_urban <- cbind(
  c(0,1001,1010,1100),
  c(0,0,1,0))

spr_urban <- classify (spr_land,
                       rcl = cm_urban)
unique(spr_urban)
v_urban <- values(spr_urban)
mean(v_urban) *100



# 4.2.5 Exercise ----------------------------------------------------------
#1
spr_prec_ncne <- rast("data/spr_prec_ncne.tif")

#2
# number of row: 162, number of columns: 532

# resolution: 0.0083

# spatial extent: xmin: -79.89181, x max: -75.45847,
# ymin:35.24153, ymax:36.59153

# coordinate reference system: WGS 84 (EPSG:4326)

# minimum and maximum precipitation values: min: 1063.099976
  # max: 1501.5


#3

ggplot() +
  geom_spatraster(
    data = spr_prec_ncne
  )

#4

sf_site <- readRDS("data/sf_finsync_nc.rds")

df_xy <- st_coordinates(sf_site)

df_land <- extract(spr_land, df_xy)

df_land %>% 
  filter(code == 1001) %>% 
  nrow()
df_land %>% 
  filter(code == 1010) %>% 
  nrow()
df_land %>% 
  filter(code == 1100) %>% 
  nrow()
# forest