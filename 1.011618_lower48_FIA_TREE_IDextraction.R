############ 1.
########### 1.16.18 Elizabeth Tokarz
############# can't download TREE CSV, so I'll create one for the lower 48 for now
############# 
##############

############### INPUT: lower 48 state TREE csv files from FIA Datamart
############### OUTPUT: smaller csv files (removing all dead trees)
###### lower48_AL_FL.csv (5 location columns of data for all trees in states
# alphabetically from Alabama to Florida, , plus status code = 1 indicates a living tree)
###### lower48_ID_MI.csv
###### lower48_MS_OK.csv
###### lower48_OR_VT.csv
###### lower48_VA_WY.csv
######
###### *initially skip Georgia and Minnesota because files are so large

##### If we need additional data from the FIA surveys about trees, then we will need
# to extract different columns from these csvs in the future.

# working directory cannot be changed on the server, so simply specify the route whenever uploading a CSV file

# read in tree data, which lists all species and the plots in which they were found
# this one will take time to read in
treeAL <- read.csv("../data/CSV_DATA/AL_TREE.csv")
# Because I don't currently need too much information, I will save, plot ID info
# and species info only. Status code is useful because it tells us if the tree is alive (STATUSCD = 1)
treeAL <- treeAL[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                                          "PLOT", "SPCD", "STATUSCD")]
# first we want to ensure that all the trees in this sample are live
treeAL <- treeAL[treeAL$STATUSCD == 1, ]

