### Stats with R Exercise sheet 1 


###############
### Exercise 1: Getting started
###############
## a) Look at your current working directory.
getwd()

## b) Get help with this function.
help(getwd)

## c) Change your working directory to another directory.
setwd("/Users/anweshadas/Desktop/Semester 1")
getwd()

###############
### Exercise 2: Participants' age & boxplots
###############
## In this exercise, we will deal with data from a package.

## a) Install the package "languageR" and load it.
install.packages('languageR')
library(languageR)

## b) Specifically, we will deal with the dataset 'dutchSpeakersDistMeta'. 
##    This dataset should be available to you once you've loaded languageR.
##    The dataset contains information on the speakers included in the Spoken 
##    Dutch Corpus. Inspect 'dutchSpeakersDistMeta'. Look at the head, tail, 
##    and summary. What do head and tail show you?
head(dutchSpeakersDistMeta)
#head shows the the top  6 rows of dataset dutchSpeakersDistMeta along with their variables
tail(dutchSpeakersDistMeta)
#tail shows the the bottom  6 rows of dataset dutchSpeakersDistMeta along with their variables
summary(dutchSpeakersDistMeta)
#summary shows the varying measures of central tendency and variability of each variable

## c) Each line in this file provides information on a single speaker. How many 
##    speakers are included in this dataset? In other words, use a function to 
##    retrieve the number of rows for this dataset.
nrow(dutchSpeakersDistMeta) 
nrow(na.omit(dutchSpeakersDistMeta))

## d) Let's say we're interested in the age of the speakers included in the 
##    corpus, to see whether males and females are distributed equally. 
##    Create a boxplot for Sex and AgeYear.
boxplot(dutchSpeakersDistMeta$AgeYear~dutchSpeakersDistMeta$Sex, varwidth = TRUE, main=toupper("Sex VS AgeYear"))

## e) Does it seem as if either of the two groups has more variability in age?
#Yes, More Variability for females since the extremes are more diverse in comparision to males

## f) Do you see any outliers in either of the two groups?
#Yes, it can be observed that there are outlying points beyond the whiskers for MALES.

## g) Now calculate the mean and standard deviation of the AgeYear per group. 
##    Do this by creating a subset for each group.
##    Do the groups seem to differ much in age?
groupAll <- subset(dutchSpeakersDistMeta, select=c(Sex, AgeYear))
groupFemale <- subset(groupAll, Sex == "female")
groupMale <- subset(groupAll, Sex == "male")
print(result.meanFemale <- mean(groupFemale$AgeYear, na.rm = TRUE))
sd(groupFemale$AgeYear)
print(result.meanMale <- mean(groupMale$AgeYear, na.rm = TRUE))
sd(groupMale$AgeYear)
#There is not a huge difference when comparing the mean age; however it seems there exists significant 
#difference owing to the Standard deviations being high.

## h) What do the whiskers of a boxplot mean?
## The whiskers are the two lines outside the box that extend to the highest and lowest observations 
## 1.5 times the Interquartile Range.Those points which are outside the whiskers are outliers.

## i) What is the inter-quartile range in the boxplot?
## The ends of the box are the upper (75%) and lower quartiles (25%), so the box spans the interquartile range i.e.,
## Q3–Q1 of the dataset. This range is used as a measure of data spread: spanning 50% of a data set 
## and eliminating the influence of outliers 

## j) Is the plot positively or negatively skewed?
## Box plots are negitively skewed because the median lies towards the higher end of the data.


###############
### Exercise 3: Children's stories & dataframes
###############
# A researcher is interested in the way children tell stories. More specifically,
# she wants to know how often children use 'and then'. She asks 25 children to
# tell her a story, and counts the number of times they use 'and then'.
# The data follow:

# 18 15 22 19 18 17 18 20 17 12 16 16 17 21 25 18 20 21 20 20 15 18 17 19 20 


## a) What measurement scale is this data? Is it discrete or continuous? Explain
##    in one sentence why? (remember, comment out written answers)
## Measurement Scale - Ratio; Since 0 - child didn't say "and then" even once; multiplication possible.
## Discrete - since, there can't ever be a 15.6 times uttered between 15 and 16. 

## b) In the next questions (c-e), you will create a dataframe of this data, 
##    which will also include participant IDs.
##    Why is a dataframe better suited to store this data than a matrix?
## We shall be using only one explanatory variable 'child saying and then' to do computation, for which data frame should suffice.
## Matrix would be accounting towards more space complexity in the memory, which is unnecessary. 
## Also, it is possible that participant ID is a alphanumeric value. 


## c) First create a vector with participant IDs. Your vector should be named 
##    'pps', and your participants should be labeled from 1 to 25
pps <- 1:25

