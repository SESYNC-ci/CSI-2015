Basic Manipulation of Data frames
======================================

# Goals for understanding:
# 1. Subsetting with bracket notation, double brackets for list items
# 2. aggregate()
# 3. basic statistics
# 4. basic info about the data frame (nrow, ncol, dim, str, summary)
# 5. c() to combine things

# Basic manipulation with data.
# R has powerful subsetting capabilities that can be accessed very concisely using square brackets. The square brackets work as follows: anything before the comma refers to the rows that will be selected, anything after the comma refers to the number of columns that should be returned

``` r
summary(surveys)
``` 
# how 

# change the species column in surveys table to species_id to match species table

# How many species of each taxa are there?