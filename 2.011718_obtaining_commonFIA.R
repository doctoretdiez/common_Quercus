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
# Q. alba spcd == 802
# Q. rubra spcd == 833
############### OUTPUT: smaller csv files
###### Q_alba_46.csv (each row corresponds to a survey plot in 46 statesin which
# Quercus alba has been found, including longitude, latitude and density of the plot)
###### Q_rubra_46.csv
###### 
###### *excludes Q alba and Q rubra from Georgia and Minnesota

#
# Note. condensed state csvs have been previously formatted when looking to find the 
# location of certain species for mapping purposes very quickly. However, if we need
# to go back and find additional tree data, such as its diameter, then pull from the
# raw state csvs
#

# read in plot data, which includes location according to lat and lon
# be patient. it takes a while.
plot <- read.csv("../data/FIA_CSV_DATA/PLOT.csv")
# read in tree data from the first csv, which lists all species and 
# the plots in which they were found
# this one will take time to read in too
treeALFL <- read.csv("../../lower48_AL_FL.csv")

# Now both of the above hold more information than we need, so let's extract some data

# Quercus alba (species code is 802)
#
alba <- 802
# Quercus rubra (species code is 833)
rubra <- 833
# now read in our function to be more efficient.

# run this print function first to examine the available occurrence data. 
# Be careful if there are a lot of occurrences
FIA.species.loc.print <- function(df.in, spp) {
  # pare data frame down to species of interest only
    species <- df.in[which(df.in$SPCD==spp), c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                                             "PLOT")]  
  print(species)
  # Next we will match up the location IDs and merge the 'treeXX' and 'plot' data frames 
  species_loc <- merge(species, plot, by = c("INVYR", "STATECD", "UNITCD", 
                                             "COUNTYCD", "PLOT"), all = F)
  # and only keep lat and lon from PLOT
  species_loc <- species_loc[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                                 "PLOT", "LAT", "LON")]
  # STEP 2: find density data and make new smaller dataframe 
  # with all unique plots with this species and number them with ID numbers.
  u <- unique(species_loc[, c('INVYR','STATECD','UNITCD', 'COUNTYCD', 'PLOT', 'LAT', 'LON')])
  ID <- seq(from = 1, to = length(u$INVYR), by = 1)
  u_plot <- data.frame(u, ID)
  
  density_test <- merge(u_plot, species, by = c("INVYR", "UNITCD", "COUNTYCD", "PLOT", "STATECD"), all = F)
  t <- as.numeric(table(density_test$ID))
  u_plot$FIA_plot_density <- t
  # u_plot will show all unique FIA plots with our species of interest, as well as
  # the density of the plot (number of individuals of our species tallied in this single survey plot)
  print(u_plot)
  
}

# run this write function second, once ready to compile the occurrence data
FIA.species.loc.write <- function(df.in, spp) {
  
  species <- df.in[which(df.in$SPCD==spp), c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                                             "PLOT")]  
  print(species)
  
  species_loc <- merge(species, plot, by = c("INVYR", "STATECD", "UNITCD", 
                                             "COUNTYCD", "PLOT"), all = F)
  
  species_loc <- species_loc[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                                 "PLOT", "LAT", "LON")]
  
  u <- unique(species_loc[, c('INVYR','STATECD','UNITCD', 'COUNTYCD', 'PLOT', 'LAT', 'LON')])
  ID <- seq(from = 1, to = length(u$INVYR), by = 1)
  u_plot <- data.frame(u, ID)
  
  density_test <- merge(u_plot, species, by = c("INVYR", "UNITCD", "COUNTYCD", "PLOT", "STATECD"), all = F)
  t <- as.numeric(table(density_test$ID))
  u_plot$FIA_plot_density <- t
  print(u_plot)
  
  write.csv(x = u_plot, file = paste0(spp, "", df.in, ".csv"))
}

FIA.species.loc.write(treeALFL, alba)
FIA.species.loc.write(treeALFL, rubra)
rm(treeALFL)

##### Now we can rerun the function with another set of tree data.
treeIDMI <- read.csv("../../lower48_ID_MI.csv")
FIA.species.loc.write(treeIDMI, alba)
FIA.species.loc.write(treeIDMI, rubra)
rm(treeIDMI)

# Repeat again
treeMSOK <- read.csv("../../lower48_MS_OK.csv")
FIA.species.loc.write(treeMSOK, alba)
FIA.species.loc.write(treeMSOK, rubra)
rm(treeMSOK)

# Repeat
treeORVT <- read.csv("../../lower48_OR_VT.csv")
FIA.species.loc.write(treeORVT, alba)
FIA.species.loc.write(treeORVT, rubra)
rm(treeORVT)

# Repeat
treeVAWY <- read.csv("../../lower48_VA_WY.csv")
FIA.species.loc.write(treeVAWY, alba)
FIA.species.loc.write(treeVAWY, rubra)
rm(treeVAWY)

# Now here is the new part, bind the observations from 'u_plot_attach' to existing 'u_plot'

u_plot <- rbind(u_plot, u_plot_attach)


# Note that we are still missing GA, MN and there may be an issue with WI
# save for now as alba_46
write.csv(x = u_plot, file = "Q_alba_46.csv")


# Write a new csv with the 46 states included
write.csv(x = u_plot, file = "Q_rubra_46.csv")


##For further examination of specific trees, go back to the raw state CSVs
FIA.species.loc <- function(df.in, spp) {
  
  species <- df.in[which(df.in$SPCD==spp), c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                                             "PLOT", "STATUSCD", "DIA")]  
  print(species)
  
  species_loc <- merge(species, plot, by = c("INVYR", "STATECD", "UNITCD", 
                                             "COUNTYCD", "PLOT"), all = F)
  
  species_loc <- species_loc[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                                 "PLOT", "LAT", "LON")]
  
  u <- unique(species_loc[, c('INVYR','STATECD','UNITCD', 'COUNTYCD', 'PLOT', 'LAT', 'LON')])
  ID <- seq(from = 1, to = length(u$INVYR), by = 1)
  u_plot <- data.frame(u, ID)
  
  density_test <- merge(u_plot, species, by = c("INVYR", "UNITCD", "COUNTYCD", "PLOT", "STATECD"), all = F)
  t <- as.numeric(table(density_test$ID))
  u_plot$FIA_plot_density <- t
  print(u_plot)
  
  write.csv(x = u_plot, file = paste0(spp, "", db.in, ".csv"))
}

