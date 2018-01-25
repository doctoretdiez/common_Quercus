############ 4.
########### 1.18.18 Elizabeth Tokarz
############# obtaining GBIF data and mapping
#############  Q alba
############## Q rubra
#############

############### INPUT: occurrence data from GBIF database
###### note that we need to create this database online first
###### search for the species of interest and download it
###### you will be redirected to a web page with a unique url for your data
###### alba ID: 0010276-171219132708484
###### rubra ID: 0010278-171219132708484
###### use rgbif and dplyr package for obtaining data
######  *IDs only last for a few years
#####
##### once again, use maps, ggplot and mapdata packages for mapping
#####
############### OUTPUT: visual png maps
######  Q_common_gbif.png (map of lower 48 that shows distribution of occurrences
# of both Quercus alba and Quercus rubra from GBIF dataset, which also includes plantings in gardens)
###### ggQ_alba_gbif.png (ggplot showing only Quercus alba)
###### ggQ_rubra_gbif.png
##### ggQ_common_gbif.png (ggplot showing both species on one map)


# set wd to place where I will pull data
setwd("C:/Users/Elizabeth/Desktop/2017_CTS_fellowship/FIA csv")

# load package to get data from gbif
library(rgbif)
library(dplyr)
#library(tidyverse)

# This is the page from where we can download the csv of all occurrence data in the us
# https://www.gbif.org/occurrence/download/0010248-171219132708484
# we use the number after 'download' in our gbif function.

# after downloading on the website, this should work.
# the second line makes sure that the data frame has NAs instead of blank spaces
# I'm including system time just to see how long this takes to load...its about 22 GB!
#Sys.time()
#usa_gbif <- occ_download_get(key = "0010248-171219132708484", overwrite = TRUE) %>% 
#  occ_download_import(usa_gbif_download, na.strings = c("", NA))
#Sys.time()
# it took about 90 seconds, but there was an error in the process.


# I am now repeating the above, while only considering Quercus alba
alba_gbif <- occ_download_get(key = "0010276-171219132708484", overwrite = TRUE) %>% 
  occ_download_import(usa_gbif_download, na.strings = c("", NA))

# and Quercus rubra
rubra_gbif <- occ_download_get(key = "0010278-171219132708484", overwrite = TRUE) %>% 
  occ_download_import(usa_gbif_download, na.strings = c("", NA))

# Let's see what is included here.
summary(alba_gbif)
#decimallongitude and decimallatitude

# so now we can map them
library("maps", lib.loc="~/R/win-library/3.3")
png(filename = "Q_common_gbif.png", width = 675, height = 406)
palette("default")
map("state")
points(alba_gbif$decimallongitude, alba_gbif$decimallatitude, col = "blue", pch = 20)
points(rubra_gbif$decimallongitude, rubra_gbif$decimallatitude, col = "red", pch = 20)
legend("bottomleft", legend = c("Quercus alba", "Quercus rubra"), col = c("blue", "red"), pch = 20)
title(main = "Common Oaks GBIF")
dev.off()

# and with ggplot
library(ggplot2)
library(mapdata)
us<-map_data('state')
png(filename = "ggQ_alba_gbif.png", width = 675, height = 406)
gg_alba <- ggplot(alba_gbif,aes(decimallongitude,decimallatitude)) +
  geom_polygon(data=us,aes(x=long,y=lat,group=group),color='gray',fill=NA,alpha=.35)+
  geom_point(aes(color = "Quercus alba"),size=.15,alpha=.25) +
  xlim(-125,-65)+ylim(20,50) + scale_color_manual(values = "blue")
print(gg_alba + ggtitle("GBIF"))
dev.off()

png(filename = "ggQ_rubra_gbif.png", width = 675, height = 406)
gg_rubra <- ggplot(rubra_gbif,aes(decimallongitude,decimallatitude)) +
  geom_polygon(data=us,aes(x=long,y=lat,group=group),color='gray',fill=NA,alpha=.35)+
  geom_point(aes(color = "Quercus rubra"),size=.15,alpha=.25) +
  xlim(-125,-65)+ylim(20,50) + scale_color_manual(values = "red")
print(gg_rubra + ggtitle("GBIF"))
dev.off()

# together
png(filename = "ggQ_common_gbif.png", width = 675, height = 406)
gg_both <- ggplot(alba_gbif,aes(decimallongitude,decimallatitude)) +
  geom_polygon(data=us,aes(x=long,y=lat,group=group),color='gray',fill=NA,alpha=.35)+
  geom_point(aes(color = "Quercus alba"),size=.15,alpha=.25) +
  geom_point(data = rubra_gbif, aes(x = decimallongitude, y = decimallatitude, 
                                    color = "Quercus rubra"), size = .15, alpha = .25) +
  xlim(-125,-65)+ylim(20,50) + scale_color_manual(values = c("blue", "red"))
print(gg_both + ggtitle("GBIF"))
dev.off()