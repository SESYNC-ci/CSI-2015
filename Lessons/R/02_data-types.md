Data Types
======================================
  
After reading in the 3 csv files, let's explore what types of data are in each column. There are several ways to do this in RStudio. 

* functions like class(), str()
* the Environment window

``` r
str(plots)
summary(plots)

str(surveys)
summary(surveys)
``` 

## Data frames

The data we read in are stored in a __data frame__. Readr creates a special kind of dataframe called a tbl_df that behaves mostly like any other data frame. Data frames have the same type of data in each column. A specific column in a data frame can be accessed using the $ notation with the column name.

```r
species$genus
```

R has powerful subsetting capabilities that can be accessed very concisely using square brackets. The square brackets work as follows: anything before the comma refers to the rows that will be selected, anything after the comma refers to the number of columns that should be returned.


## Characters and factors

Character data (words) in base R is read in as a factor by default, ie. stored as integers. In read_csv or readxl that is not the default (but you can specify the column types if you want, or convert to factors with as.factor())

In surveys table, what is the difference between an NA in the species column vs NA in the wgt column?

``` r
head(surveys)
``` 

You can specify what indicates missing data in the read.csv or read_csv functions using either na.strings = "NA" or na = "NA". You can also specify multiple things to be interpreted as missing values, such as na = c("missing", "no data", "< 0.05 mg/L", "XX")

## Numbers and integers

``` r
class(plots$plot_type)
unique(plots$plot_type)
class(plots[,"plot_type"])
summary(plots[,2])
``` 

We can make the plots$plot_type column a factor with the as.factor() function

``` r
plots$plot_type <- as.factor(plots$plot_type)
``` 

how many plots of each type? with factor data type, now the summary gives that info

``` r
summary(plots)
``` 

## Boolean data (True or False)

Make a new column with a logical data type based on some condition (e.g. whether the taxa was censused). Verify that is is logical (what are several ways to do this?)

``` r
plots$control <- plots$plot_type=="Control"
str(plots)
class(plots$control)
summary(plots)
``` 

## Dates 

We are going to use some simple string manipulation to combine month, day, year into a date column. The function paste() combines things together using either a space or a given separator ("sep = "). paste0() will combine things without space (i.e. the default is: sep = "").

``` r
paste(surveys[1,"year"], surveys[1,"month"], surveys[1,"day"])
paste(surveys[1,"year"], surveys[1,"month"], surveys[1,"day"], sep="-")

``` 
    ## "1977-7-16"
  
``` r
install.packages('lubridate')
library(lubridate)
``` 

ymd() is a function lubridate that converts data into a date format in the sequence year-month-day

``` r
surveys$date <- ymd(paste(surveys$year, surveys$month, surveys$day, sep="-"))    

str(surveys)
``` 

Note the POSIXct format. Now it is easy to find the date of the most recent survey:

``` r
max(surveys$date)
``` 

## Other data structures

* Vectors: 1 dimensional, all the same type of data. Access parts of vectors with single bracket notation, []
* Lists: most flexible. any type of data, including other lists. Access parts of lists with double bracket notation, [[]]
* Matrices and arrays

Additional information
----------------------

* http://cran.r-project.org/web/packages/lubridate/vignettes/lubridate.html
