Base plotting in R
======================================

Now we're going to go over some of the ways to make figures in base R. After lunch we'll cover some advanced plotting with ggplot2.

The plot() function is the most basic plotting function. It is polymorphic, ie. uses the input data to determine plot type. 

### Scatterplots

basic syntax is plot(x, y) or plot(y ~ x)

``` r
plot(surveys$month, surveys$wgt)
plot(surveys$year, surveys$wgt)
plot(surveys$year, log(surveys$wgt))

``` 

### Histograms

``` r
hist(surveys$wgt)
hist(log(surveys$wgt))
``` 

#### Boxplots

Use a boxplot to compare the number of species seen each year. We'll use another function from the lubridate package, year()

``` r
par(mfrow=c(1,1))
boxplot(surveys$wgt ~ surveys$year)
boxplot(surveys$wgt ~ surveys$month)
boxplot(log(surveys$wgt) ~ surveys$year)
``` 

### Graphical parameters

* adjust line types, plotting characters, cex, x and y labels
* plot different factors/types in different colors

__Mulit-panel plots__
Multi-panel plots can be made by changing the graphical parameters with the par() function. 

``` r
surveys1990 <- subset(surveys, year == 1990)
surveys1996 <- subset(surveys, year == 1996)

par(mfrow=c(1,2))
hist(log(surveys1990$wgt))
hist(log(surveys1996$wgt))

``` 

?pch

We know that the dates columns are exactly the same for the no_species dataframe and the weights dataframe, so we can just add the Totalwgt column to the species dataframe. If the dates were different we might do a join.


## Saving figures

You can save a plot by opening up a "graphics device" and writing the plot to a specified file. The general syntax is:

```r
pdf(file="myfile.pdf", width=7, height=6, units="in")
plot(x, y)
dev.off()
```

Remember that by default your file will be saved in your working directory

* pdf()
* png()
* postscript()

Additional information
----------------------

* Colorbrewer
* file types for publication
* graphical parameters