# Next I will read in the tree info for Arizona and remove most of the columns.
treeAZ <- read.csv("../data/CSV_DATA/AZ_TREE.csv")
treeAZ <- treeAZ[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeAZ <- treeAZ[treeAZ$STATUSCD == 1, ]

# I will attempt to bind the data frames so far.
tree_lower48 <- rbind(treeAL, treeAZ)

rm(treeAL, treeAZ)
# Continue with Arkansas
treeAR <- read.csv("../data/CSV_DATA/AR_TREE.csv")
treeAR <- treeAR[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeAR <- treeAR[treeAR$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeAR)
rm(treeAR)
# California
treeCA <- read.csv("../data/CSV_DATA/CA_TREE.csv")
treeCA <- treeCA[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeCA <- treeCA[treeCA$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeCA)
rm(treeCA)
# Colorado
treeCO <- read.csv("../data/CSV_DATA/CO_TREE.csv")
treeCO <- treeCO[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeCO <- treeCO[treeCO$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeCO)
rm(treeCO)
#Connecticut
treeCT <- read.csv("../data/CSV_DATA/CT_TREE.csv")
treeCT <- treeCT[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeCT <- treeCT[treeCT$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeCT)
rm(treeCT)
#Delaware
treeDE <- read.csv("../data/CSV_DATA/DE_TREE.csv")
treeDE <- treeDE[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeDE <- treeDE[treeDE$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeDE)
rm(treeDE)
#Florida
treeFL <- read.csv("../data/CSV_DATA/FL_TREE.csv")
treeFL <- treeFL[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeFL <- treeFL[treeFL$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeFL)
rm(treeFL)

#Write the first CSV here
write.csv(x = tree_lower48, file = "lower48_AL_FL.csv")
#remove the dataframe before continuing...
rm(tree_lower48)

#Georgia
treeGA <- read.csv("../data/CSV_DATA/GA_TREE.csv")
treeGA <- treeGA[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeGA <- treeGA[treeGA$STATUSCD == 1, ]
#note that GA is a big file and nearly impossible to read it all in
# Skip GA
tree_lower48 <- treeGA
rm(treeGA)
# Idaho
treeID <- read.csv("../data/CSV_DATA/ID_TREE.csv")
treeID <- treeID[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeID <- treeID[treeID$STATUSCD == 1, ]
tree_lower48 <- treeID
rm(treeID)
# Illinois
treeIL <- read.csv("../data/CSV_DATA/IL_TREE.csv")
treeIL <- treeIL[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeIL <- treeIL[treeIL$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeIL)
rm(treeIL)
# Indiana
treeIN <- read.csv("../data/CSV_DATA/IN_TREE.csv")
treeIN <- treeIN[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeIN <- treeIN[treeIN$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeIN)
rm(treeIN)
# Iowa
treeIA <- read.csv("../data/CSV_DATA/IA_TREE.csv")
treeIA <- treeIA[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD","STATUSCD")]
treeIA <- treeIA[treeIA$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeIA)
rm(treeIA)
# Kansas
treeKS <- read.csv("../data/CSV_DATA/KS_TREE.csv")
treeKS <- treeKS[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeKS <- treeKS[treeKS$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeKS)
rm(treeKS)
# Kentucky
treeKY <- read.csv("../data/CSV_DATA/KY_TREE.csv")
treeKY <- treeKY[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD","STATUSCD")]
treeKY <- treeKY[treeKY$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeKY)
rm(treeKY)
# Louisiana
treeLA <- read.csv("../data/CSV_DATA/LA_TREE.csv")
treeLA <- treeLA[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeLA <- treeLA[treeLA$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeLA)
rm(treeLA)
# Maine
treeME <- read.csv("../data/CSV_DATA/ME_TREE.csv")
treeME <- treeME[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeME <- treeME[treeME$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeME)
rm(treeME)
# Maryland
treeMD <- read.csv("../data/CSV_DATA/MD_TREE.csv")
treeMD <- treeMD[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeMD <- treeMD[treeMD$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeMD)
rm(treeMD)
# Massachusetts
treeMA <- read.csv("../data/CSV_DATA/MA_TREE.csv")
treeMA <- treeMA[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeMA <- treeMA[treeMA$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeMA)
rm(treeMA)
# Michigan
treeMI <- read.csv("../data/CSV_DATA/MI_TREE.csv")
treeMI <- treeMI[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeMI <- treeMI[treeMI$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeMI)
rm(treeMI)

# let's make another csv file here
write.csv(x = tree_lower48, file = "lower48_ID_MI.csv")
rm(tree_lower48)

# Minnesota
treeMN <- read.csv("../data/CSV_DATA/MN_TREE.csv")
treeMN <- treeMN[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeMN <- treeMN[treeMN$STATUSCD == 1, ]
# Had some issues, skip for now.
tree_lower48 <- treeMN
rm(treeMN)

# Mississippi
treeMS <- read.csv("../data/CSV_DATA/MS_TREE.csv")
treeMS <- treeMS[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeMS <- treeMS[treeMS$STATUSCD == 1, ]
tree_lower48 <- treeMS
rm(treeMS)
# Missouri
treeMO <- read.csv("../data/CSV_DATA/MO_TREE.csv")
treeMO <- treeMO[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeMO <- treeMO[treeMO$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeMO)
rm(treeMO)
# Montana
treeMT <- read.csv("../data/CSV_DATA/MT_TREE.csv")
treeMT <- treeMT[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD","STATUSCD")]
treeMT <- treeMT[treeMT$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeMT)
rm(treeMT)
# Nebraska
treeNE <- read.csv("../data/CSV_DATA/NE_TREE.csv")
treeNE <- treeNE[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD","STATUSCD")]
treeNE <- treeNE[treeNE$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeNE)
rm(treeNE)
# Nevada
treeNV <- read.csv("../data/CSV_DATA/NV_TREE.csv")
treeNV <- treeNV[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeNV <- treeNV[treeNV$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeNV)
rm(treeNV)
# New Hampshire
treeNH <- read.csv("../data/CSV_DATA/NH_TREE.csv")
treeNH <- treeNH[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeNH <- treeNH[treeNH$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeNH)
rm(treeNH)
#New Jersey
treeNJ <- read.csv("../data/CSV_DATA/NJ_TREE.csv")
treeNJ <- treeNJ[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeNJ <- treeNJ[treeNJ$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeNJ)
rm(treeNJ)
# New Mexico
treeNM <- read.csv("../data/CSV_DATA/NM_TREE.csv")
treeNM <- treeNM[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeNM <- treeNM[treeNM$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeNM)
rm(treeNM)
# New York
treeNY <- read.csv("../data/CSV_DATA/NY_TREE.csv")
treeNY <- treeNY[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeNY <- treeNY[treeNY$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeNY)
rm(treeNY)
# North Carolina
treeNC <- read.csv("../data/CSV_DATA/NC_TREE.csv")
treeNC <- treeNC[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeNC <- treeNC[treeNC$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeNC)
rm(treeNC)
# North Dakota
treeND <- read.csv("../data/CSV_DATA/ND_TREE.csv")
treeND <- treeND[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeND <- treeND[treeND$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeND)
rm(treeND)
# Ohio
treeOH <- read.csv("../data/CSV_DATA/OH_TREE.csv")
treeOH <- treeOH[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeOH <- treeOH[treeOH$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeOH)
rm(treeOH)
# Oklahoma
treeOK <- read.csv("../data/CSV_DATA/OK_TREE.csv")
treeOK <- treeOK[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeOK <- treeOK[treeOK$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeOK)
rm(treeOK)

# write new csv here too
write.csv(x = tree_lower48, file = "lower48_MS_OK.csv")
rm(tree_lower48)

# Oregon
treeOR <- read.csv("../data/CSV_DATA/OR_TREE.csv")
treeOR <- treeOR[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD","STATUSCD")]
treeOR <- treeOR[treeOR$STATUSCD == 1, ]
tree_lower48 <- treeOR
rm(treeOR)
# Pennsylvania
treePA <- read.csv("../data/CSV_DATA/PA_TREE.csv")
treePA <- treePA[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treePA <- treePA[treePA$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treePA)
rm(treePA)
# Rhode Island
treeRI <- read.csv("../data/CSV_DATA/RI_TREE.csv")
treeRI <- treeRI[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeRI <- treeRI[treeRI$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeRI)
rm(treeRI)
# South Carolina
treeSC <- read.csv("../data/CSV_DATA/SC_TREE.csv")
treeSC <- treeSC[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD","STATUSCD")]
treeSC <- treeSC[treeSC$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeSC)
rm(treeSC)
# South Dakota
treeSD <- read.csv("../data/CSV_DATA/SD_TREE.csv")
treeSD <- treeSD[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD","STATUSCD")]
treeSD <- treeSD[treeSD$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeSD)
rm(treeSD)
# Tennessee
treeTN <- read.csv("../data/CSV_DATA/TN_TREE.csv")
treeTN <- treeTN[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeTN <- treeTN[treeTN$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeTN)
rm(treeTN)
# Texas
treeTX <- read.csv("../data/CSV_DATA/TX_TREE.csv")
treeTX <- treeTX[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeTX <- treeTX[treeTX$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeTX)
rm(treeTX)
# Utah
treeUT <- read.csv("../data/CSV_DATA/UT_TREE.csv")
treeUT <- treeUT[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD","STATUSCD")]
treeUT <- treeUT[treeUT$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeUT)
rm(treeUT)
# Vermont
treeVT <- read.csv("../data/CSV_DATA/VT_TREE.csv")
treeVT <- treeVT[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD","STATUSCD")]
treeVT <- treeVT[treeVT$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeVT)
rm(treeVT)

# Write new csv now
write.csv(x = tree_lower48, file = "lower48_OR_VT.csv")
rm(tree_lower48)

# Virginia
treeVA <- read.csv("../data/CSV_DATA/VA_TREE.csv")
treeVA <- treeVA[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD","STATUSCD")]
treeVA <- treeVA[treeVA$STATUSCD == 1, ]
tree_lower48 <- treeVA
rm(treeVA)
# Washington
treeWA <- read.csv("../data/CSV_DATA/WA_TREE.csv")
treeWA <- treeWA[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeWA <- treeWA[treeWA$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeWA)
rm(treeWA)
# West Virginia
treeWV <- read.csv("../data/CSV_DATA/WV_TREE.csv")
treeWV <- treeWV[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD","STATUSCD")]
treeWV <- treeWV[treeWV$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeWV)
rm(treeWV)
# Wisconsin
treeWI <- read.csv("../data/CSV_DATA/WI_TREE.csv")
treeWI <- treeWI[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeWI <- treeWI[treeWI$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeWI)
rm(treeWI)
#Wyoming
treeWY <- read.csv("../data/CSV_DATA/WY_TREE.csv")
treeWY <- treeWY[, c("INVYR", "STATECD", "UNITCD", "COUNTYCD",
                     "PLOT", "SPCD", "STATUSCD")]
treeWY <- treeWY[treeWY$STATUSCD == 1, ]
tree_lower48 <- rbind(tree_lower48, treeWY)
rm(treeWY)

# Write a last csv file here
write.csv(x = tree_lower48, file = "lower48_VA_WY.csv")
rm(tree_lower48)
