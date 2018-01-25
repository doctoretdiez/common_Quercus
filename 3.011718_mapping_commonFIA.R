############ 3.
########### 1.17.18 Elizabeth Tokarz
############# mapping FIA Quercus alba and Quercus rubra in 46 states
############# 
##############

############### INPUT: PLOT csv file from FIA Datamart
###### from previous R file 2
###### Q_alba_46.csv
###### Q_rubra_46.csv
###### continuous legend function
###### use maps package for base plotting
###### use mapdata and ggplot2 package for plotting in ggplot2
######
############### OUTPUT: visual png maps
######  Q_alba_46_FIA.png (map of lower 48 that shows distribution of plots 
# containing Q alba and the density shown in color)
###### Q_rubra_46_FIA.png
###### ggQ_alba_46_FIA.png (ggplot version)
###### ggQ_rubra_46_FIA.png
###### 
###### *excludes Q alba and Q rubra from Georgia and Minnesota, so there are gaps in the map.


# set wd to place where I will pull data
setwd("C:/Users/Elizabeth/Desktop/2017_CTS_fellowship/FIA csv")

# read in pre-cleaned species data (Note: missing Minnesota and Georgia data)
# it includes lat and lon of each plot and the density of the species in the plot
# we have two species to upload
#
# Quercus alba
alba <- read.csv("Q_alba_46.csv")

# Quercus rubra
rubra <- read.csv("Q_rubra_46.csv")

# for the continuous color palettes, we will need a special legend
legend.col <- function(col, lev){
  
  opar <- par
  
  n <- length(col)
  
  bx <- par("usr")
  
  box.cx <- c(bx[2] + (bx[2] - bx[1]) / 1000,
              bx[2] + (bx[2] - bx[1]) / 1000 + (bx[2] - bx[1]) / 50)
  box.cy <- c(bx[3], bx[3])
  box.sy <- (bx[4] - bx[3]) / n
  
  xx <- rep(box.cx, each = 2)
  
  par(xpd = TRUE)
  for(i in 1:n){
    
    yy <- c(box.cy[1] + (box.sy * (i - 1)),
            box.cy[1] + (box.sy * (i)),
            box.cy[1] + (box.sy * (i)),
            box.cy[1] + (box.sy * (i - 1)))
    polygon(xx, yy, col = col[i], border = col[i])
    
  }
  par(new = TRUE)
  plot(0, 0, type = "n",
       ylim = c(min(lev), max(lev)),
       yaxt = "n", ylab = "",
       xaxt = "n", xlab = "",
       frame.plot = FALSE)
  axis(side = 4, las = 2, tick = FALSE, line = .25)
  par <- opar
}

# Make a regular plot now
# First we will reorder to points to be in ascending order of density
alba <- alba[order(alba$density),]
# to include the border of the US, we will need to open the maps package.
library("maps", lib.loc="~/R/win-library/3.3")
# save this as a png
png(filename = "Q_alba_46_FIA.png", width = 675, height = 406)

# make the outline of the US
palette("default")
map("state")
# change the palette to a continuous scale that traverses the length of plot density
palette(rainbow(n = length(unique(alba$density)), alpha = 0.3))
# add this for use in our legend
colr <- rainbow(n = length(unique(alba$density)), alpha = 0.7)
# plot the points on the map using this new palette
points(alba$LON, alba$LAT, col = alba$density, pch = 20)
# and make the legend
legend.col(col = colr, lev = alba$density)
#add a title before saving
title(main = "Quercus alba FIA")
# now finish the saved graph
dev.off()

# Repeat for Q_rubra
rubra <- rubra[order(rubra$density),]
# make a new png here...
png(filename = "Q_rubra_46_FIA.png", width = 675, height = 406)
palette("default")
map("state")
palette(rainbow(n = length(unique(rubra$density)), alpha = 0.3))
colr <- rainbow(n = length(unique(rubra$density)), alpha = 0.7)
points(rubra$LON, rubra$LAT, col = rubra$density, pch = 20)
legend.col(col = colr, lev = rubra$density)
title(main = "Quercus rubra FIA")
dev.off()

# Experimenting with ggplot some!!
# if skip here, don't forget about ordering data by density!
library(ggplot2)
library(mapdata)
us<-map_data('state')

# make a new png here...
png(filename = "ggQ_alba_46_FIA.png", width = 675, height = 406)
gg_alba <- ggplot(alba,aes(LON,LAT)) +
  geom_polygon(data=us,aes(x=long,y=lat,group=group),color='gray',fill=NA,alpha=.35)+
  geom_point(aes(color = -density),size=.15,alpha=.25) +
  xlim(-125,-65)+ylim(20,50)
print(gg_alba + ggtitle("Quercus alba FIA"))
dev.off()

# and now rubra
png(filename = "ggQ_rubra_46_FIA.png", width = 675, height = 406)
gg_rubra <- ggplot(rubra,aes(LON,LAT)) +
  geom_polygon(data=us,aes(x=long,y=lat,group=group),color='gray',fill=NA,alpha=.35)+
  geom_point(aes(color = -density),size=.15,alpha=.25) +
  xlim(-125,-65)+ylim(20,50)
print(gg_rubra + ggtitle("Quercus rubra FIA"))
dev.off()