Loading data into R
======================================

Goals for understanding:
# 1. Packages are the fundamental units of reproducible R code. How to find help and read package documentation.
# 2. How to read in data from a flat or tabular file such as csv or excel file
# 3. The main arguments for read_csv() function. Also in general how to use a function and assignment operator to store data in memory.
# 4. Working directory concept

# Data could live on a disk, in a database, or on the web
# more info here: http://blog.rstudio.org/2015/04/09/readr-0-1-0/

# Our focus right now is when data lives on a disk. We will move later into when data lives on a database
# Goal is to ingest your data into R in a way that makes it easy to work with

# Packages include reusable R functions, the documentation that describes how to use them, and sample data. For more info on creating your own R packages: http://r-pkgs.had.co.nz/
# packages need to be installed with install.packages() and then loaded with library() or require()
# readr::read_csv() means the read_csv function in the readr package.

# (1) If your data is in flat/tabular files like .csv or .txt
``` r
install.packages("readr")
library(readr)
readr::read_csv()
```
# alternatives: base, data.table
# about 10x faster than base functions

# (2) Excel files
``` r
library(readxl)
read_excel()
``` 
# alternatives: gdata, openxlsx, XLConnect, xlsx

# (3) Other statistics programs
``` r
library(haven)
haven::read_sas()
``` 
# alternatives: foreign, sas7bdat, readstat13

# General syntax is the path to the file name and then specify column types

# Some nice features of readr functions over base R:
# zipped files automatically uncompressed; ftp or http files automatically downloaded
# if column/field types are not supplied then they are guessed from the first 100 rows of data
# if there are parsing issues reading in the data, there is a warning message. Use problems() to get more details.
# allude to tidy data

# working directory is the current path in the files browser
# a nicely organized file structure will make it easy to share your code later
setwd("/Users/kellyhondula/Documents/work/CYBER/WORKSHOPS/CSI-2015")

getwd()
``` r
list.files(path="Data/", pattern=".csv") # Find all files with .csv in the data folder
``` 

# read in the file into a dataframe
``` r
plots <- read_csv(file="Data/plots.csv")
species <- read_csv(file="Data/species.csv")
surveys <- read_csv(file="Data/surveys.csv")
``` 

# Look at the data
# open csv by clicking on name in file browser
# use head()
# navigate in Environment window
``` r
head(surveys)
head(species)
class(plots)
``` 
# note that readr functions input tbl_df which is a type of data frame. might need to convert to data frame in some instances with as.data.frame()
