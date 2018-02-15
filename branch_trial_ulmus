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

