#### clear the workspace
rm(list = ls())
##### Print working directory, then change the working directory
getwd()
setwd("/Users/danny/Documents/teaching/undergrad methods/spring 25")
# Example for Windows
#setwd("C:\\Users\\danny\\Documents\\teaching\\undergrad methods\\spring 25")
##### read in the data using read.csv function
the.data <- read.csv(file = "4000_lab1_data.csv") # the.data "gets" read.csv...

##### examine the data using some different functions
names(the.data) # variable names
dim(the.data) # number of cases and variables
head(the.data) # first 6 cases
tail(the.data) # last 6 cases
## The summary function is very useful. Minimum, maximum, median, mean, first and third quartiles for every variable
summary(the.data)

##### referring to a variable using the $
summary(e_gdppc) ### won't work
summary(the.data$e_gdppc) ### works
mean(the.data$e_gdppc) ### works, but not the way we want it to
mean(the.data$e_gdppc, na.rm = T)

##### Two plots for continuous variables
## Histogram of GDP per capita
hist(the.data$e_gdppc)
hist(the.data$e_gdppc, xlab= "GDP per Capita (thousands)", main="Histogram of GDP per Capita")
##  Histogram w/ axis labels, title, lines for the mean and median, and a box
hist(the.data$e_gdppc, xlab= "GDP per Capita", main = "Histogram of GDP per Capita", axes=F)
axis(1, at = seq(0, 150, by = 50), labels = c("0", "50k", "100k", "150k"))
axis(2)
abline(v = mean(the.data$e_gdppc, na.rm = T), col = "red", lwd = 2)
abline(v = median(the.data$e_gdppc, na.rm = T), col = "red", lwd = 2, lty = 2)
legend("topright", legend = c("Mean", "Median"), lty = c(1, 2), lwd = 2, col = "red")
box()

## Box plot of GDP per capita w/ title
boxplot(the.data$e_gdppc, main="Box plot of GDP per Capita")
## Grouped box plot of GDP per capita, by democracy
boxplot(the.data$e_gdppc ~ the.data$conflict_01)
boxplot(e_gdppc ~ conflicts, data = the.data)
boxplot(sqrt(e_gdppc) ~ conflicts, data = the.data)

##### Examining and plotting a discrete variable
## UCDP conflict count
summary(the.data$conflict_01)
## Frequency table
table(the.data$conflict_01)
## Add a label
table(the.data$conflict_01 , dnn = "Ongoing conflicts")

## Create object with table function
conf.table <- table(the.data$conflict_01, dnn = "UCDP conflicts")
## Print the table object
conf.table
## Histogram
hist(the.data$conflict_01)
## Barplot
barplot(conf.table)
## Proportion table 
prop.table(conf.table)
## Assign that table to an object
conf.props <- prop.table(conf.table)
## Barplot for torture using proportion table
barplot(conf.props)
### two way table
conf.war.table <- table(the.data$conflict_01, the.data$war_01)
conf.war.table

##### Measures of spread/dispersion
## the range
range(the.data$e_gdppc, na.rm = T) # not actually the range. minimum/maximum values
## the variance
var(the.data$e_gdppc, na.rm = T)
## the standard deviation	
sd(the.data$e_gdppc, na.rm = T)

##### Using subset function
## Create new data frame with only the richest countries
## First, what is 99th percentile for gdp per capita? 
quantile(the.data$e_gdppc , 0.99, na.rm = T)
rich.countries <- subset(the.data , subset = e_gdppc > 62.62314)
## print the object
rich.countries
## if you want to be more exact, save quantile as object first
rich <- quantile(the.data$e_gdppc , 0.99, na.rm = T)
rich
rich.countries <- subset(the.data, subset = e_gdppc > rich)

## Indexing
# new data frame with just a few variables
gdppc.data <- subset(the.data, select = c("country_name", "year", "e_gdppc", "conflict_01"))
# remove cases with missing values
gdppc.data <- na.omit(gdppc.data)
# see first row
gdppc.data[1 , ]
# see first column
gdppc.data[ , 1]
# first row, first column
gdppc.data[1 , 1]
# first row, first two columns
gdppc.data[1 , 1:2]
# first three rows, first two columns
gdppc.data[1:3 , 1:2]
# country-years with an active conflict
gdppc.data[gdppc.data$conflict_01 == 1 , ]
# country-years with an active conflict, just country and year
gdppc.data[gdppc.data$conflict_01 == 1 , 1:2]
# use indexing to subset the data based on GDP per capita
rich.countries <- gdppc.data[gdppc.data$e_gdppc > rich , ]
rich.countries <- rich.countries[ , c("country_name", "year", "e_gdppc")]
# order function returns row numbers ordered by variable values
order(rich.countries$e_gdppc)
rich.countries[order(rich.countries$e_gdppc) , ]
## write to a new data file, csv format
write.csv(rich.countries, file = "rich_countries.csv", row.names = F)