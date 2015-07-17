Loading data into R
======================================

Our first mission is to ingest your data into R in a way that makes it easy to work with. Data could live on a disk, in a database, or on the web. Our focus right now is when data lives on a disk. We will move later into when data lives on a database or on the web.

    # The first functions to learn
    ?
    str

## Your working directory

The current path in the files browser. A nicely organized file structure will make it easy to share your code later

First let's make sure that we are in the right directory so R knows where to find your files. The files we'll be using are in a public-data folder....

Some functions return a result without any given arguments, like "get working directory". Otherwise, you will need to supply __arguments__ to functions.

``` r
getwd()
setwd()
list.files(path = "Data/", pattern =".csv") # Find all files with .csv in the data folder
``` 

## Read in your data

_put path to data folder on etherpad_
list.files(path = '/nfs/public-data/CSI2015/')

The data we are going to use is in a folder on the sesync storage space that you can access through RStudio. "public-data" is a folder just like many of you will have for your projects. 


* use a function like read.csv() that reads in a file

* use the function by passing it the appropriate arguments. there are necessary arguments and optional arguments for functions


Now let's read in the file into a dataframe with the read_csv() function. The general syntax for the functions to read in data are to give the path to the file name, and then supply optinal additional arguments as necessary like specifying column types. If you don't specify what argument you are giving it, R will use the default ordering of the function. 



## The assignment operator

What happens if you just do

``` r
read.csv(file="/nfs/public-data/CSI2015/plots.csv")
```

the function returns your data. use the assignment operator "<-" to store that data in memory and work with it

``` r
plots <- read.csv(file="/nfs/public-data/CSI2015/plots.csv")
species <- read.csv(file="/nfs/public-data/CSI2015/species.csv")
surveys <- read.csv(file="/nfs/public-data/CSI2015/surveys.csv")
``` 


## Look at your data frames

There are several ways to look at the data
* open csv by clicking on name in file browser
* use head()
* navigate in Environment window

``` r
head(surveys)
head(species)
class(plots)
``` 

Additional information
--------------------------

| Type of files | Suggested package | Functions | Alternative packages |
|---------------|---------------|---------------|---------------|
| flat (.csv, .txt) | readr | read_csv() | base, data.table |
| excel (.xls, .xlsx) | readxl | read_excel() | gdata, openxlsx, XLConnect, xlsx |
| other stat programs | haven | read_sas() | foreign, sas7bdat, readstat13 |

nice features of readr package compared to base R.

* It is about 10x faster than base functions
* zipped files automatically uncompressed; ftp or http files automatically downloaded
* if column/field types are not supplied then they are guessed from the first 100 rows of data
* if there are parsing issues reading in the data, there is a warning message. Use problems() to get more details.


See more information about the __readr__ package here: http://blog.rstudio.org/2015/04/09/readr-0-1-0/

Note that readr functions input tbl_df which is a type of data frame. might need to convert to data frame in some instances with as.data.frame()
