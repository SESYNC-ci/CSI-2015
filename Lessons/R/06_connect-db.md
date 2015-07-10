Connecting to a database from R
======================================

What is the difference between reading in data that lives on a disk and data that is in a database?
When is a good time to use a database? 

We'll load and connect to an sql database to lead into next session

* DBI package is a common front-end to many backends of databases
* One of 3 families of database packages
* DBI - talks directly to database
* RODBC - intermediary to ODBC
* RJDBC - java and ODBC intermediaries
* More layers makes code slower and installation more painful

 Load the DBI package
``` r
library(DBI)
``` 

To connect to a specific database

``` r
db <- dbConnect(RMySQL::MySQL(), user, pass, ...)
db <- dbConnect(RSQLite::SQLite(), path)
``` 

To execute a query from the DBI package

``` r
dbGetQuery(db, "SELECT * FROM mtcars")
``` 

 Be polite and close the connection so the server can stop allocating resources to you
``` r
dbDiscconect(db)
``` 

Additional information
----------------------

http://bobby-tables.com/