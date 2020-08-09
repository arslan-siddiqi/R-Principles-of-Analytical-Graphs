
#1: Principles of Analytic Graphs

#So the first principle was to show a comparison. The second principle is to show causality or a mechanism of how your theory of the data works. 
#This explanation or systematic structure shows your causal framework for thinking about the question you're trying to answer.

#Third principle is Multivariate data! What is multivariate data you might ask? In technical (scientific) literature this term means more than 2 variables. 
#Two-variable plots are what you saw in high school algebra.  Remember those x,y plots when you were learning about slopes and intercepts and equations of lines?
#They're valuable, but usually questions are more complicated and require more variables.

#The fourth principle of analytic graphing involves integrating evidence. This means not limiting yourself to one form of expression. 
#You can use words, numbers, images as well as diagrams. Graphics should make use of many modes of data presentation. Remember, "Don't let the tool drive the analysis!"

#The fifth principle of graphing involves describing and documenting the evidence with sources and appropriate labels and scales. 
#Credibility is important so the data graphics should tell a complete story. 
#Also, using R, you want to preserve any code you use to generate your data and graphics so that the research can be replicated if necessary. 
#This allows for easy verification or finding bugs in your analysis.

#The sixth and final principle of analytic graphing is maybe the most important.
#Content is king! If you don't have something interesting to report, your graphs won't save you. 
#Analytical presentations ultimately stand or fall depending on the quality, relevance, and integrity of their content.

##################################

#2: Exploratory Graphs

head(pollution)
dim(pollution)

summary(pollution$pm25)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#3.383   8.549  10.047   9.836  11.356  18.441

quantile(ppm)
boxplot(ppm, col = "blue")
abline(h = 12)

hist(ppm, col = "green")

rug(ppm)
low
high

hist(ppm, col = "green", breaks = 100)
rug(ppm)
hist(ppm, col = "green")
abline(v = median(ppm), lwd = 4, col = "magenta")
#plot2


names(pollution)

reg <- table(pollution$region)
reg
#east west 
#442  134

barplot(reg, col = "wheat", main = "Number of Counties in Each Region")
#plot3

boxplot(pm25~region, data = pollution, col = "red")
#plot4

par(mfrow = c(2, 1), mar = c(4, 4, 2, 1))

east <- subset(pollution, region == "east")
head(east)

hist(east$pm25, col = "green")
#plot5

west <- subset(pollution, region == "west")
head(west)

hist(west$pm25, col = "green")
#or
hist(subset(pollution,region=="west")$pm25, col = "green")
#Rplot06

#Scatter Plots

with(pollution, plot(latitude, pm25))
abline(h = 12, lwd = 2, lty = 2)

plot(pollution$latitude,ppm, col = pollution$region)
abline(h = 12, lwd = 2, lty = 2)


par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))
west <- subset(pollution,region=="west")
plot(west$latitude, west$pm25, main = "West")

east <- subset(pollution,region=="east")
plot(east$latitude, east$pm25, main = "East")


##################################

#Graphics Devices in R

#When plotting to a file device, you have to close the device with the command dev.off(). 
#This is very important! Don't do it yet, though. After closing, you'll be able to view the pdf file on your computer.

#There are two basic types of file devices, vector and bitmap devices. 
#These use different formats and have different characteristics. Vector formats are good for line drawings and plots with solid colors using a modest number of points, while bitmap formats are good for plots with a large number of points, natural scenes or web-based plots.

#The currently active graphics device can be found by calling dev.cur(). 
#Try it now to see what number is assigned to your pdf device.


##################################

#Plotting Systems in R

#Base Plotting System

#The first plotting system is the Base Plotting System which comes with R. 
#It's the oldest system which uses a simple "Artist's palette" model. 
#What this means is that you start with a blank canvas and build your plot up from there, step by step.

#Usually you start with a plot function (or something similar), then you use annotation functions to add to or modify your plot. 
#R provides many annotating functions such as text, lines, points, and axis. 
#R provides documentation for each of these. They all add to an already existing plot.

#The base system is very intuitive and easy to use when you're starting to do exploratory graphing and looking for a research direction. 
#You can't go backwards, though, say, if you need to readjust margins or fix a misspelled a caption. 
#A finished plot will be a series of R commands, so it's difficult to translate a finished plot into a different system.

head(cars)
#speed dist
#1     4    2
#2     4   10
#3     7    4
#4     7   22
#5     8   16
#6     9   10

text(mean(cars$speed),max(cars$dist),"SWIRL rules!")


#Lattice System

#The Lattice System which comes in the package of the same name. Unlike the Base System, lattice plots are created with a single function call such as xyplot or bwplot. 
#Margins and spacing are set automatically because the entire plot is specified at once.

#The lattice system is most useful for conditioning types of plots which display how y changes with x across levels of z. 
#The variable z might be a categorical variable of your data. This system is also good for putting many plots on a screen at once.

#The lattice system has several disadvantages. 
#First, it is sometimes awkward to specify an entire plot in a single function call. 
#Annotating a plot may not be especially intuitive. 
#Second, using panel functions and subscripts is somewhat difficult and requires preparation. 
#Finally, you cannot "add" to the plot once it is created as you can with the base system.

head(state)
#Population Income Illiteracy Life.Exp Murder HS.Grad Frost   Area region
#Alabama          3615   3624        2.1    69.05   15.1    41.3    20  50708  South
#Alaska            365   6315        1.5    69.31   11.3    66.7   152 566432   West
#Arizona          2212   4530        1.8    70.55    7.8    58.1    15 113417   West
#Arkansas         2110   3378        1.9    70.66   10.1    39.9    65  51945  South
#California      21198   5114        1.1    71.71   10.3    62.6    20 156361   West
#Colorado         2541   4884        0.7    72.06    6.8    63.9   166 103766   West

table(state$region)
#Northeast         South North Central          West 
#        9            16            12            13 

#So there are 4 categories and the 50 states are sorted into them appropriately.
#Let's use the lattice command xyplot to see how life expectancy varies with income in each of the four regions.

#To do this we'll give xyplot 3 arguments. The first is the most complicated. 
#It is this R formula, Life.Exp ~ Income | region, which indicates we're plotting life expectancy as it depends on income for each region. 
#The second argument, data, is set equal to state. 
#This allows us to use "Life.Exp" and "Income" in the formula instead of specifying the dataset state for each term (as in state$Income). 
#The third argument, layout, is set equal to the two-long vector c(4,1). Run xyplot now with these three arguments.

xyplot(Life.Exp ~ Income | region, data = state, layout = c(4,1))
#Rplot05

xyplot(Life.Exp ~ Income | region, data = state, layout = c(2, 2))
#Rplot07

# ggplot2 System
head(mpg)
# A tibble: 6 x 11
#manufacturer model displ  year   cyl trans      drv     cty   hwy fl    class  
#<chr>        <chr> <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>  
#1 audi         a4      1.8  1999     4 auto(l5)   f        18    29 p     compact
#2 audi         a4      1.8  1999     4 manual(m5) f        21    29 p     compact
#3 audi         a4      2    2008     4 manual(m6) f        20    31 p     compact
#4 audi         a4      2    2008     4 auto(av)   f        21    30 p     compact
#5 audi         a4      2.8  1999     6 auto(l5)   f        16    26 p     compact
#6 audi         a4      2.8  1999     6 manual(m5) f        18    26 p     compact

dim(mpg)
#[1] 234  11

mpg$model
table(mpg$model)

qplot(displ, hwy, data = mpg)
#Rplot08

