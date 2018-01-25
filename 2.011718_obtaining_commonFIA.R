############ 2.
########### 1.17.18 Elizabeth Tokarz
############# obtaining location of Quercus alba and Quercus rubra and local density
############# from Lower 48 US TREE data
##############

############### INPUT: PLOT csv file from FIA Datamart
###### from previous R file 1
###### lower48_AL_FL.csv
###### lower48_ID_MI.csv
###### lower48_MS_OK.csv
###### lower48_OR_VT.csv
###### lower48_VA_WY.csv
######
############### OUTPUT: smaller csv files
###### Q_alba_46.csv (each row corresponds to a survey plot in 46 statesin which
# Quercus alba has been found, including longitude, latitude and density of the plot)
###### Q_rubra_46.csv
###### 
###### *excludes Q alba and Q rubra from Georgia and Minnesota

# set wd to place where I will pull data
setwd("C:/Users/Elizabeth/Desktop/2017_CTS_fellowship/FIA csv")


# read in plot data, which includes location according to lat and lon
# be patient. it takes a while.
plot <- read.csv("PLOT.csv")
# read in tree data from the first csv, which lists all species and 
# the plots in which they were found
# this one will take time to read in too
treeALFL <- read.csv("lower48_AL_FL.csv")

# Now both of the above hold more information than we need, so let's extract some data

# From 'treeXX' we want identifying codes INVYR, STATECD, UNITCD, COUNTYCD, PLOT, 
# Quercus alba (species code is 802)
#
alba <- treeALFL[which(treeALFL$SPCD==802), c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                                          "PLOT")]

# Next we will match up the location IDs and merge the 'treeXX' and 'plot' data frames 
alba_loc <- merge(alba, plot, by = c("INVYR", "STATECD", "UNITCD", 
                                     "COUNTYCD", "PLOT"), all = F)
# So we have a good amount of rows to work with, so let's remove unnecessary columns
# we can remove them by renaming our dataframe and extracting only the columns of interest
alba_loc <- alba_loc[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                         "PLOT", "LAT", "LON")]

# We just have to add in density here. First make a dataframe 
# with all unique plots for this state XX and number them with ID numbers.
u <- unique(alba_loc[,c('INVYR','STATECD','UNITCD', 'COUNTYCD', 'PLOT', 'LAT', 'LON')])
ID <- seq(from = 1, to = length(u$INVYR), by = 1)
u_plot <- data.frame(u, ID)

density_test <- merge(u_plot, alba, by = c("INVYR", "UNITCD", "COUNTYCD", "PLOT", "STATECD"), all = F)
t <- as.numeric(table(density_test$ID))
u_plot$density <- t

rm(treeALFL)
##### Now we can redo the steps from lines 22 to 41. First let's read in a new state.

treeIDMI <- read.csv("lower48_ID_MI.csv")

#REVIEW: pare list down to Quercus alba only, merge with plot info, and only keep lat and lon
alba <- treeIDMI[which(treeIDMI$SPCD==802), c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                                          "PLOT")]

alba_loc <- merge(alba, plot, by = c("INVYR", "STATECD", "UNITCD", 
                                     "COUNTYCD", "PLOT"), all = F)

alba_loc <- alba_loc[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                         "PLOT", "LAT", "LON")]

# STEP 2: find density data and make new smaller dataframe
u <- unique(alba_loc[,c('INVYR','STATECD','UNITCD', 'COUNTYCD', 'PLOT', 'LAT', 'LON')])
ID <- seq(from = 1, to = length(u$INVYR), by = 1)
u_plot_attach <- data.frame(u, ID)

density_test <- merge(u_plot_attach, alba, by = c("INVYR", "UNITCD", "COUNTYCD", "PLOT", "STATECD"), all = F)
t <- as.numeric(table(density_test$ID))
u_plot_attach$density <- t

# Now here is the new part, bind the observations from 'u_plot_attach' to existing 'u_plot'

u_plot <- rbind(u_plot, u_plot_attach)
rm(treeIDMI)
# Repeat

treeMSOK <- read.csv("lower48_MS_OK.csv")

alba <- treeMSOK[which(treeMSOK$SPCD==802), c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                                              "PLOT")]
alba_loc <- merge(alba, plot, by = c("INVYR", "STATECD", "UNITCD", 
                                     "COUNTYCD", "PLOT"), all = F)
