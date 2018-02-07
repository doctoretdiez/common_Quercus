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
