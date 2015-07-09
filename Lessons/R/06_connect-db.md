Connecting to a database from R
======================================

  
# 1. Difference between reading in data that lives on a disk and data that is in a database, why you need a different approach and when is each appropriate
# 2. Set up a database connection to...

# Load and connect to an sql database to lead into next session

# DBI package is a common front-end to many backends of databases
# One of 3 families of database packages
# DBI - talks directly to database
# RODBC - intermediary to ODBC
# RJDBC - java and ODBC intermediaries
# More layers makes code slower and installation more painful

# load the DBI package
``` r
library(DBI)
``` 

# connect to a specific database
``` r
db <- dbConnect(RMySQL::MySQL(), user, pass, ...)
db <- dbConnect(RSQLite::SQLite(), path)
``` 
# execute a query from the DBI package
``` r
dbGetQuery(db, "SELECT * FROM mtcars")
``` 
# be polite and close the connection so the server can stop allocating resources to you
``` r
dbDiscconect(db)
``` 
# Don't forget about Bobby Tables!
# http://bobby-tables.com/