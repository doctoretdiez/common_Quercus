#######################
########### 2.7.18
######## Using climatic CSVs to make niche maps
##### heatmaps in ggplot2
####### E. Tokarz
#########################

setwd("C:/Users/Elizabeth/Desktop/2017_CTS_fellowship/FIA csv")

# start by reading in the csvs with climate data pertaining to each common Quercus
alba_fia <- read.csv("alba_fia_climatic.csv")
rubra_fia <- read.csv("rubra_fia_climatic.csv")

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

### We can also look at max temp v min temp
png(filename = "Q_alba_fia_max_mit.png", width = 675, height = 523)
ggplot(data = alba_fia, aes(x = max_annual_temp, y = min_annual_temp)) +
  stat_bin_hex() + ggtitle("Quercus alba \nFIA niche map") + 
  labs(y = "min annual temperature (degrees C)", 
       x = "max annual temperature (degrees C)")
dev.off()

png(filename = "Q_rubra_fia_max_mit.png", width = 675, height = 523)
ggplot(data = rubra_fia, aes(x = max_annual_temp, y = min_annual_temp)) +
  stat_bin_hex() + ggtitle("Quercus rubra \nFIA niche map") + 
  labs(y = "min annual temperature (degrees C)", 
       x = "max annual temperature (degrees C)")
dev.off()

#### And at ppt v elevation
png(filename = "Q_alba_fia_ppt_elev.png", width = 675, height = 523)
ggplot(data = alba_fia, aes(x = annual_ppt, y = elevation)) +
  stat_bin_hex() + ggtitle("Quercus alba \nFIA niche map") + 
  labs(y = "elevation (m)", 
       x = "annual precipitation (mm)")
dev.off()

png(filename = "Q_rubra_fia_ppt_elev.png", width = 675, height = 523)
ggplot(data = rubra_fia, aes(x = annual_ppt, y = elevation)) +
  stat_bin_hex() + ggtitle("Quercus rubra \nFIA niche map") + 
  labs(y = "elevation (m)", 
       x = "annual precipitation (mm)")
dev.off()

#### And ppt v max temp
png(filename = "Q_alba_fia_ppt_mat.png", width = 675, height = 523)
ggplot(data = alba_fia, aes(x = annual_ppt, y = max_annual_temp)) +
  stat_bin_hex() + ggtitle("Quercus alba \nFIA niche map") + 
  labs(y = "max annual temperature (degrees C)", 
       x = "annual precipitation (mm)")
dev.off()

png(filename = "Q_rubra_fia_ppt_mat.png", width = 675, height = 523)
ggplot(data = rubra_fia, aes(x = annual_ppt, y = max_annual_temp)) +
  stat_bin_hex() + ggtitle("Quercus rubra \nFIA niche map") + 
  labs(y = "max annual temperature (degrees C)", 
       x = "annual precipitation (mm)")
dev.off()

#### And mean temp v max temp
png(filename = "Q_alba_fia_max_met.png", width = 675, height = 523)
ggplot(data = alba_fia, aes(x = max_annual_temp, y = mean_annual_temp)) +
  stat_bin_hex() + ggtitle("Quercus alba \nFIA niche map") + 
  labs(y = "mean annual temperature (degrees C)", 
       x = "max annual temperature (degrees C)")
dev.off()

png(filename = "Q_rubra_fia_max_met.png", width = 675, height = 523)
ggplot(data = rubra_fia, aes(x = max_annual_temp, y = mean_annual_temp)) +
  stat_bin_hex() + ggtitle("Quercus rubra \nFIA niche map") + 
  labs(y = "mean annual temperature (degrees C)", 
       x = "max annual temperature (degrees C)")
dev.off()

# Great! Now let's do it for GBIF!!
# read in the files first
alba_gbif <- read.csv("alba_gbif_climatic.csv")
rubra_gbif <- read.csv("rubra_gbif_climatic.csv")


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

# And our others just for fun...
### We can also look at max temp v min temp
png(filename = "Q_alba_gbif_max_mit.png", width = 675, height = 523)
ggplot(data = alba_gbif, aes(x = max_annual_temp, y = min_annual_temp)) +
  stat_bin_hex() + ggtitle("Quercus alba \nGBIF niche map") + 
  labs(y = "min annual temperature (degrees C)", 
       x = "max annual temperature (degrees C)")
dev.off()

png(filename = "Q_rubra_gbif_max_mit.png", width = 675, height = 523)
ggplot(data = rubra_gbif, aes(x = max_annual_temp, y = min_annual_temp)) +
  stat_bin_hex() + ggtitle("Quercus rubra \nGBIF niche map") + 
  labs(y = "min annual temperature (degrees C)", 
       x = "max annual temperature (degrees C)")
dev.off()

#### And at ppt v elevation
png(filename = "Q_alba_gbif_ppt_elev.png", width = 675, height = 523)
ggplot(data = alba_gbif, aes(x = annual_ppt, y = elevation)) +
  stat_bin_hex() + ggtitle("Quercus alba \nGBIF niche map") + 
  labs(y = "elevation (m)", 
       x = "annual precipitation (mm)")
dev.off()

png(filename = "Q_rubra_gbif_ppt_elev.png", width = 675, height = 523)
ggplot(data = rubra_gbif, aes(x = annual_ppt, y = elevation)) +
  stat_bin_hex() + ggtitle("Quercus rubra \nGBIF niche map") + 
  labs(y = "elevation (m)", 
       x = "annual precipitation (mm)")
dev.off()
# It turns out the elevation data is pretty rudimentary, 
# maybe we should go back and fix that.....????

#### And ppt v max temp
png(filename = "Q_alba_gbif_ppt_mat.png", width = 675, height = 523)
ggplot(data = alba_gbif, aes(x = annual_ppt, y = max_annual_temp)) +
  stat_bin_hex() + ggtitle("Quercus alba \nGBIF niche map") + 
  labs(y = "max annual temperature (degrees C)", 
       x = "annual precipitation (mm)")
dev.off()

png(filename = "Q_rubra_gbif_ppt_mat.png", width = 675, height = 523)
ggplot(data = rubra_gbif, aes(x = annual_ppt, y = max_annual_temp)) +
  stat_bin_hex() + ggtitle("Quercus rubra \nGBIF niche map") + 
  labs(y = "max annual temperature (degrees C)", 
       x = "annual precipitation (mm)")
dev.off()

#### And mean temp v max temp
png(filename = "Q_alba_gbif_max_met.png", width = 675, height = 523)
ggplot(data = alba_gbif, aes(x = max_annual_temp, y = mean_annual_temp)) +
  stat_bin_hex() + ggtitle("Quercus alba \nGBIF niche map") + 
  labs(y = "mean annual temperature (degrees C)", 
       x = "max annual temperature (degrees C)")
dev.off()

png(filename = "Q_rubra_gbif_max_met.png", width = 675, height = 523)
ggplot(data = rubra_gbif, aes(x = max_annual_temp, y = mean_annual_temp)) +
  stat_bin_hex() + ggtitle("Quercus rubra \nGBIF niche map") + 
  labs(y = "mean annual temperature (degrees C)", 
       x = "max annual temperature (degrees C)")
dev.off()




