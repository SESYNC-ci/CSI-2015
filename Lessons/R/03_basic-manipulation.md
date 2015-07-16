Basic Manipulation of Data frames
======================================

R has powerful subsetting capabilities that can be accessed very concisely using square brackets. The square brackets work as follows: anything before the comma refers to the rows that will be selected, anything after the comma refers to the number of columns that should be returned.

R’s subsetting operators are powerful and fast. Mastery of subsetting allows you to succinctly express complex operations in a way that few other languages can match. Subsetting is hard to learn because you need to master a number of interrelated concepts:

* The three subsetting operators.
* The six types of subsetting.
* Important differences in behaviour for different objects (e.g., vectors, lists, factors, matrices, and data frames).
* The use of subsetting in conjunction with assignment.



## Subsetting

subsetting allows you to pull out the pieces that you’re interested in

### subsetting vectors

There are 5 things you can use to subset vectors with bracket notation []

1. __positive integers__: return elements at the specified positions
2. __Negative integers__: omit elements at the specified positions
3. __Logical vectors__: select elements where the corresponding logical value is TRUE
4. __Nothing__: returns the original vector (more useful for dataframes)
5. __Zero__: returns a zero-length vector. This is not something you usually do on purpose, but it can be helpful for generating test data
 
Qs:

* what happens combining positive and negative integers? (error)
* what happens when logical vector is shorter than the vector being subset? (recycled)
* A missing value in the index always yields a missing value in the output

### subsetting data frames

The most common way of subsetting matrices (2d) and arrays (>2d) is a simple generalisation of 1d subsetting: you supply a 1d index for each dimension, separated by a comma. Blank subsetting is now useful because it lets you keep all rows or all columns.

Data frames possess the characteristics of both lists and matrices: if you subset with a single vector, they behave like lists; if you subset with two vectors, they behave like matrices.


Fix each of the following common data frame subsetting errors:

    plots[plots$plot_id = 4, ]
    plots[-1:4, ]
    plots[plots$plot_id <= 5]
    plots[plots$plot_id == 4 | 6, ]

### Subsetting operators

* There are two other subsetting operators: [[ and $. [[ is similar to [, except it can only return a single value and it allows you to pull pieces out of a list. $ is a useful shorthand for [[ combined with character subsetting. 
* Because it can return only a single value, you must use [[ with either a single positive integer or a string


    “If list x is a train carrying objects, then x[[5]] is the object in car 5; x[4:6] is a train of cars 4-6.”
    — @RLangTip

* subset
* which() and logical statements
* bracket notation
* c()

You can combine data frames using cbind() and rbind()

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


If x is a matrix, what does x[] <- 0 do? How is it different to x <- 0?


## Re-ordering and sorting columns 

order
sort

## Selecting rows based on a condition

Because it allows you to easily combine conditions from multiple columns, logical subsetting is probably the most commonly used technique for extracting rows out of a data frame. 

subset() is a specialised shorthand function for subsetting data frames, and saves some typing because you don’t need to repeat the name of the data frame

## Logical & sets 
&, |, !, xor
all, any
intersect, union, setdiff, setequal
which


## Basic math

```r
*, +, -, /, ^, %%, %/%
abs, sign
acos, asin, atan, atan2
sin, cos, tan
ceiling, floor, round, trunc, signif
exp, log, log10, log2, sqrt

max, min, prod, sum
cummax, cummin, cumprod, cumsum, diff
pmax, pmin
range
mean, median, cor, sd, var
rle
```

Additional information
----------------------

http://adv-r.had.co.nz/Subsetting.html#simplify-preserve
http://adv-r.had.co.nz/Vocabulary.html