alba_loc <- alba_loc[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                         "PLOT", "LAT", "LON")]

u <- unique(alba_loc[,c('INVYR','STATECD','UNITCD', 'COUNTYCD', 'PLOT', 'LAT', 'LON')])
ID <- seq(from = 1, to = length(u$INVYR), by = 1)
u_plot_attach <- data.frame(u, ID)

density_test <- merge(u_plot_attach, alba, by = c("INVYR", "UNITCD", "COUNTYCD", "PLOT", "STATECD"), all = F)
t <- as.numeric(table(density_test$ID))
u_plot_attach$density <- t

u_plot <- rbind(u_plot, u_plot_attach)
rm(treeMSOK)

# Repeat

treeORVT <- read.csv("lower48_OR_VT.csv")

alba <- treeORVT[which(treeORVT$SPCD==802), c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                                              "PLOT")]
alba_loc <- merge(alba, plot, by = c("INVYR", "STATECD", "UNITCD", 
                                     "COUNTYCD", "PLOT"), all = F)
alba_loc <- alba_loc[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                         "PLOT", "LAT", "LON")]

u <- unique(alba_loc[,c('INVYR','STATECD','UNITCD', 'COUNTYCD', 'PLOT', 'LAT', 'LON')])
ID <- seq(from = 1, to = length(u$INVYR), by = 1)
u_plot_attach <- data.frame(u, ID)

density_test <- merge(u_plot_attach, alba, by = c("INVYR", "UNITCD", "COUNTYCD", "PLOT", "STATECD"), all = F)
t <- as.numeric(table(density_test$ID))
u_plot_attach$density <- t

u_plot <- rbind(u_plot, u_plot_attach)
rm(treeORVT)

# Repeat

treeVAWY <- read.csv("lower48_VA_WY.csv")

alba <- treeVAWY[which(treeVAWY$SPCD==802), c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                                              "PLOT")]
alba_loc <- merge(alba, plot, by = c("INVYR", "STATECD", "UNITCD", 
                                     "COUNTYCD", "PLOT"), all = F)
alba_loc <- alba_loc[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                         "PLOT", "LAT", "LON")]

u <- unique(alba_loc[,c('INVYR','STATECD','UNITCD', 'COUNTYCD', 'PLOT', 'LAT', 'LON')])
ID <- seq(from = 1, to = length(u$INVYR), by = 1)
u_plot_attach <- data.frame(u, ID)

density_test <- merge(u_plot_attach, alba, by = c("INVYR", "UNITCD", "COUNTYCD", "PLOT", "STATECD"), all = F)
t <- as.numeric(table(density_test$ID))
u_plot_attach$density <- t

u_plot <- rbind(u_plot, u_plot_attach)
rm(treeVAWY)


# Note that we are still missing GA, MN and there may be an issue with WI
# save for now as alba_46
write.csv(x = u_plot, file = "Q_alba_46.csv")

#
#
# Repeat for Quercus rubra below
#
#



treeALFL <- read.csv("lower48_AL_FL.csv")

# Quercus rubra (species code is 833)

rubra <- treeALFL[which(treeALFL$SPCD==833), c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                                              "PLOT")]
rubra_loc <- merge(rubra, plot, by = c("INVYR", "STATECD", "UNITCD", 
                                     "COUNTYCD", "PLOT"), all = F)
rubra_loc <- rubra_loc[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                         "PLOT", "LAT", "LON")]

# We just have to add in density here. First make a dataframe 
u <- unique(rubra_loc[,c('INVYR','STATECD','UNITCD', 'COUNTYCD', 'PLOT', 'LAT', 'LON')])
ID <- seq(from = 1, to = length(u$INVYR), by = 1)
u_plot <- data.frame(u, ID)

density_test <- merge(u_plot, rubra, by = c("INVYR", "UNITCD", "COUNTYCD", "PLOT", "STATECD"), all = F)
t <- as.numeric(table(density_test$ID))
u_plot$density <- t

rm(treeALFL)

# next
treeIDMI <- read.csv("lower48_ID_MI.csv")

