############ 9.
########### 2.7.18 Elizabeth Tokarz
############# Make niche maps (annual precipitation v. annual mean temperature)
############# with newly made 'climatic' CSVs
#############  Q alba
############## Q rubra
#############

############### INPUT: 'climatic' CSVs for FIA and GBIF
##### see files 7 and 8
#### alba_fia_climatic.csv
#### --contains information about the location AND climate variables of the 
# Quercus alba distribution in FIA
#### rubra_fia_climatic.csv
#### alba_gbif_climatic.csv (for the Q. alba occurring in GBIF database)
#### rubra_gbif_climatic.csv
####
# use ggplot2 package to make the output maps
#
############### OUTPUT: visual png nichemaps
######  Q_alba_fia_ppt_met.png (hexagonal heatmap comparing annual precipitation (mm)
# with annual mean temperature (degrees C) for all locations where Quercus alba was
# found in the FIA surveys)
###### Q_rubra_fia_ppt_met.png (the above for Quercus rubra, FIA)
###### Q_alba_gbif_ppt_met.png (same type of map, but for all locations where Quercus
# alba was recorded in the GBIF database)
##### Q_rubra_gbif_ppt_met.png (the above for Quercus rubra, GBIF)
################################################################################
#
#

# start by reading in the FIA csvs with climate data pertaining to each common Quercus
alba_fia <- read.csv("../../alba_fia_climatic.csv")
rubra_fia <- read.csv("../../rubra_fia_climatic.csv")

# now making the niche plots is not too hard. Load the ggplot2 package
library(ggplot2)

# We will start with our basics
png(filename = "Q_alba_fia_ppt_met.png", width = 675, height = 523)
ggplot(data = alba_fia, aes(x = annual_ppt, y = mean_annual_temp)) +
  stat_bin_hex() + ggtitle("Quercus alba \nFIA niche map") + 
  labs(y = "mean annual temperature (degrees C)", 
       x = "annual precipitation (mm)")
dev.off()

png(filename = "Q_rubra_fia_ppt_met.png", width = 675, height = 523)
ggplot(data = rubra_fia, aes(x = annual_ppt, y = mean_annual_temp)) +
  stat_bin_hex() + ggtitle("Quercus rubra \nFIA niche map") + 
  labs(y = "mean annual temperature (degrees C)", 
       x = "annual precipitation (mm)")
dev.off()

# Now let's continue with the GBIF niche maps
# read in the files first
alba_gbif <- read.csv("../../alba_gbif_climatic.csv")
rubra_gbif <- read.csv("../../rubra_gbif_climatic.csv")

# make those niche maps
# We will start with our basics
png(filename = "Q_alba_gbif_ppt_met.png", width = 675, height = 523)
ggplot(data = alba_gbif, aes(x = annual_ppt, y = mean_annual_temp)) +
  stat_bin_hex() + ggtitle("Quercus alba \nGBIF niche map") + 
  labs(y = "mean annual temperature (degrees C)", 
       x = "annual precipitation (mm)")
dev.off()

png(filename = "Q_rubra_gbif_ppt_met.png", width = 675, height = 523)
ggplot(data = rubra_gbif, aes(x = annual_ppt, y = mean_annual_temp)) +
  stat_bin_hex() + ggtitle("Quercus rubra \nGBIF niche map") + 
  labs(y = "mean annual temperature (degrees C)", 
       x = "annual precipitation (mm)")
dev.off()


# Make a nicheplot with 4 windows to compare...
# let's reform the data frames
# we want six columns: species, source, latitude, longitude, 
# annual precipitation, annual mean temperature

str(alba_fia)
head(alba_fia[, c("LAT", "LON", "annual_ppt", "mean_annual_temp")])
alba_fia_prep <- alba_fia[, c("LAT", "LON", "annual_ppt", "mean_annual_temp")]
alba_fia_prep$species <- "Q_alba"
alba_fia_prep$source <- "FIA"

rubra_fia_prep <- rubra_fia[, c("LAT", "LON", "annual_ppt", "mean_annual_temp")]
rubra_fia_prep$species <- "Q_rubra"
rubra_fia_prep$source <- "FIA"

str(alba_gbif)
head(alba_gbif[, c("decimallatitude", "decimallongitude", "annual_ppt", "mean_annual_temp")])
alba_gbif_prep <- alba_gbif[, c("decimallatitude", "decimallongitude", "annual_ppt", "mean_annual_temp")]
alba_gbif_prep$species <- "Q_alba"
alba_gbif_prep$source <- "GBIF"

rubra_gbif_prep <- rubra_gbif[, c("decimallatitude", "decimallongitude", "annual_ppt", "mean_annual_temp")]
rubra_gbif_prep$species <- "Q_rubra"
rubra_gbif_prep$source <- "GBIF"

# Now let's rename the lat and lon columns of gbif so we can combine them.
names(alba_gbif_prep) <- c("LAT", "LON", "annual_ppt", "mean_annual_temp", 
                           "species", "source")

names(rubra_gbif_prep) <- c("LAT", "LON", "annual_ppt", "mean_annual_temp", 
                            "species", "source")
# combine them with rbind
common <- rbind(alba_fia_prep, alba_gbif_prep)
common <- rbind(common, rubra_fia_prep)
common <- rbind(common, rubra_gbif_prep)

# and now we have a new dataframe for making plots in ggplot2!

png(filename = "common_nichemap.png", width = 675, height = 556)
ggplot(data = common, aes(x = annual_ppt, y = mean_annual_temp)) +
  stat_bin_hex() + facet_grid(species~source) +
  ggtitle("Common Quercus nichemaps") +
  labs(y = "mean annual temperature (degrees C)", 
       x = "annual precipitation (mm)")
dev.off()


# Try making a similarly formatted density plot
# This will compare where sampling was strongest for both databases
### making a density plot of 2d data

png(filename = "common_densitymap_full.png", width = 675, height = 556)
ggplot(data = common, aes(x = LON, y = LAT)) + 
  geom_point() + stat_density2d() +
  facet_grid(species ~ source) +
  ggtitle("Sampling density_full")
dev.off()

# Some GBIF coordinates claim to be all around the globe, so I will remove 
# the individuals out of the normal range...
common_pare <- common[common$LAT > 20, ]
common_pare <- common_pare[common_pare$LON < -50, ]
str(common_pare)
# remove NAs from the species category
common_pare <- common_pare[!is.na(common_pare$species), ]
# now use common_pare

png(filename = "common_densitymap_pare.png", width = 675, height = 394)
ggplot(data = common_pare, aes(x = LON, y = LAT)) + 
  geom_point() + stat_density2d() +
  facet_grid(species ~ source) +
  ggtitle("Sampling density_pare")
dev.off()

# now pare it even further
common_pare2 <- common_pare[common_pare$LON > -105, ]

png(filename = "common_densitymap_pare2.png", width = 675, height = 556)
ggplot(data = common_pare2, aes(x = LON, y = LAT)) + 
  geom_point() + stat_density2d() +
  facet_grid(species ~ source) +
  ggtitle("Sampling density_pare")
dev.off()
