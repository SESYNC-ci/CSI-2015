Loading data into R
======================================

Our first mission is to ingest your data into R in a way that makes it easy to work with. Data could live on a disk, in a database, or on the web. R has several packages for working with each type of data. Our focus right now is when data lives on a disk. We will move later into when data lives on a database or on the web.

Packages
---------------------

Packages are the fundamental units of reproducible R code. Packages include reusable R functions, the documentation that describes how to use them, and sample data. Packages need to be installed with the function install.packages() and then loaded with library() or require().

Let's load the __readr__ package

``` r
install.packages("readr")
library(readr)
```

Instructions on using packages can be accessed using the help tab; documentation, blogs, and vignettes on the web; and by using the question mark ahead of a function call like this:

```r
?readr
```

For more info on creating your own R packages: http://r-pkgs.had.co.nz/

Sometimes multiple packages have the same function names. You can specify the function in a specific package using the following notation, which means the read_csv function in the readr package.

```r
readr::read_csv() 
```

| Type of files | Suggested package | Functions | Alternative packages |
|---------------|---------------|---------------|---------------|
| flat (.csv, .txt) | readr | read_csv() | base, data.table |
| excel (.xls, .xlsx) | readxl | read_excel() | gdata, openxlsx, XLConnect, xlsx |
| other stat programs | haven | read_sas() | foreign, sas7bdat, readstat13 |


See more information about the __readr__ package here: http://blog.rstudio.org/2015/04/09/readr-0-1-0/

We will use the readr package because is has some nice features compared to base R.

* It is about 10x faster than base functions
* zipped files automatically uncompressed; ftp or http files automatically downloaded
* if column/field types are not supplied then they are guessed from the first 100 rows of data
* if there are parsing issues reading in the data, there is a warning message. Use problems() to get more details.

Your working directory
------------------------
The current path in the files browser. A nicely organized file structure will make it easy to share your code later

First let's make sure that we are in the right directory so R knows where to find your files. The files we'll be using are in a public-data folder....

Some functions return a result without any given arguments, like "get working directory". Otherwise, you will need to supply __arguments__ to functions.

``` r
getwd()
setwd()
list.files(path = "Data/", pattern =".csv") # Find all files with .csv in the data folder
``` 

Now let's read in the file into a dataframe with the read_csv() function. The general syntax for the functions to read in data are to give the path to the file name, and then supply optinal additional arguments as necessary like specifying column types. If you don't specify what argument you are giving it, R will use the default ordering of the function. 

``` r
plots <- read_csv(file="Data/plots.csv")
# equivalent to: plots <- read_csv("Data/plots.csv")
species <- read_csv(file="Data/species.csv")
surveys <- read_csv(file="Data/surveys.csv")
``` 

There are several ways to look at the data
* open csv by clicking on name in file browser
* use head()
* navigate in Environment window

``` r
head(surveys)
head(species)
class(plots)
``` 

Note that readr functions input tbl_df which is a type of data frame. might need to convert to data frame in some instances with as.data.frame()
