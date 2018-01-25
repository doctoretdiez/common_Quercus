############ 1.
########### 1.16.18 Elizabeth Tokarz
############# can't download TREE CSV, so I'll create one for the lower 48 for now
############# 
##############

############### INPUT: lower 48 state TREE csv files from FIA Datamart
############### OUTPUT: smaller csv files
###### lower48_AL_FL.csv (5 location columns of data for all trees in states
# alphabetically from Alabama to Florida)
###### lower48_ID_MI.csv
###### lower48_MS_OK.csv
###### lower48_OR_VT.csv
###### lower48_VA_WY.csv
######
###### *initially skip Georgia and Minnesota because files are so large

##### If we need additional data from the FIA surveys about trees, then we will need
# to extract different columns from these csvs in the future.

# set wd to place from where I will pull data
setwd("C:/Users/Elizabeth/Desktop/2017_CTS_fellowship/FIA csv")

# read in tree data, which lists all species and the plots in which they were found
# this one will take time to read in
treeAL <- read.csv("AL_TREE.csv")
# Because I don't currently need too much information, I will save, plot ID info
# and species info only.
treeAL <- treeAL[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                                          "PLOT", "SPCD")]

# Next I will read in the tree info for Arizona and remove most of the columns.
treeAZ <- read.csv("AZ_TREE.csv")
treeAZ <- treeAZ[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]

# I will attempt to bind the data frames so far.
tree_lower48 <- rbind(treeAL, treeAZ)

rm(treeAL, treeAZ)
# Continue with Arkansas
treeAR <- read.csv("AR_TREE.csv")
treeAR <- treeAR[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeAR)
rm(treeAR)
# California
treeCA <- read.csv("CA_TREE.csv")
treeCA <- treeCA[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeCA)
rm(treeCA)
# Colorado
treeCO <- read.csv("CO_TREE.csv")
treeCO <- treeCO[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeCO)
rm(treeCO)
#Connecticut
treeCT <- read.csv("CT_TREE.csv")
treeCT <- treeCT[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeCT)
rm(treeCT)
#Delaware
treeDE <- read.csv("DE_TREE.csv")
treeDE <- treeDE[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeDE)
rm(treeDE)
#Florida
treeFL <- read.csv("FL_TREE.csv")
treeFL <- treeFL[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeFL)
rm(treeFL)

