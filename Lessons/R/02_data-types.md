Data Types
======================================
  
# Goals for understanding:
##############################
# 1. How to figure out what type of data something is: class() and environment window # 2. character, integer, logical, numeric, dates, esp the difference between factor and character data
# 3. NA, na.strings = /na =, na.rm=TRUE in basic statistics functions
# 4. data frame has same type of data in each column, vector has same type of data, lists can be different types of data
# 5. identify a particular column in a data frame with $ notation
# 6. simple string manipulation
##############################

# After reading in the 3 csv files, explore what types of data are in each column
``` r
str(plots)
summary(plots)

str(surveys)
summary(surveys)
``` 

# character data in base R is read in as a factor by default, ie. stored as integers. in read_csv or readxl that is not the default

# In surveys table, what is the difference between an NA in the species column vs NA in the wgt column?
``` r
head(surveys)
``` 
# Finding different parts of a dataframe
# bracket notation
# $ for column headers
``` r
class(plots$plot_type)
unique(plots$plot_type)
class(plots[,"plot_type"])
summary(plots[,2])
``` 
# Make the plots$plot_type a factor
``` r
plots$plot_type <- as.factor(plots$plot_type)
``` 

# how many plots of each type? with factor data type, now the summary gives that info
``` r
summary(plots)
``` 
# Make a new column with a logical data type based on some condition (e.g. whether the taxa was censused)
# verify that is is logical (what are several ways to do this?)
``` r
plots$control <- plots$plot_type=="Control"
str(plots)
class(plots$control)
summary(plots)
``` 

# combine month, day, year into a date column
``` r
paste(surveys[1,"year"], surveys[1,"month"], surveys[1,"day"], sep="-")

install.packages('lubridate')
library(lubridate)
``` 
# http://cran.r-project.org/web/packages/lubridate/vignettes/lubridate.html

``` r
ymd(paste(surveys[1,"year"], surveys[1,"month"], surveys[1,"day"], sep="-"))
surveys$date <- ymd(paste(surveys$year, surveys$month, surveys$day, sep="-"))    
str(surveys)
``` 
# note the POSIXct format
``` r
max(surveys$date)
``` 
# reiterate: characters, factors, numeric, logical, dates
