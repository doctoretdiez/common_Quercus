#######################################################################
#######
####### Now repeat with GBIF data
#######
#######################################################################
library(raster)
library(rgdal)
library(sp)

# Predictor variables are wrapped up in PRISM rasters. Occurence points are
# wrapped up in distribution shapefiles

setwd("C:/Users/Elizabeth/Desktop/2017_CTS_fellowship/PRISM")
# We want to extract from the following
# unit: mm
annual_ppt <- raster("PRISM_ppt_30yr_normal_4kmM2_annual_bil.bil")
# 
# unit: degrees C
annual_mean_temp <- raster("PRISM_tmean_30yr_normal_4kmM2_annual_bil.bil")
annual_max_temp <- raster("PRISM_tmax_30yr_normal_4kmM2_annual_bil.bil")
annual_min_temp <- raster("PRISM_tmin_30yr_normal_4kmM2_annual_bil.bil")
#
#unit: m
elev <- raster("PRISM_us_dem_4km_bil.bil")


# we need to use a couple different packages
library(rgbif)
library(dplyr)

# set wd to place where I will pull data
setwd("C:/Users/Elizabeth/Desktop/2017_CTS_fellowship/FIA csv")

# first upload the data
alba_gbif <- occ_download_get(key = "0010276-171219132708484", overwrite = TRUE) %>% 
  occ_download_import(usa_gbif_download, na.strings = c("", NA))

rubra_gbif <- occ_download_get(key = "0010278-171219132708484", overwrite = TRUE) %>% 
  occ_download_import(usa_gbif_download, na.strings = c("", NA))

# look at the structure of the data frames to find coordinate data
str(alba_gbif)
# decimallatitude and decimallongitude, columns 17 and 18
# make sure order is LON LAT
alba_gbif_coord <- alba_gbif[, 18:17]
rubra_gbif_coord <- rubra_gbif[, 18:17]

# and now try extracting precipitation data from PRISM
alba_gbif_ppt <- extract(annual_ppt, alba_gbif_coord)
summary(alba_gbif_ppt)
rubra_gbif_ppt <- extract(annual_ppt, rubra_gbif_coord)
summary(rubra_gbif_ppt)

# now extract the mean temperature data from PRISM
alba_gbif_met <- extract(annual_mean_temp, alba_gbif_coord)
summary(alba_gbif_met)
rubra_gbif_met <- extract(annual_mean_temp, rubra_gbif_coord)
summary(rubra_gbif_met)

# While we are at it, let's add on max temp and min temp and elevation also.
# extract
alba_gbif_mat <- extract(annual_max_temp, alba_gbif_coord)
summary(alba_gbif_mat)
rubra_gbif_mat <- extract(annual_max_temp, rubra_gbif_coord)
summary(rubra_gbif_mat)
alba_gbif_mit <- extract(annual_min_temp, alba_gbif_coord)
summary(alba_gbif_mit)
rubra_gbif_mit <- extract(annual_min_temp, rubra_gbif_coord)
summary(rubra_gbif_mit)
# Don't do elevation, becasue GBIF already includes that in its database

# Now tack it all onto the file
alba_gbif$annual_ppt <- alba_gbif_ppt
alba_gbif$mean_annual_temp <- alba_gbif_met
alba_gbif$max_annual_temp <- alba_gbif_mat
alba_gbif$min_annual_temp <- alba_gbif_mit
rubra_gbif$annual_ppt <- rubra_gbif_ppt
rubra_gbif$mean_annual_temp <- rubra_gbif_met
rubra_gbif$max_annual_temp <- rubra_gbif_mat
rubra_gbif$min_annual_temp <- rubra_gbif_mit

# Now write a csv for future use.
write.csv(alba_gbif, file = "alba_gbif_climatic.csv")
write.csv(rubra_gbif, file = "rubra_gbif_climatic.csv")
