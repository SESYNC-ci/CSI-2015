Intro to functions
======================================
  
Say we want to find the date of the maximum number of observations of a species

One way to do that:

* aggregate number of observations by survey date
* subset surveys by the given species
* find row with max by sorting
* return date, or return date and number of observations 

``` r
speciesid <- "SA"
surveys_sub <- surveys[surveys$species==speciesid,]
surveys_agg <- aggregate(surveys_sub$record_id, by=list(surveys_sub$date), function(x) length(x))

surveys_agg[max(surveys_agg$x),] # why is this wrong? (returns 7th row)
surveys_agg[which(surveys_agg$x==max(surveys_agg$x)),]
``` 

``` r
surveys_agg[order(surveys_agg$x),] # orders lowest to highest
surveys_agg[rev(order(surveys_agg$x)),] # orders highest to lowest
head(surveys_agg[rev(order(surveys_agg$x)),],1) # pick the first row

surveys_agg <- aggregate(surveys$record_id, by=list(surveys$species, surveys$date), function(x) length(x))
names(surveys_agg) <- c("species", "date", "obs")
surveys_sub <- surveys_agg[surveys_agg$species==speciesid,]
surveys_sub[rev(order(surveys_sub$obs)),]
``` 

We don't want to have to re-evaluate these, every time. So we write a function. basic format for function writing is function(arguments){what function does}

``` r
max_date_finder <- function(x = speciesid){
  # this function finds the date where the highest number of observations were made of the given species
  surveys_agg <- aggregate(surveys$record_id, by=list(surveys$species, surveys$date), function(x) length(x))
  names(surveys_agg) <- c("species", "Date", "no_obs")
  surveys_sub <- surveys_agg[surveys_agg$species==x,]
  max_record <- head(surveys_sub[rev(order(surveys_sub$no_obs)),],1)
  return(max_record$Date)
}


max_date_finder("NA")

max_date_finder <- function(speciesid, dateOrObs = "Date"){
  # this function finds the date where the highest number of observations were made of the given species
  surveys_agg <- aggregate(surveys$record_id, by=list(surveys$species, surveys$date), function(x) length(x))
  names(surveys_agg) <- c("species", "Date", "no_obs")
  surveys_sub <- surveys_agg[surveys_agg$species==speciesid,]
  max_record <- head(surveys_sub[rev(order(surveys_sub$no_obs)),],1)
  if(dateOrObs=="Date") return(list("SpeciesID" = speciesid, "Date"=max_record$Date))
  if(dateOrObs=="Obs") return(list("SpeciesID" = speciesid, "Obs"=max_record$no_obs))
  if(dateOrObs=="Both") return(list("SpeciesID" = speciesid, "Date"=max_record$Date, "Obs"=max_record$no_obs))
}

max_date_finder(speciesid = "NA")
max_date_finder("NA", dateOrObs = "Obs")
max_date_finder("NA", dateOrObs = "Both")

specieslist <- unique(species$species_id)

max_obs_dates <- lapply(specieslist, function(x) max_date_finder(x, dateOrObs = "Both"))

``` 

Additional information
----------------------

