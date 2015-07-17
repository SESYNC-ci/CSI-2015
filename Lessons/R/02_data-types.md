Data Structures
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

The data we read in are stored in a __data frame__. Data frames have the same type of data in each column. A specific column in a data frame can be accessed using the $ notation with the column name.

A data frame is the most common way of storing data in R, and if used systematically makes data analysis easier. Under the hood, a data frame is a list of equal-length vectors. This makes it a 2-dimensional structure, so it shares properties of both the matrix and the list. This means that a data frame has names(), colnames(), and rownames(), although names() and colnames() are the same thing. The length() of a data frame is the length of the underlying list and so is the same as ncol(); nrow() gives the number of rows. 

A data.frame is one of the most commonly used objects in R. Just think of a data.frame like a table, or a spreadsheet, with rows and columns and numbers, text, etc. in the cells. A very special thing about the data.frame in R is that it can handle multiple types of data - that is, each column can have a different type. Like in the below table the first column is of numeric type, the second a factor, and the third character.

You create a data frame using data.frame(), which takes named vectors as input:

```r
species$genus
```

### Combining data frames

You can combine data frames using cbind() and rbind()

## Data structures

Data frames are 2-dimensional and can contain heterogenous data like numbers in one column and categories in another. Other types of data in R can be described according to these categories

||Homogeneous |	Heterogeneous|
|----|----|---|
|1d |	Atomic vector |	List|
|2d |	Matrix |	Data frame |
|nd |	Array ||

* Vectors: 1 dimensional, all the same type of data. Access parts of vectors with single bracket notation, []
* Lists: most flexible. any type of data, including other lists. Access parts of lists with double bracket notation, [[]]
* Matrices and arrays: Adding a dim() attribute to an atomic vector allows it to behave like a multi-dimensional array. A special case of the array is the matrix, which has two dimensions. Matrices are used commonly as part of the mathematical machinery of statistics.
* Note that R has no 0-dimensional, or scalar types. Individual numbers or strings, which you might think would be scalars, are actually vectors of length one.


### Coercion
All elements of an atomic vector must be the same type, so when you attempt to combine different types they will be coerced to the most flexible type. Types from least to most flexible are: logical, integer, double, and character. 

## Vectors

There are four common types of atomic vectors: logical, integer, double (often called numeric), and character. There are two rare types: complex and raw. 

#### Characters and factors

Character data (words) in base R is read in as a factor by default, ie. stored as integers. In read_csv or readxl that is not the default (but you can specify the column types if you want, or convert to factors with as.factor())

In surveys table, what is the difference between an NA in the species column vs NA in the wgt column?

``` r
head(surveys)
``` 

You can specify what indicates missing data in the read.csv or read_csv functions using either na.strings = "NA" or na = "NA". You can also specify multiple things to be interpreted as missing values, such as na = c("missing", "no data", "< 0.05 mg/L", "XX")

#### Numbers and integers

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

#### Logical data (True or False)

Make a new column with a logical data type based on some condition (e.g. whether the taxa was censused). Verify that is is logical (what are several ways to do this?)

``` r
plots$control <- plots$plot_type=="Control"
str(plots)
class(plots$control)
summary(plots)
``` 

#### Dates 

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

#### Factors

A factor is a vector that can contain only predefined values, and is used to store categorical data. Factors are built on top of integer vectors using two attributes: the class(), “factor”, which makes them behave differently from regular integer vectors, and the levels(), which defines the set of allowed values. 

### Lists

Lists are different from atomic vectors because their elements can be of any type, including lists. You construct lists by using list() instead of c()

c() will combine several lists into one. If given a combination of atomic vectors and lists, c() will coerce the vectors to lists before combining them. Compare the results of list() and c()

```r
x <- list(list(1, 2), c(3, 4))
y <- c(list(1, 2), c(3, 4))
str(x)
str(y)
```

Lists are used to build up many of the more complicated data structures in R





Additional information
----------------------

http://adv-r.had.co.nz/Data-structures.html

* http://cran.r-project.org/web/packages/lubridate/vignettes/lubridate.html
