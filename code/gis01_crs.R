## Cordinate Refrence System

if (!require(pacman)) install.packages("pacman")

pacman::p_load(tidyverse,
               sf,
               mapview)
# get fish site data
df_fish <- read_csv("data/data_finsync_nc.csv")
print(df_fish)


# remove duplicates in the data
sf_site <- df_fish %>% 
  distinct(site_id, lon, lat) %>% 
  st_as_sf(coords = c("lon", "lat"),
           crs= 4326)


mapview(sf_site)

saveRDS(sf_site, "data/sf_finsync_rds")

#projection
sf_ft_wgs <- sf_site %>% 
  slice(c(1,2))

sf_ft_utm <- sf_ft_wgs %>% 
  st_transform(crs = 32617)

mapview(sf_ft_wgs)

st_distance(sf_ft_utm)


# 2.6 Exercise

df_quakes <- as_tibble(quakes)

sf_quakes <- df_quakes %>% 
  distinct(mag, long, lat, stations) %>% 
  st_as_sf(coords = c("long", "lat"),
           crs = 4326)

mapview(sf_quakes)

sf_ft_quakes <- sf_quakes %>% 
  slice(c(1, 2))

sf_ft_quakes_proj <- sf_ft_quakes %>% 
  st_transform(crs = 32760)

st_distance(sf_ft_quakes_proj)

saveRDS(sf_quakes, file = "data/sf_quakes.rds")
