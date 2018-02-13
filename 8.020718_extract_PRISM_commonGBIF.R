############ 8.
########### 2.7.18 Elizabeth Tokarz
############# Repeat extraction of PRISM climate data, but for GBIF distribution
#############  Q alba
############## Q rubra
#############

############### INPUT: climate RasterLayers from PRISM database (.bil files),
############### AND occurrence data from GBIF database
#####
###### Find PRISM data on ULMUS server in  /home/data/PRISM/normals
######                                  or /home/data/PRISM/DEM
###### # unit: mm
# 30-year normal annual precipitation in mm
#"PRISM_ppt_30yr_normal_4kmM2_annual_bil.bil"
# 
# 30-year normal temperatures in degrees C
# mean "PRISM_tmean_30yr_normal_4kmM2_annual_bil.bil"
# maximum "PRISM_tmax_30yr_normal_4kmM2_annual_bil.bil"
# minimum "PRISM_tmin_30yr_normal_4kmM2_annual_bil.bil"
#
# Elevation data in m
# "PRISM_us_dem_4km_bil.bil"
#####
##### use raster, rgdal and sp packages to read PRISM data
#
#
###### note that we need to create this GBIF database online first
###### search for the species of interest and download it
###### you will be redirected to a web page with a unique url for your data
###### alba ID: 0010276-171219132708484
###### rubra ID: 0010278-171219132708484
###### use rgbif and dplyr package for obtaining data
######  *IDs only last for a few years
#
############### OUTPUT: updated GBIF CSVs with climate data
######  alba_gbif_climatic.csv
# These CSVs contain all the columns from the online database, plus annual 
# precipitation, annual mean temperature, annual maximum temperature, 
# annual minimum temperature and elevation
####### rubra_gbif_climatic.csv
#
##############################################################################
# We want to extract the PRISM data for the distributions
# of common Quercus species alba and rubra
# Predictor variables are wrapped up in PRISM rasters. Occurence points are
# wrapped up in lat and lon coordinates

library(raster)
library(rgdal)
library(sp)

# set wd for PRISM data
setwd("/home/data/PRISM")

# and extract the appropriate climat RasterLayers
annual_ppt <- raster("/normals/ppt/PRISM_ppt_30yr_normal_4kmM2_annual_bil.bil")
annual_mean_temp <- raster("normals/tmean/PRISM_tmean_30yr_normal_4kmM2_annual_bil.bil")
annual_max_temp <- raster("normals/tmax/PRISM_tmax_30yr_normal_4kmM2_annual_bil.bil")
annual_min_temp <- raster("normals/tmin/PRISM_tmin_30yr_normal_4kmM2_annual_bil.bil")
elev <- raster("DEM/PRISM_us_dem_4km_bil.bil")

# Now change the wd to a place where you will be saving the files you make
setwd("/../data/")

# we need to use a couple different packages to get GBIF data
library(rgbif)
library(dplyr)

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

# extract precipitation data from PRISM
alba_gbif_ppt <- extract(annual_ppt, alba_gbif_coord)
summary(alba_gbif_ppt)
rubra_gbif_ppt <- extract(annual_ppt, rubra_gbif_coord)
summary(rubra_gbif_ppt)

# extract mean temperature data from PRISM
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
alba_gbif_elev <- extract(elev, alba_gbif_coord)
summary(alba_gbif_elev)
rubra_gbif_elev <- extract(elev, rubra_gbif_coord)
summary(rubra_gbif_elev)

# Now tack it all onto the file
alba_gbif$annual_ppt <- alba_gbif_ppt
alba_gbif$mean_annual_temp <- alba_gbif_met
alba_gbif$max_annual_temp <- alba_gbif_mat
alba_gbif$min_annual_temp <- alba_gbif_mit
alba_gbif$elevation <- alba_gbif_elev
rubra_gbif$annual_ppt <- rubra_gbif_ppt
rubra_gbif$mean_annual_temp <- rubra_gbif_met
rubra_gbif$max_annual_temp <- rubra_gbif_mat
rubra_gbif$min_annual_temp <- rubra_gbif_mit
rubra_gbif$elevation <- rubra_gbif_elev

# Now write a csv for future use.
write.csv(alba_gbif, file = "alba_gbif_climatic.csv")
write.csv(rubra_gbif, file = "rubra_gbif_climatic.csv")
