Base plotting in R
======================================

Now we're going to go over some of the ways to make figures in base R. After lunch we'll cover some advanced plotting with ggplot2.

The plot() function is the most basic plotting function. It is ploymorphic, ie. uses the input data to determine plot type. 

To plot the total weight of animals seen on each survey date

``` r
weights <- aggregate(surveys$wgt, by=list(surveys$date), function(x) sum(x, na.rm=TRUE))
str(weights)
names(weights) <- c("Date", "Total_wgt")

plot(weights$Date, weights$Total_wgt)
plot(weights$Date, weights$Total_wgt, type="o")
plot(weights$Date, weights$Total_wgt, type="l")
plot(weights$Date, weights$Total_wgt, type="l", lty=2, col="gray")
points(weights$Date, weights$Total_wgt, pch=5, col="green")
?pch
``` 

``` r
no_species <- aggregate(surveys$species, by=list(surveys$date), function(x) length(x))
names(no_species) <- c("Date", "No_species")
``` 

We know that the dates columns are exactly the same for the no_species dataframe and the weights dataframe, so we can just add the Totalwgt column to the species dataframe. If the dates were different we might do a join.

## Scatterplots

Multi-panel plots can be made by changing the graphical parameters with the par() function. 

``` r
no_species$Total_wgt <- weights$Total_wgt

par(mfrow=c(2,1))
plot(no_species$Date, no_species$No_species, ylab="# species", xlab="Date")
plot(no_species$Date, no_species$Total_wgt, ylab="total weight", xlab="Date")
``` 

``` r
par(mfrow=c(1,1))
plot(no_species$No_species, no_species$Total_wgt)
plot(no_species$No_species, no_species$Total_wgt, pch=21, col="black", bg="red")
``` 

* adjust line types, plotting characters, cex, x and y labels
* plot different factors/types in different colors

## Histograms

``` r
hist(no_species$No_species)
hist(log(no_species$No_species))
``` 

## Boxplots

Use a boxplot to compare the number of species seen each year. We'll use another function from the lubridate package, year()

``` r
no_species$Year <- lubridate::year(no_species$Date)
boxplot(no_species$No_species ~ no_species$Year)
``` 

## Saving figures

You can save a plot by opening up a "graphics device" and writing the plot to a specified file. The general syntax is:

```r
pdf(file="myfile.pdf", width=7, height=6, units="in")
plot(x, y)
dev.off()
```

* pdf()
* png()
* postscript()

Additional information
----------------------

* Colorbrewer
* file types for publication
* graphical parameters