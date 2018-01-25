############ 5. 
########### 1.22.18 Elizabeth Tokarz
############# trying to get MN and GA to open.
#############  Q alba
############## Q rubra
#############

#################INPUT: PLOT csv and 2 TREE csvs from FIA datamart
###### GA_TREE.csv
###### MN_TREE.csv
#####  * this failed before in R file 1
#####
############### OUTPUT: alba and rubra plot location and density data for 
# Georgia and Minnesota only
######  Q_alba_GAMN.csv
#####   Q_rubra_GAMN.csv
#####

# I noticed that the annual inventories for these states both predate 2000 and 
# there were several surveys done in these two states before then.
# So there is a lot of data contained in these CSVs.


# set working directory to pull fia data
setwd("C:/Users/Elizabeth/Desktop/2017_CTS_fellowship/FIA csv")

plot <- read.csv("PLOT.csv")


GA <- read.csv("GA_TREE.csv")
# make an alba-specific file
albaG <- GA[which(GA$SPCD==802), c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                                              "PLOT")]

alba_loc <- merge(albaG, plot, by = c("INVYR", "STATECD", "UNITCD", 
                                     "COUNTYCD", "PLOT"), all = F)

alba_loc <- alba_loc[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                         "PLOT", "LAT", "LON")]
u <- unique(alba_loc[,c('INVYR','STATECD','UNITCD', 'COUNTYCD', 'PLOT', 'LAT', 'LON')])
ID <- seq(from = 1, to = length(u$INVYR), by = 1)
a_plot_attach <- data.frame(u, ID)

density_test <- merge(a_plot_attach, albaG, by = c("INVYR", "UNITCD", "COUNTYCD", "PLOT", "STATECD"), all = F)
t <- as.numeric(table(density_test$ID))
a_plot_attach$density <- t

# and a rubra one...just in case
rubraG <- GA[which(GA$SPCD==833), c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                                   "PLOT")]

rubra_loc <- merge(rubraG, plot, by = c("INVYR", "STATECD", "UNITCD", 
                                      "COUNTYCD", "PLOT"), all = F)

rubra_loc <- rubra_loc[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                         "PLOT", "LAT", "LON")]
u <- unique(rubra_loc[,c('INVYR','STATECD','UNITCD', 'COUNTYCD', 'PLOT', 'LAT', 'LON')])
ID <- seq(from = 1, to = length(u$INVYR), by = 1)
r_plot_attach <- data.frame(u, ID)

density_test <- merge(r_plot_attach, rubraG, by = c("INVYR", "UNITCD", "COUNTYCD", "PLOT", "STATECD"), all = F)
t <- as.numeric(table(density_test$ID))
r_plot_attach$density <- t

rm(GA)


# Now do the same for MN
MN <- read.csv("MN_TREE.csv")
# this one has some warnings, but I think it's okay...

albaM <- MN[which(MN$SPCD==802), c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                                   "PLOT")]

alba_loc <- merge(albaM, plot, by = c("INVYR", "STATECD", "UNITCD", 
                                      "COUNTYCD", "PLOT"), all = F)

alba_loc <- alba_loc[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                         "PLOT", "LAT", "LON")]
u <- unique(alba_loc[,c('INVYR','STATECD','UNITCD', 'COUNTYCD', 'PLOT', 'LAT', 'LON')])
ID <- seq(from = 1, to = length(u$INVYR), by = 1)
a_plot_attach2 <- data.frame(u, ID)

density_test <- merge(a_plot_attach2, albaM, by = c("INVYR", "UNITCD", "COUNTYCD", "PLOT", "STATECD"), all = F)
t <- as.numeric(table(density_test$ID))
a_plot_attach2$density <- t

# and a rubra one...just in case
rubraM <- MN[which(MN$SPCD==833), c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                                    "PLOT")]

rubra_loc <- merge(rubraM, plot, by = c("INVYR", "STATECD", "UNITCD", 
                                        "COUNTYCD", "PLOT"), all = F)

rubra_loc <- rubra_loc[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                           "PLOT", "LAT", "LON")]
u <- unique(rubra_loc[,c('INVYR','STATECD','UNITCD', 'COUNTYCD', 'PLOT', 'LAT', 'LON')])
ID <- seq(from = 1, to = length(u$INVYR), by = 1)
r_plot_attach2 <- data.frame(u, ID)

density_test <- merge(r_plot_attach2, rubraM, by = c("INVYR", "UNITCD", "COUNTYCD", "PLOT", "STATECD"), all = F)
t <- as.numeric(table(density_test$ID))
r_plot_attach2$density <- t

rm(MN)


# Now combine our datasets and write a csv...
a_plot <- rbind(a_plot_attach, a_plot_attach2)
r_plot <- rbind(r_plot_attach, r_plot_attach2)

write.csv(x = a_plot, file = "Q_alba_GAMN.csv")
write.csv(x = r_plot, file = "Q_rubra_GAMN.csv")