#Write the first CSV here
write.csv(x = tree_lower48, file = "lower48_AL_FL.csv")
#remove the dataframe before continuing...
rm(tree_lower48)
#Georgia
treeGA <- read.csv("GA_TREE.csv")
treeGA <- treeGA[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
#note that GA is a big file and nearly impossible to read it all in
# Skip GA
tree_lower48 <- treeGA
rm(treeGA)
# Idaho
treeID <- read.csv("ID_TREE.csv")
treeID <- treeID[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]

tree_lower48 <- treeID
rm(treeID)
# Illinois
treeIL <- read.csv("IL_TREE.csv")
treeIL <- treeIL[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeIL)
rm(treeIL)
# Indiana
treeIN <- read.csv("IN_TREE.csv")
treeIN <- treeIN[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeIN)
rm(treeIN)
# Iowa
treeIA <- read.csv("IA_TREE.csv")
treeIA <- treeIA[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeIA)
rm(treeIA)
# Kansas
treeKS <- read.csv("KS_TREE.csv")
treeKS <- treeKS[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeKS)
rm(treeKS)
# Kentucky
treeKY <- read.csv("KY_TREE.csv")
treeKY <- treeKY[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeKY)
rm(treeKY)
# Louisiana
treeLA <- read.csv("LA_TREE.csv")
treeLA <- treeLA[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeLA)
rm(treeLA)
# Maine
treeME <- read.csv("ME_TREE.csv")
treeME <- treeME[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeME)
rm(treeME)
# Maryland
treeMD <- read.csv("MD_TREE.csv")
treeMD <- treeMD[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeMD)
rm(treeMD)
# Massachusetts
treeMA <- read.csv("MA_TREE.csv")
treeMA <- treeMA[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeMA)
rm(treeMA)
# Michigan
treeMI <- read.csv("MI_TREE.csv")
treeMI <- treeMI[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
#This one is really big too
tree_lower48 <- rbind(tree_lower48, treeMI)
rm(treeMI)

# let's make another csv file here
write.csv(x = tree_lower48, file = "lower48_ID_MI.csv")
rm(tree_lower48)

# Minnesota
treeMN <- read.csv("MN_TREE.csv")
treeMN <- treeMN[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
# Had some issues, skip for now.
tree_lower48 <- treeMN
rm(treeMN)

# Mississippi
treeMS <- read.csv("MS_TREE.csv")
treeMS <- treeMS[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- treeMS
rm(treeMS)
# Missouri
treeMO <- read.csv("MO_TREE.csv")
treeMO <- treeMO[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeMO)
rm(treeMO)
# Montana
treeMT <- read.csv("MT_TREE.csv")
treeMT <- treeMT[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeMT)
rm(treeMT)
# Nebraska
treeNE <- read.csv("NE_TREE.csv")
treeNE <- treeNE[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeNE)
rm(treeNE)
# Nevada
treeNV <- read.csv("NV_TREE.csv")
treeNV <- treeNV[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeNV)
rm(treeNV)
# New Hampshire
treeNH <- read.csv("NH_TREE.csv")
treeNH <- treeNH[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeNH)
rm(treeNH)
#New Jersey
treeNJ <- read.csv("NJ_TREE.csv")
treeNJ <- treeNJ[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeNJ)
rm(treeNJ)
# New Mexico
treeNM <- read.csv("NM_TREE.csv")
treeNM <- treeNM[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeNM)
rm(treeNM)
# New York
treeNY <- read.csv("NY_TREE.csv")
treeNY <- treeNY[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeNY)
rm(treeNY)
# North Carolina
treeNC <- read.csv("NC_TREE.csv")
treeNC <- treeNC[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeNC)
rm(treeNC)
# North Dakota
treeND <- read.csv("ND_TREE.csv")
treeND <- treeND[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeND)
rm(treeND)
# Ohio
treeOH <- read.csv("OH_TREE.csv")
treeOH <- treeOH[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeOH)
rm(treeOH)
# Oklahoma
treeOK <- read.csv("OK_TREE.csv")
treeOK <- treeOK[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeOK)
rm(treeOK)

# write new csv here too
write.csv(x = tree_lower48, file = "lower48_MS_OK.csv")
rm(tree_lower48)

# Oregon
treeOR <- read.csv("OR_TREE.csv")
treeOR <- treeOR[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- treeOR
rm(treeOR)
# Pennsylvania
treePA <- read.csv("PA_TREE.csv")
treePA <- treePA[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treePA)
rm(treePA)
# Rhode Island
treeRI <- read.csv("RI_TREE.csv")
treeRI <- treeRI[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeRI)
rm(treeRI)
# South Carolina
treeSC <- read.csv("SC_TREE.csv")
treeSC <- treeSC[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeSC)
rm(treeSC)
# South Dakota
treeSD <- read.csv("SD_TREE.csv")
treeSD <- treeSD[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeSD)
rm(treeSD)
# Tennessee
treeTN <- read.csv("TN_TREE.csv")
treeTN <- treeTN[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeTN)
rm(treeTN)
# Texas
treeTX <- read.csv("TX_TREE.csv")
treeTX <- treeTX[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeTX)
rm(treeTX)
# Utah
treeUT <- read.csv("UT_TREE.csv")
treeUT <- treeUT[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeUT)
rm(treeUT)
# Vermont
treeVT <- read.csv("VT_TREE.csv")
treeVT <- treeVT[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeVT)
rm(treeVT)

# Write new csv now
write.csv(x = tree_lower48, file = "lower48_OR_VT.csv")
rm(tree_lower48)

# Virginia
treeVA <- read.csv("VA_TREE.csv")
treeVA <- treeVA[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- treeVA
rm(treeVA)
# Washington
treeWA <- read.csv("WA_TREE.csv")
treeWA <- treeWA[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeWA)
rm(treeWA)
# West Virginia
treeWV <- read.csv("WV_TREE.csv")
treeWV <- treeWV[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeWV)
rm(treeWV)
# Wisconsin
treeWI <- read.csv("WI_TREE.csv")
treeWI <- treeWI[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
####too much data? include for now...

tree_lower48 <- rbind(tree_lower48, treeWI)
rm(treeWI)
#Wyoming
treeWY <- read.csv("WY_TREE.csv")
treeWY <- treeWY[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD")]
tree_lower48 <- rbind(tree_lower48, treeWY)
rm(treeWY)

# Write a last csv file here
write.csv(x = tree_lower48, file = "lower48_VA_WY.csv")
rm(tree_lower48)