Data types and manipulation
=============================

After reading in the Surveys and Plots csv files, let's explore what types of data are in each column and what kind of structure your data has. There are several ways to do this in RStudio. 

### Get quick overview

* summary(), dim(), names() and head() are others handy functions to get a quick idea of your data


| function | returns |
|----------|---------|
| dim | dimensions |
| nrow | number of rows |
| ncol | number of columns |
| names | (column) names |
| str | structure |
| summary | summary info |

``` r
str(plots)
summary(plots)

str(surveys)
summary(surveys)
``` 

The data we read in are stored in a __data frame__. Data frames have the same type of data in each column. A specific column in a data frame can be accessed using the $ notation with the column name.

A data frame is the most common way of storing data in R, and if used systematically makes data analysis easier. Under the hood, a data frame is a list of equal-length vectors. This makes it a 2-dimensional structure, so it shares properties of both the matrix and the list. This means that a data frame has names(), colnames(), and rownames(), although names() and colnames() are the same thing. The length() of a data frame is the length of the underlying list and so is the same as ncol(); nrow() gives the number of rows. 

A data.frame is one of the most commonly used objects in R. Just think of a data.frame like a table, or a spreadsheet, with rows and columns and numbers, text, etc. in the cells. A very special thing about the data.frame in R is that it can handle multiple types of data - that is, each column can have a different type. 


## Types of Vectors

There are four common types of atomic vectors: logical, integer, double (often called numeric), and character. There are two rare types: complex and raw. All elements of an atomic vector must be the same type, so when you attempt to combine different types they will be coerced to the most flexible type. Types from least to most flexible are: logical, integer, double, and character. 

**Characters**

Character data (words) in base R is read in as a factor by default, ie. stored as integers. In read_csv or readxl that is not the default (but you can specify the column types if you want, or convert to factors with as.factor())

In surveys table, what is the difference between an NA in the species column vs NA in the wgt column?

``` r
head(surveys)
``` 

You can specify what indicates missing data in the read.csv or read_csv functions using either na.strings = "NA" or na = "NA". You can also specify multiple things to be interpreted as missing values, such as na = c("missing", "no data", "< 0.05 mg/L", "XX")

**Numbers and integers**


**Factors**

A factor is a vector that can contain only predefined values, and is used to store categorical data. Factors are built on top of integer vectors using two attributes: the class(), “factor”, which makes them behave differently from regular integer vectors, and the levels(), which defines the set of allowed values. 


We can make the plots$plot_type column a factor with the as.factor() function

```r
plots$plot_type <- as.factor(plots$plot_type)
``` 

How many plots of each type? With factor data type, now the summary gives that info

``` r
summary(plots)
``` 

**Logical data** (True or False)

Logical data is stored as either a 1 or 0, True or False. Make a new column with a logical data type based on some condition (e.g. whether the taxa was censused). Verify that is is logical (what are several ways to do this?)

``` r
plots$control <- plots$plot_type=="Control"
str(plots)
class(plots$control)
summary(plots)
``` 



### Lists

Lists are different from  vectors because their elements can be of any type, including lists. You construct lists by using list() instead of c()

c() will combine several lists into one. If given a combination of atomic vectors and lists, c() will coerce the vectors to lists before combining them. Compare the results of list() and c()

```r
x <- list(list(1, 2), c(3, 4))
y <- c(list(1, 2), c(3, 4))
str(x)
str(y)
```

Lists are used to build up many of the more complicated data structures in R

Basic Manipulation of Data frames
======================================

R has powerful subsetting capabilities that can be accessed very concisely using square brackets. The square brackets work as follows: anything before the comma refers to the rows that will be selected, anything after the comma refers to the number of columns that should be returned.

### subsetting with brackets

Some ways to subset vectors with bracket notation []

1. __positive integers__: return elements at the specified positions
2. __Negative integers__: omit elements at the specified positions
3. __Logical vectors__: select elements where the corresponding logical value is TRUE
4. __Nothing__: returns the original vector (more useful for dataframes)

 
Qs:

* what happens combining positive and negative integers? (error)
* what happens when logical vector is shorter than the vector being subset? (recycled)
* A missing value in the index always yields a missing value in the output

### subsetting data frames

Fix each of the following common data frame subsetting errors:

    plots[plots$plot_id = 4, ]
    plots[-1:4, ]
    plots[plots$plot_id <= 5]
    plots[plots$plot_id == 4 | 6, ]

### Subsetting with $ and  double brackets

* There are two other subsetting operators: [[ and $. [[ is similar to [, except it can only return a single value and it allows you to pull pieces out of a list. $ is a useful shorthand for [[ combined with character subsetting. 

    “If list x is a train carrying objects, then x[[5]] is the object in car 5; x[4:6] is a train of cars 4-6.”
    — @RLangTip


### Subsetting and assignment

All subsetting operators can be combined with assignment to modify selected values of the input vector. 


With lists, you can use subsetting + assignment + NULL to remove components from a list. To add a literal NULL to a list, use [ and list(NULL):

```r
x <- list(a = 1, b = 2)
x[["b"]] <- NULL
str(x)
```
    #> List of 1
    #>  $ a: num 1
    
```r
y <- list(a = 1)
y["b"] <- list(NULL)
str(y)
```

    #> List of 2
    #>  $ a: num 1
    #>  $ b: NULL



## Selecting rows based on a condition

Because it allows you to easily combine conditions from multiple columns, logical subsetting is probably the most commonly used technique for extracting rows out of a data frame. 

subset() is a specialised shorthand function for subsetting data frames, and saves some typing because you don’t need to repeat the name of the data frame



Additional information
----------------------

http://adv-r.had.co.nz/Subsetting.html#simplify-preserve
http://adv-r.had.co.nz/Vocabulary.html
http://rforcats.net/

## Other Data structures

Data frames are 2-dimensional and can contain heterogenous data like numbers in one column and categories in another. Other types of data in R can be described according to these categories

||Homogeneous |  Heterogeneous|
|----|----|---|
|1d |  Atomic vector |	List|
|2d |	Matrix |	Data frame |
|nd |	Array ||