#REVIEW: pare list down to Quercus alba only, merge with plot info, and only keep lat and lon
rubra <- treeIDMI[which(treeIDMI$SPCD==833), c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                                              "PLOT")]
rubra_loc <- merge(rubra, plot, by = c("INVYR", "STATECD", "UNITCD", 
                                     "COUNTYCD", "PLOT"), all = F)
rubra_loc <- rubra_loc[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                         "PLOT", "LAT", "LON")]

# STEP 2: find density data and make new smaller dataframe
u <- unique(rubra_loc[,c('INVYR','STATECD','UNITCD', 'COUNTYCD', 'PLOT', 'LAT', 'LON')])
ID <- seq(from = 1, to = length(u$INVYR), by = 1)
u_plot_attach <- data.frame(u, ID)

density_test <- merge(u_plot_attach, rubra, by = c("INVYR", "UNITCD", "COUNTYCD", "PLOT", "STATECD"), all = F)
t <- as.numeric(table(density_test$ID))
u_plot_attach$density <- t

# Now here is the new part, bind the observations from 'u_plot_attach' to existing 'u_plot'

u_plot <- rbind(u_plot, u_plot_attach)
rm(treeIDMI)
# Repeat

treeMSOK <- read.csv("lower48_MS_OK.csv")

rubra <- treeMSOK[which(treeMSOK$SPCD==833), c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                                              "PLOT")]
rubra_loc <- merge(rubra, plot, by = c("INVYR", "STATECD", "UNITCD", 
                                     "COUNTYCD", "PLOT"), all = F)
rubra_loc <- rubra_loc[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                         "PLOT", "LAT", "LON")]

u <- unique(rubra_loc[,c('INVYR','STATECD','UNITCD', 'COUNTYCD', 'PLOT', 'LAT', 'LON')])
ID <- seq(from = 1, to = length(u$INVYR), by = 1)
u_plot_attach <- data.frame(u, ID)

density_test <- merge(u_plot_attach, rubra, by = c("INVYR", "UNITCD", "COUNTYCD", "PLOT", "STATECD"), all = F)
t <- as.numeric(table(density_test$ID))
u_plot_attach$density <- t

u_plot <- rbind(u_plot, u_plot_attach)
rm(treeMSOK)

# Repeat

treeORVT <- read.csv("lower48_OR_VT.csv")

rubra <- treeORVT[which(treeORVT$SPCD==833), c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                                               "PLOT")]
rubra_loc <- merge(rubra, plot, by = c("INVYR", "STATECD", "UNITCD", 
                                       "COUNTYCD", "PLOT"), all = F)
rubra_loc <- rubra_loc[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                           "PLOT", "LAT", "LON")]

u <- unique(rubra_loc[,c('INVYR','STATECD','UNITCD', 'COUNTYCD', 'PLOT', 'LAT', 'LON')])
ID <- seq(from = 1, to = length(u$INVYR), by = 1)
u_plot_attach <- data.frame(u, ID)

density_test <- merge(u_plot_attach, rubra, by = c("INVYR", "UNITCD", "COUNTYCD", "PLOT", "STATECD"), all = F)
t <- as.numeric(table(density_test$ID))
u_plot_attach$density <- t

u_plot <- rbind(u_plot, u_plot_attach)
rm(treeORVT)

# Repeat

treeVAWY <- read.csv("lower48_VA_WY.csv")

rubra <- treeVAWY[which(treeVAWY$SPCD==833), c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                                               "PLOT")]
rubra_loc <- merge(rubra, plot, by = c("INVYR", "STATECD", "UNITCD", 
                                       "COUNTYCD", "PLOT"), all = F)
rubra_loc <- rubra_loc[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                           "PLOT", "LAT", "LON")]

u <- unique(rubra_loc[,c('INVYR','STATECD','UNITCD', 'COUNTYCD', 'PLOT', 'LAT', 'LON')])
ID <- seq(from = 1, to = length(u$INVYR), by = 1)
u_plot_attach <- data.frame(u, ID)

density_test <- merge(u_plot_attach, rubra, by = c("INVYR", "UNITCD", "COUNTYCD", "PLOT", "STATECD"), all = F)
t <- as.numeric(table(density_test$ID))
u_plot_attach$density <- t

u_plot <- rbind(u_plot, u_plot_attach)
rm(treeVAWY)

# Write a new csv with the 46 states included
write.csv(x = u_plot, file = "Q_rubra_46.csv")