## d) Next, create a vector containing all the observations. Name this vector 'obs'.
obs <- c(18, 15, 22, 19, 18, 17, 18, 20, 17, 12, 16, 16, 17, 21, 25, 18, 20, 21, 20, 20, 15, 18, 17, 19, 20)

## e) Create a dataframe for this data. Assign this to 'stories'. 
stories <- data.frame(pps, obs)

## f) Take a look at the summary of your dataframe, and at the classes of your 
##    columns. What class is the variable 'pps'?
summary(stories)
class(pps)
class(obs)
## pps is integer 

## g) Change the class of 'pps' to factor. Why is factor a better class for this
stories$pps=as.factor(stories$pps)
## We need to just store pps and perform any numerical operations on it. Storing it as factor acts as constraint
## which might avoid numerical modifications.

## h) Plot a histogram (using hist()) for these data. Set the number of breaks 
##    to 8.
hist(obs, breaks = 8)


## i) Create a kernel density plot using density().
d<-density(obs)
plot(d)

## j) What  is the difference between a histogram and a kernel density plot?
## Histogram is the data representation of the frequency distribution of numerical data by dumping the data into bins and projecting the data in the form of a bar graph.
#Kernel density plot is used representation of numeric values by using kernel density's estimate to show the probability density function of a given value.
##

## This is a difficult one, remember you just need to provide a serious attempt at solving each 
## exercise in order to pass. 
## k) Overlay the histogram with the kernel density plot 
##    (hint: the area under the curve should be equal for overlaying the graphs 
##    correctly.)
hist(obs, prob=TRUE, col = "yellow")
lines(density(obs), col = "red")
help(lines)

###############
### Exercise 4: Normal distributions
###############
## In this exercise, we will plot normal distributions.

## a) First, use seq() (?seq) to select the x-values to plot the range for
##    (will become the x-axis in the plot).
##    Get R to generate the range from -5 to 5, by 0.1. Assign this to the 
##    variable x.
help(seq)
x <- seq(-5, 5, by = 0.1) 

## b) Now we need to obtain the y-values of the plot (the density). We do this 
##    using the density function for the normal distribution. 
##    Use "help(dnorm)" to find out about the standard functions for the normal 
##    distribution.
help(dnorm)
y <- dnorm(x)

## c) Now use plot() to plot the normal distribution for z values of "x". 
z <- plot(x,y)

## d) The plot now has a relatively short y-range, and it contains circles 
##    instead of a line. 
##    Using plot(), specify the y axis to range from 0 to 0.8, and plot a line 
##    instead of the circles.
z <- plot(x, y, ylim = c(0, 0.8), type = 'l')

## e) We want to have a vertical line to represent the mean of our distribution.
##    'abline()' can do this for us. Look up help for abline(). 
##    Use abline() to create the vertical line. Specify the median of x using
##    the argument 'v'.
##    In order to get a dashed line, set the argument 'lty' to 2.
help(abline)
abline(v = median(x),col="blue",lty = 2)

## f) Take a look at the beaver1 dataset. (You can see it by typing "beaver1".) 
##    Then select only the temperature part and store it in a variable "b1temp".
head(beaver1)
b1temp <- beaver1[,c("temp")]

## g) Calculate the mean and standard deviation of this dataset and plot a normal
##    distribution with these parameters.
mean(b1temp)
sd(b1temp)
b1tempND <- pnorm(b1temp, mean = mean(b1temp), sd = sd(b1temp))
plot(b1temp,b1tempND)

## h) We observe two temparatures (36.91 and 38.13). What's the likelihood that
##    these temperatures (or more extreme ones) respectively come 
##    from the normal distribution from g)?
pnorm(36.91, mean = mean(b1temp), sd = sd(b1temp))
pnorm(38.13, mean = mean(b1temp), sd = sd(b1temp))
## 36.91 can be visible on the g plot, higher likelyhood compared to 38.13 which might lie outside.
## The temperature 38.13 is not likely to come from the normal ditribution of g as it lies outside the range of the other
# tempertures in the data set. 36.91 is more likely to be in normal distrubution of g as it can be clearly located on the plot.

## i) Use the random sampling function in R to generate 20 random samples from
##    the normal distribution from g), and draw a histogram based on this sample.
##    Repeat 5 times. What do you observe?
help(sample)
Sample1 <- sample(b1tempND, 20, replace = FALSE, prob = NULL)
Sample2 <- sample(b1tempND, 20, replace = FALSE, prob = NULL)
Sample3 <- sample(b1tempND, 20, replace = FALSE, prob = NULL)
Sample4 <- sample(b1tempND, 20, replace = FALSE, prob = NULL)
Sample5 <- sample(b1tempND, 20, replace = FALSE, prob = NULL)
h <- c(Sample1,Sample2,Sample3,Sample4,Sample5)
hist(h, breaks =5, labels=TRUE)

## pThe third bin(0.4-0.6) has the highest has the highest frequency.
