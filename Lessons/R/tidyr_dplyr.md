Data manipulation with tidyr and dplyr
======================================

In the previous lessons, we loaded and processed the same dataset in two different formats: R data frames and SQL tables. In this session, we"ll explore this data again with the **dplyr** R package. This package provides new functions for commonly-used operations on data frames, which are more user-friendly and often more computer efficient than base R. Their format is also very similar to SQL commands, facilitating the translation between the two languages.

To get the most out of packages like dplyr and ggplot2 (which we"ll discuss later), it is often necessary to reshape data frames in a certain standard format. Therefore, we will first look at the **tidyr** package and its utility functions for "cleaning" data sets.

Tidy data concept
-----------------

R developer Hadley Wickham (author of the tidyr, dplyr and ggplot packages, among others) defines "tidy" datasets as those where:

-   each variable forms a column;
-   each observation forms a row; and
-   each type of observational unit forms a table. ([ref](http://www.jstatsoft.org/v59/i10/paper))

These guidelines may look familiar now, as similar ideas form the basis of good database design. The tables in our sample dataset (*surveys*, *species* and *plots*) are already in a tidy format. Let"s consider a different examples where the counts of three species are recorded for each day in a week:

``` r
counts_df <- data.frame(
  day = c("Monday", "Tuesday", "Wednesday"),
  wolf = c(2, 1, 3),
  hare = c(20, 25, 30),
  fox = c(4, 4, 4)
)
counts_df
```

    ##         day wolf hare fox
    ## 1    Monday    2   20   4
    ## 2   Tuesday    1   25   4
    ## 3 Wednesday    3   30   4

**Question**: Does this dataset require tidying? If so, how?

**Answer**: *counts\_df* currently has three columns (*wolf*, *hare* and *fox*) representing the same variable (a count). Since each reported observation is the count of individuals from a given species on a given day: the tidy format should have three columns: *day*, *species* and *count*.

To put it another way, if you can consider the grouping of observations based on some characteristic (e.g. draw a graph of the counts over time with a different color for each species), then this characteristic should be recorded as different levels of a categorical variable (species) rather than spread across different variables/columns.

Reshaping multiple columns into category/value pairs
----------------------------------------------------

Let"s load the **tidyr** package and use its `gather` function to reshape *counts\_df* into a tidy format:

``` r
library(tidyr)
counts_df <- gather(counts_df, key = "species", value = "count", 
                    wolf:fox)
counts_df
```

    ##         day species count
    ## 1    Monday    wolf     2
    ## 2   Tuesday    wolf     1
    ## 3 Wednesday    wolf     3
    ## 4    Monday    hare    20
    ## 5   Tuesday    hare    25
    ## 6 Wednesday    hare    30
    ## 7    Monday     fox     4
    ## 8   Tuesday     fox     4
    ## 9 Wednesday     fox     4

One of the neat aspects of tidyr and dplyr is that each function takes a data frame as its first parameter and returns the transformed data frame. As we will see later, it makes it very easy to apply these functions in a chain. Here, `gather` takes the range of columns `wolf:fox` (note that we did not need to repeat the name of the data frame) and reshapes them into two columns, the names of which are specified as the key and value. The key column contains the column name corresponding to each value in the original dataset.

The inverse of `gather` is `spread`. You can confirm that the code below restores the original form of *counts\_df*:

``` r
counts_df <- spread(counts_df, key = species, value = count)
counts_df
```

    ##         day wolf hare fox
    ## 1    Monday    2   20   4
    ## 2   Tuesday    1   25   4
    ## 3 Wednesday    3   30   4

Why are `species` and `count` not quoted here? (They refer to existing column names.)

Splitting and joining character columns
---------------------------------------

The tidyr package also provides the `separate` function to split a character column into multiple pieces and `unite` to paste columns together. This can be useful to deal with timestamps, binomial names, etc. Here we will take the *species* table from our original dataset and create a new *name* column that combines the genus and species, separated by a space:

``` r
plots <- read.csv("/nfs/public-data/CSI2015/plots.csv", na.strings = "")
species <- read.csv("/nfs/public-data/CSI2015/species.csv", na.strings = "")
surveys <- read.csv("/nfs/public-data/CSI2015/surveys.csv", na.strings = "")
```

``` r
species <- unite(species, name, c(genus, species), sep=" ")
head(species)
```

    ##   species_id                            name                taxa
    ## 1         AB            Amphispiza bilineata                Bird
    ## 2         AH        Ammospermophilus harrisi Rodent-not censused
    ## 3         AS           Ammodramus savannarum                Bird
    ## 4         BA                 Baiomys taylori              Rodent
    ## 5         CB Campylorhynchus brunneicapillus                Bird
    ## 6         CM         Calamospiza melanocorys                Bird

Note that `unite` removes the original columns by default, but this be changed with the argument `remove = FALSE`. Now let"s use `separate` to reverse our previous operation:

``` r
species <- separate(species, name, c("genus", "species"), sep=" ", convert = TRUE)
head(species)
```

    ##   species_id            genus         species                taxa
    ## 1         AB       Amphispiza       bilineata                Bird
    ## 2         AH Ammospermophilus         harrisi Rodent-not censused
    ## 3         AS       Ammodramus      savannarum                Bird
    ## 4         BA          Baiomys         taylori              Rodent
    ## 5         CB  Campylorhynchus brunneicapillus                Bird
    ## 6         CM      Calamospiza     melanocorys                Bird

The `convert = TRUE` argument lets R convert the new columns to their "natural" type. As an example, if we were splitting a date into year, month and day, R would automatically recognize the pieces as numeric rather than character data.

### Exercise

Write the code to create a new date column (YYYY/MM/DD format) in the *surveys* data frame while keeping all the existing columns.

Key functions in dplyr
----------------------

As mentioned before, the functions in the **dplyr** package have roles that mirror the main SQL commands, e.g. selecting rows or columns, sorting or grouping rows by the value of a certain column, aggregating values, and joining different tables. Here, we will apply each of these operations in turn, starting from our *surveys* data frame.

To sample a certain number or a certain fraction of rows at random, use `sample_n` and `sample_frac`, respectively.

``` r
library(dplyr)
surveys_pick100 <- sample_n(surveys, 100)
head(surveys_pick100)
```

    ##       record_id month day year plot species  sex wgt
    ## 33199     33199    11  18 2001   13      PB    M  50
    ## 21902     21902    11   1 1994    1      PF    F   7
    ## 25631     25631     4  13 1997   15      OT    F  26
    ## 29686     29686     5  16 1999   15      PP    M  17
    ## 16652     16652    11   4 1989    7      RF    F  15
    ## 2073       2073     9  23 1979   16    <NA> <NA>  NA

`arrange` sorts rows over one or multiple columns. As a comparison, I added the base R code doing the same operation.

``` r
sorted1 <- arrange(surveys_pick100, species, desc(wgt))
sorted2 <- surveys_pick100[order(surveys_pick100$species, -surveys_pick100$wgt),]
head(sorted1)
```

    ##   record_id month day year plot species  sex wgt
    ## 1      3586    12  15 1980   16      AB <NA>  NA
    ## 2     21160    10  15 1993    2      AB <NA>  NA
    ## 3     13775    11  22 1987    7      AB <NA>  NA
    ## 4     23854     4  15 1996   15      AH <NA>  NA
    ## 5     22063     2   4 1995    1      DM    F  53
    ## 6       593     2  18 1978    2      DM    M  52

To select rows based on certain conditions (like WHERE in SQL), use `filter`. Note that a logical "and" is implied when conditions are separated by commas.

``` r
surveys1990_winter <- filter(surveys, year == 1990, month %in% 1:3)
```

As in SQL, the `select` function chooses specific columns. However, it is also possible to *exclude* a column by preceding its name with a minus sign. We use this option here to remove the redundant year column from *surveys\_1990\_winter*.

``` r
surveys1990_winter <- select(surveys1990_winter, -year)
head(surveys1990_winter)
```

    ##   record_id month day plot species sex wgt
    ## 1     16879     1   6    1      DM   F  35
    ## 2     16880     1   6    1      OL   M  28
    ## 3     16881     1   6    6      PF   M   7
    ## 4     16882     1   6   23      RM   F   9
    ## 5     16883     1   6   12      RM   M  10
    ## 6     16884     1   6   24      RM   M   9

Let"s say we want to count the number of individuals observed by species for that season. To do that, we will first define a grouping with `group_by`, then use `summarise` to aggregate values in each group according to some function (here, the built-in function `n()` to count the rows).

``` r
surveys1990_winter <- group_by(surveys1990_winter, species)
counts_1990w <- summarise(surveys1990_winter, count = n())
head(counts_1990w)
```

    ## Source: local data frame [6 x 2]
    ## 
    ##   species count
    ## 1      AB    25
    ## 2      AH     4
    ## 3      BA     3
    ## 4      DM   132
    ## 5      DO    65
    ## 6      DS     6

### Exercise

Write code that would return the average weight of all *Dipodomys merriami* (species code **DM**) observed in the plots for each month of the year 2000.

Keep this code since you will need it again for the next exercise.

------------------------------------------------------------------------

We could make our *counts\_1990w* table more informative by adding the full name of the species. This amounts to joining the table with the *species* table, with matching done by species ID.

``` r
counts_1990w_join <- inner_join(counts_1990w, species, 
                                by = c("species" = "species_id"))
```

    ## Warning in inner_join_impl(x, y, by$x, by$y): joining factors with
    ## different levels, coercing to character vector

``` r
head(counts_1990w_join)
```

    ## Source: local data frame [6 x 5]
    ## 
    ##   species count            genus   species.y                taxa
    ## 1      AB    25       Amphispiza   bilineata                Bird
    ## 2      AH     4 Ammospermophilus     harrisi Rodent-not censused
    ## 3      BA     3          Baiomys     taylori              Rodent
    ## 4      DM   132        Dipodomys    merriami              Rodent
    ## 5      DO    65        Dipodomys       ordii              Rodent
    ## 6      DS     6        Dipodomys spectabilis              Rodent

If you look at the whole *counts\_1990w\_join* data frame, you may notice the last row of *counts\_1990w* (where the species info. was *NA*) was excluded. An `inner_join` only keeps rows for which a match was found in the other table. To keep all rows from the first table, we could use `left_join` instead.

``` r
counts_1990w_join <- left_join(counts_1990w, species, 
                               by = c("species" = "species_id"))
```

The last dplyr key function is `mutate`, which creates new columns by performing the same operation on existing values in each row. Here we use the absolute counts from *counts\_1990w\_join* to derive the proportion of each species.

``` r
counts_1990w <- mutate(counts_1990w, prop = count / sum(count))
head(counts_1990w)
```

    ## Source: local data frame [6 x 3]
    ## 
    ##   species count       prop
    ## 1      AB    25 0.05091650
    ## 2      AH     4 0.00814664
    ## 3      BA     3 0.00610998
    ## 4      DM   132 0.26883910
    ## 5      DO    65 0.13238289
    ## 6      DS     6 0.01221996

Chaining operations with pipes (%\>%)
-------------------------------------

We have seen that dplyr functions all take a data frame as their first argument and return a transformed data frame. This consistent syntax has the added benefit of making these functions compatible the "pipe" operator (`%>%`). This operator actually comes from another R package, **magrittr**, which is loaded with dplyr by default. What `%>%` does is to take the expression on its left-hand side and feed it as the first argument to the function on its right-hand side. Here is a simple example:

``` r
c(1,3,5,NA) %>% sum(na.rm = TRUE)   # same as sum(c(1,3,5,NA), na.rm = TRUE)
```

### Exercise

Adapt your code from the last exercise (average weight of *DM* individuals for each month of 2000) using the pipe `%>%` operator.

Using dplyr with SQL tables
---------------------------

A common need of SESYNC researchers is to scale up an existing analysis to bigger datasets, which often involves replacing local files that fit in R memory with SQL databases. In this context, a major benefit of dplyr is that it provides an interface to query SQL tables using the exact same syntax as for data frames. Here we connect to our SQLite database with the `src_sqlite` function, then use `tbl` to assign a variable to the *surveys* table (without loading it in memory).

``` r
mammals_db <- src_sqlite("/nfs/public-data/CSI2015/portal_mammals.sqlite")
surveys_sql <- tbl(mammals_db, "surveys")
surveys_sql
```

    ## Source: sqlite 3.8.6 [/nfs/public-data/CSI2015/portal_mammals.sqlite]
    ## From: surveys [35,549 x 8]
    ## 
    ##    record_id month day year plot species sex wgt
    ## 1          1     7  16 1977    2      NA   M  NA
    ## 2          2     7  16 1977    3      NA   M  NA
    ## 3          3     7  16 1977    2      DM   F  NA
    ## 4          4     7  16 1977    7      DM   M  NA
    ## 5          5     7  16 1977    3      DM   M  NA
    ## 6          6     7  16 1977    1      PF   M  NA
    ## 7          7     7  16 1977    2      PE   F  NA
    ## 8          8     7  16 1977    1      DM   M  NA
    ## 9          9     7  16 1977    1      DM   F  NA
    ## 10        10     7  16 1977    6      PF   F  NA
    ## ..       ...   ... ...  ...  ...     ... ... ...

Following those preliminary steps, we can use exactly the same analysis code as before to get the species counts for the 1990 winter months.

``` r
counts_1990w_sql <-  surveys_sql %>% filter(year == 1990, month %in% 1:3) %>%
                                     select(-year) %>%
                                     group_by(species) %>%
                                     summarise(count = n())
counts_1990w_sql
```

    ## Source: sqlite 3.8.6 [/nfs/public-data/CSI2015/portal_mammals.sqlite]
    ## From: <derived table> [?? x 2]
    ## 
    ##    species count
    ## 1       NA     1
    ## 2       AB    25
    ## 3       AH     4
    ## 4       BA     3
    ## 5       DM   132
    ## 6       DO    65
    ## 7       DS     6
    ## 8       NA    10
    ## 9       OL     7
    ## 10      OT    22
    ## ..     ...   ...

In this case, dplyr translated the R commands to SQL and sent them in a single query to the SQLite database. Note that the output is still stored on disk rather than in memory. The `collect` function can be used to import a remote table into R, as in `counts_1990w_local <- collect(counts_1990w_sql)`.

Additional information
----------------------

[Data wrangling with dplyr and tidyr (RStudio cheat sheet)](http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)
