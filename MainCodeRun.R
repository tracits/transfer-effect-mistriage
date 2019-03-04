## Effects of transfer on mistriage study main R code file 
## 
## This file was created using RStudio 1.1.463
MainCodeRun <- function() {
  
    ## Load required packages and source functions
    ## FuncPack() first needs to be sourced to run
    source("./functions/FuncPack.R")
    FuncPack()
    ## Set random seed
    set.seed(-41892)
    ## Import data
    raw.data <- ImportStudyData("simulated-swetrau-data.csv")
    ## Create study sample from selected variables
    selected.data <- VariableSelection(raw.data)
    ## Select cases with age > 15 or age = NA
    selected.data <- InclusionSelection(selected.data)
    ## Data Cleaning
    selected.data <- DataCleaning(selected.data)
    ## Convert SBP and RR to restricted cubic splines
    selected.data <- RCSplineConvert(selected.data)
  
    ## DATA SETS AND SAMPLES
    ## Mark entries as High Volume or Low Volume
    selected.data.vol.mark <- HighVolumeCheck(selected.data)
    ## Create High Volume Sample and Low Volume Sample
    High.Volume.Sample <- selected.data.vol.mark[selected.data.vol.mark$High_Volume_Centre == "Yes", ]
    Low.Volume.Sample <- selected.data.vol.mark[selected.data.vol.mark$High_Volume_Centre == "No", ]
    rm(selected.data.vol.mark)
    ## Mark entries as Metropolitan or Non-Metropolitan
    selected.data.metro.mark <- Metrocheck(selected.data)
    ## Create Metropolitan Sample and Non-Metropolitan Sample
    Metropolitan.Sample <- selected.data.metro.mark[selected.data.metro.mark$metropolitan == "Yes", ]
    Non.Metropolitan.Sample <- selected.data.metro.mark[selected.data.metro.mark$metropolitan == "No", ]
    rm(selected.data.metro.mark)
    ## Mark entries as valid (>170 events) individual centres
    selected.data.ind.mark <- IndividualCentreCheck(selected.data)
    ## Create Multi Centre Sample (All data)
    Multi.Centre.Sample <- selected.data.ind.mark

    ## Create Individual Centre Sample 1-n, where n is the total number of valid individual centres 
    #? I´m trying to create a function that outputs a data.frame named Individual.Centre.Sample.1, Individual.Centre.Sample.2... and so on.
    #? My inital thought was extracting each unique "Sjukhuskod" present in Multi.Centre.Sample as its own data.frame, and having R name 
    #? the data.frames accordingly. However, I can´get it to work.

    ## Create Single Centre Samples (valid individual centres)
    centre.ids <- unique(selected.data.ind.mark$Sjukhuskod) # Identify unique IDs
    centre.ids <- setNames(centre.ids, nm = paste0("centre_", centre.ids)) # Name IDs
    Single.Centre.Samples <- lapply(centre.ids, SelectSingleCentre, df = selected.data.ind.mark)
    Single.Centre.Samples <- Single.Centre.Samples[-which(sapply(Single.Centre.Samples, is.null))]
    rm(selected.data.ind.mark) 

    ## Add samples to list
    data.sets <- list(high.volume.vs.low.volume = list(high.volume = High.Volume.Sample,
                                                       low.volume = Low.Volume.Sample),
                      metropolitan.vs.non.metropolitan = list(metropolitan = Metropolitan.Sample,
                                                              non.metropolitat = Non.Metropolitan.Sample),
                      multi.centre.vs.single.centres = list(multi.centre = Multi.Centre.Sample,
                                                           single.centres = Single.Centre.Samples))

    ## Now you want to do the same operations on each sample in the list 
    
    ## DEVELOPMENT AND VALIDATION
    ## Create High Volume Sample Development and Validation
   
    ## Create Low Volume Sample Development and Validation
   
    ## Create Metropolitan Sample Development and Validation
   
    ## Create Non-Metropolitan Development and Validation
   
    ## Create Multi Centre Sample Development and Validation
   
    ## Create Individual Sample Development and Validation
   
    ## MISSING DATA MANAGEMENT
   
    ## CLINICAL PREDICTION MODEL
    ## Model development
   
    ## Model Validation
   
    ## Model comparison
   
    ## COMPILE RESULTS
   
}