############ 7.
########### 2.7.18 Elizabeth Tokarz
############# Extracting PRISM climate data for FIA distribution
#############  Q alba
############## Q rubra
#############

############### INPUT: climate RasterLayers from PRISM database (.bil files),
###############         also, FIA CSVs for Q. alba and Q rubra (2 & 5)
######
###### see files 2, 5
######
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
##########################################################
# FIA CSVs previously made
# Q_alba_46.csv (2) (FIA plot location and density for 46 states--Q. alba)
######  Q_rubra_46.csv (2)
######  Q_alba_GAMN.csv (5) (FIA plot location and density data for 2 states--Q. alba)
######  Q_rubra_GAMN.csv (5)
#
############### OUTPUT: updated FIA CSVs with climate data
######  alba_fia_climatic.csv
# These CSVs contain all the previous columns, plus annual precipitation, annual
# mean temperature, annual maximum temperature, annual minimum temperature and 
# elevation
####### rubra_fia_climatic.csv
#
#
##############################################################################
# We want to extract the PRISM data for the distributions
# of common Quercus species alba and rubra
# Predictor variables are wrapped up in PRISM rasters. Occurence points are
# wrapped up in lat and lon coordinates

# set wd to place where I will pull PRISM data
setwd("/home/data/PRISM")

library(raster)
library(rgdal)
library(sp)

# not sure if you can load these on the server? do packages work on the server R?
# otherwise cd /PRISM
# upload relevant climate RasterLayers
annual_ppt <- raster("/normals/ppt/PRISM_ppt_30yr_normal_4kmM2_annual_bil.bil")
annual_mean_temp <- raster("/normals/tmean/PRISM_tmean_30yr_normal_4kmM2_annual_bil.bil")
annual_max_temp <- raster("/normals/tmax/PRISM_tmax_30yr_normal_4kmM2_annual_bil.bil")
annual_min_temp <- raster("/normals/tmin/PRISM_tmin_30yr_normal_4kmM2_annual_bil.bil")
elev <- raster("/DEM/PRISM_us_dem_4km_bil.bil")

# Now change the wd to a place where you will be saving the files you make
setwd("../../data/")

# input all csvs detailing the locations of Quercus alba and Quercus rubra
alba_fia <- read.csv("../../Q_alba_46.csv")
rubra_fia <- read.csv("../../Q_rubra_46.csv")
alba_plus <- read.csv("../../Q_alba_GAMN.csv")
rubra_plus <- read.csv("../../Q_rubra_GAMN.csv")

# combine the previous dataframes to include all lower 48 states in one
alba_fia <- rbind(alba_fia, alba_plus)
rubra_fia <- rbind(rubra_fia, rubra_plus)

# look at the structure of the data frames to find coordinate data
str(alba_fia)
str(rubra_fia)
# The coordinates are under LAT (7) and LON (8) in both data frames.

# Now make smaller csvs with lat and lon only, but make sure the order is LON, LAT
alba_fia_coord <- alba_fia[, 8:7]
rubra_fia_coord <- rubra_fia[, 8:7]

# extract precipitation data from PRISM
alba_fia_ppt <- extract(annual_ppt, alba_fia_coord)
summary(alba_fia_ppt)
rubra_fia_ppt <- extract(annual_ppt, rubra_fia_coord)
summary(rubra_fia_ppt)

# extract mean temperature data from PRISM
alba_fia_met <- extract(annual_mean_temp, alba_fia_coord)
summary(alba_fia_met)
rubra_fia_met <- extract(annual_mean_temp, rubra_fia_coord)
summary(rubra_fia_met)

# Now add on this climatic data to the data frames
alba_fia$annual_ppt <- alba_fia_ppt
alba_fia$mean_annual_temp <- alba_fia_met
rubra_fia$annual_ppt <- rubra_fia_ppt
rubra_fia$mean_annual_temp <- rubra_fia_met

# While we are at it, let's add on max temp and min temp and elevation also.
# extract
alba_fia_mat <- extract(annual_max_temp, alba_fia_coord)
summary(alba_fia_mat)
rubra_fia_mat <- extract(annual_max_temp, rubra_fia_coord)
summary(rubra_fia_mat)
alba_fia_mit <- extract(annual_min_temp, alba_fia_coord)
summary(alba_fia_mit)
rubra_fia_mit <- extract(annual_min_temp, rubra_fia_coord)
summary(rubra_fia_mit)
alba_fia_elev <- extract(elev, alba_fia_coord)
summary(alba_fia_elev)
rubra_fia_elev <- extract(elev, rubra_fia_coord)
summary(rubra_fia_elev)

# and add to data frame
alba_fia$elevation <- alba_fia_elev
alba_fia$max_annual_temp <- alba_fia_mat
alba_fia$min_annual_temp <- alba_fia_mit
rubra_fia$elevation <- rubra_fia_elev
rubra_fia$max_annual_temp <- rubra_fia_mat
rubra_fia$min_annual_temp <- rubra_fia_mit

# now we will write these CSVs for future use
write.csv(alba_fia, file = "alba_fia_climatic.csv")
write.csv(rubra_fia, file = "rubra_fia_climatic.csv")
