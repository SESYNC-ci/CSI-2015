# Goals for understanding:
##############################
# 1. basic types of plots
# 2. changing parameters - color, line type, pch, xlim, ylim
# 3. use factors (or not factors) to show groups in different colors
# 4. multi-panel plots with par(mfrow())
# 5. adding things like text, annotations
##############################

# plot the total weight of animals seen on each survey date

weights <- aggregate(surveys$wgt, by=list(surveys$date), function(x) sum(x, na.rm=TRUE))
str(weights)
names(weights) <- c("Date", "Total_wgt")

plot(weights$Date, weights$Total_wgt)
plot(weights$Date, weights$Total_wgt, type="o")
plot(weights$Date, weights$Total_wgt, type="l")
plot(weights$Date, weights$Total_wgt, type="l", lty=2, col="gray")
points(weights$Date, weights$Total_wgt, pch=5, col="green")
?pch
# note that the plot() function is ploymorphic, ie. uses the input data to determine plot type

no_species <- aggregate(surveys$species, by=list(surveys$date), function(x) length(x))
names(no_species) <- c("Date", "No_species")

# could do a join here if the dates weren't exactly the same. for now just add column
no_species$Total_wgt <- weights$Total_wgt

par(mfrow=c(2,1))
plot(no_species$Date, no_species$No_species, ylab="# species", xlab="Date")
plot(no_species$Date, no_species$Total_wgt, ylab="total weight", xlab="Date")

# Scatterplot

par(mfrow=c(1,1))
plot(no_species$No_species, no_species$Total_wgt)
plot(no_species$No_species, no_species$Total_wgt, pch=21, col="black", bg="red")

# adjust line types, plotting characters, cex, x and y labels

# histogram
hist(no_species$No_species)
hist(log(no_species$No_species))

# boxplot, compare by year
no_species$Year <- lubridate::year(no_species$Date)
boxplot(no_species$No_species ~ no_species$Year)


# if there is time...
# Color by factor
# saving as pdf or png