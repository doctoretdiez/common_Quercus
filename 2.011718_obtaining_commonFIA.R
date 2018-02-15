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

# now try running this with a loop through all state dbs

# make sure that dfs.in is a vector
path.dat <- "/home/data"
dfs.in <- dir(file.path(path.dat, "FIA_CSV_DATA"), "_TREE.csv")

FIA.species.loc.write <- function(dfs.in, spp) {
  u_plot <- rep(NA, times = length(dfs.in))
  
  for(i in 1:length(dfs.in)) {
  
    df.tmp <- read.csv(file.path(path.dat, "FIA_CSV_DATA", dfs.in[i]))
    plot <- read.csv(file.path(path.dat, "FIA_CSV_DATA/PLOT.csv"))
    species <- df.tmp[which(df.tmp$SPCD==spp), c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                                             "PLOT")]  
  
  species_loc <- merge(species, plot, by = c("INVYR", "STATECD", "UNITCD", 
                                             "COUNTYCD", "PLOT"), all = F)
  
  species_loc <- species_loc[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                                 "PLOT", "LAT", "LON")]
  
  u <- unique(species_loc[, c('INVYR','STATECD','UNITCD', 'COUNTYCD', 'PLOT', 'LAT', 'LON')])
  ID <- seq(from = 1, to = length(u$INVYR), by = 1)
  u_plot[i] <- data.frame(u, ID)
  
  density_test <- merge(u_plot, species, by = c("INVYR", "UNITCD", "COUNTYCD", "PLOT", "STATECD"), all = F)
  t <- as.numeric(table(density_test$ID))
  u_plot[i]$FIA_plot_density <- t
  
  # make a new place to store all the observations
  tree_lower48 <- data.frame()
  tree_lower48 <- rbind(tree_lower48, u_plot[i])

  }
  
  write.csv(x = tree_lower48, file = paste0(spp, "_", "lower48.csv"))
}

alba <- 802
rubra <- 833
FIA.species.loc.write(alba)

FIA.species.loc.write(treeALFL, rubra)
