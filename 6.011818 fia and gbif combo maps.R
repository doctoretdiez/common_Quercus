############ 6.
########### 1.18.18 Elizabeth Tokarz
############# combining GBIF data with FIA data
#############  Q alba
############## Q rubra
#############

############### INPUT: cleaned occurrence data from FIA and GBIF databases
###### see files 2, 4, 5
######  Q_alba_46.csv (2) (FIA plot location and density for 46 states--Q. alba)
######  Q_rubra_46.csv (2)
######  Q_alba_GAMN.csv (5) (FIA plot location and density data for 2 states--Q. alba)
######  Q_rubra_GAMN.csv (5)
###### alba ID: 0010276-171219132708484 (4) (GBIF url to obtain occurrence data--Q. alba)
###### rubra ID: 0010278-171219132708484 (4)
#####  use packages rgbif and dplyr for the above
##### 
##### once again, use maps, ggplot and mapdata packages for mapping
#####
############### OUTPUT: visual png maps
######  Q_alba_combo.png (map of lower 48 that shows distribution of occurrences
# of Quercus alba comparing GBIF and FIA datasets)
###### Q_rubra_combo.png
#####
#####

# load package to get data from gbif
library(rgbif)
library(dplyr)

# Upload species data
## Q alba
alba_fia <- read.csv("../../Q_alba_46.csv")

alba_gbif <- occ_download_get(key = "0010276-171219132708484", overwrite = TRUE) %>% 
  occ_download_import(usa_gbif_download, na.strings = c("", NA))

## Q rubra
rubra_fia <- read.csv("../../Q_rubra_46.csv")

rubra_gbif <- occ_download_get(key = "0010278-171219132708484", overwrite = TRUE) %>% 
  occ_download_import(usa_gbif_download, na.strings = c("", NA))

######################################################
# 1.23.18 edit
# and adding it all together with ga and mn fia data!!
alba_plus <- read.csv("../../Q_alba_GAMN.csv")
rubra_plus <- read.csv("../../Q_rubra_GAMN.csv")

# combine the previous dataframes
alba_fia <- rbind(alba_fia, alba_plus)
rubra_fia <- rbind(rubra_fia, rubra_plus)
#########################################



#Make some maps!!
library("maps", lib.loc="~/R/win-library/3.3")
png(filename = "Q_alba_combo.png", width = 675, height = 406)
palette("default")
map("state")
points(x = alba_fia$LON, y = alba_fia$LAT, col = "cyan", pch = 20, cex = 0.7)
points(x = alba_gbif$decimallongitude, y = alba_gbif$decimallatitude, col = "blue", pch = 20, cex = 0.7)
title(main = "Quercus alba")
legend("bottomleft", legend = c("FIA", "GBIF"), col = c("cyan", "blue"), pch = 20)
dev.off()

png(filename = "Q_rubra_combo.png", width = 675, height = 406)
palette("default")
map("state")
points(x = rubra_fia$LON, y = rubra_fia$LAT, col = "indianred1", pch = 20, cex = 0.7)
points(x = rubra_gbif$decimallongitude, y = rubra_gbif$decimallatitude, col = "red", pch = 20, cex = 0.7)
title(main = "Quercus rubra")
legend("bottomleft", legend = c("FIA", "GBIF"), col = c("indianred1", "red"), pch = 20)
dev.off()


# don't make a png for below because it doesn't look very good.
# now for ggplot
library(ggplot2)
theme_clean <- function(base_size = 12) {
  require(grid)
  theme_gray(base_size) %+replace%
    theme(
      axis.title = element_blank(),
      axis.text = element_blank(),
      panel.background  = element_blank(),
      panel.grid = element_blank(),
      axis.ticks.length = unit(0, "cm"),
      axis.ticks.margin = unit(0, "cm"),
      panel.margin = unit(0, "lines"),
      plot.margin = unit(c(0, 0, 0, 0), "lines" ),
      complete = T
    )
}

us<-map_data('state')
gg_both <- ggplot(alba_gbif,aes(decimallongitude,decimallatitude)) +
  geom_polygon(data=us,aes(x=long,y=lat,group=group),color='gray',fill=NA,alpha=.35)+   
  geom_point(data = alba_fia, aes(x = LON, y = LAT, color = "FIA"), size = .25, alpha = .25) +
  geom_point(aes(color = "GBIF"),size=.25,alpha=.25) +
  xlim(-125,-65)+ylim(20,50) + scale_color_manual(values = c("blue", "cyan")) +
  theme_clean()
print(gg_both + ggtitle("Quercus alba"))
# doesn't look very good

