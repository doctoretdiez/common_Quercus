#######################
########### 2.7.18
######## Using shapefiles to extract climate data from PRISM
####### E. Tokarz
# https://nceas.github.io/oss-lessons/spatial-data-gis-law/4-tues-spatial-analysis-in-r.html 
# sdm.pdf paper on desktop
#########################

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


setwd("C:/Users/Elizabeth/Desktop/2017_CTS_fellowship/FIA csv")
# We want to extract the PRISM data for our shapefiles covering the distribution
# of common Quercus species alba and ruba
# Why not just use csvs?
#alba_dist_FIA <- readOGR("albaLocations_FIA.shp")
#rubra_dist_FIA <- readOGR("rubraLocations_FIA.shp")


#alba_FIA_climate <- extract(annual_ppt, alba_dist_FIA)
#summary(alba_FIA_climate)
# This didn't quite work...
# Why not just use csvs?
# input all csvs detailing the locations of Quercus alba and Quercus rubra
alba_fia <- read.csv("Q_alba_46.csv")
rubra_fia <- read.csv("Q_rubra_46.csv")
alba_plus <- read.csv("Q_alba_GAMN.csv")
rubra_plus <- read.csv("Q_rubra_GAMN.csv")

# combine the previous dataframes to include all lower 48 states
alba_fia <- rbind(alba_fia, alba_plus)
rubra_fia <- rbind(rubra_fia, rubra_plus)

# look at the structure of the data frames to find coordinate data
str(alba_fia)
str(rubra_fia)
# The coordinates are under LAT (7) and LON (8) in both data frames.

# Now make smaller csvs with lat and lon only, but make sure the order is LON, LAT
alba_fia_coord <- alba_fia[, 8:7]
rubra_fia_coord <- rubra_fia[, 8:7]

# and now try extracting precipitation data from PRISM
alba_fia_ppt <- extract(annual_ppt, alba_fia_coord)
summary(alba_fia_ppt)
rubra_fia_ppt <- extract(annual_ppt, rubra_fia_coord)
summary(rubra_fia_ppt)

# now extract the mean temperature data from PRISM
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

