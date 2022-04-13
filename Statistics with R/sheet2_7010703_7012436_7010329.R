###############
### Cleaning Data - Exercise 1
###############

##Aashita Balan; 7012436; aael00001@stud.uni-Saarland.de

##Anwesha Das; 7010703; anda00002@stud.uni-saarland.de

##Janani Karthikeyan, 7010329, jaka00004@stud.uni-saarland.de

# 1. Download the data file "digsym.csv" from the moodle and save it in your working directory. 
setwd("/Users/anweshadas/Desktop/Semester 1/Stats with R")

# 2. Read in the data into a variable called "dat".
dat <- read.csv("digsym.csv")

# 3. Load the libraries languageR, stringr, dplyr and tidyr.
library(languageR)
library(stringr)
library(dplyr)
library(tidyr)

# 4. How many rows, how many columns does that data have?
nrow(dat) ## Rows: 3,700
ncol(dat) ## Columns: 11

# 5. Take a look at the structure of the data frame using "glimpse".
glimpse(dat)

# 6. View the first 20 rows, view the last 20 rows.
head(dat, n=20)
tail(dat, n=20)
# 7. Is there any missing data in any of the columns?
sum(is.na(dat))
## 370 missing data observed

# 8. Get rid of the row number column.
dat <- dat[-1]

# 9. Put the Sub_Age column second.
dat <- dat[c(1,10,2,3,4,5,6,7,8,9)]

# 10. Replace the values of the "ExperimentName" column with something shorter, more legible.
dat$ExperimentName <- str_replace(dat$ExperimentName,"Digit Symbol - Kopie","DSK")

# 11. Keep only experimental trials (encoded as "Trial:2" in List), get rid of practice trials 
# (encoded as "Trial:1"). When you do this, assign the subset of the data to a variable "data2", 
# then assign data2 to dat and finally remove data2.
data2 <- subset(dat, List == "Trial:2")
dat <- data2
remove(data2)
summary(dat)
##### 12. Separate Sub_Age column to two columns, "Subject" and "Age", using the function "separate".
help(seperate)
dat <- separate(dat,col=Sub_Age,into = c("Subject","Age"),sep=" _ ")

# 13. Make subject a factor.
dat$Subject <- as.factor(dat$Subject)

# 14. Extract experimental condition ("right" vs. "wrong") from the "File" column:
# i.e. we want to get rid of digit underscore before and the digit after the "right" and "wrong".
dat$File <- c(gsub("\\d_*","",dat$File))

# 15. Using str_pad to make values in the File column 8 chars long, by putting 0 at the end  (i.e., 
# same number of characters, such that "1_right" should be replaced by "1_right0" etc).
dat$File <- str_pad(dat$File, width=8, side="right", pad="0")

# 16. Remove the column "List".
select(dat, -List)

# 17. Change the data type of "Age" to integer.
dat$Age <- as.integer(dat$Age)
typeof(dat$Age)

# 18. Missing values, outliers:
# Do we have any NAs in the data, and if so, how many and where are they?
sum(is.na(dat))
## There are no missing values in the data

# 19. Create an "accuracy" column using ifelse-statement.
# If actual response (StimulDS1.RESP) is the same as the correct response (StimulDS1.CRESP), put 
# in value 1, otherwise put 0.
dat<-dat%>%
mutate(accuracy=ifelse(StimulDS1.RESP==StimulDS1.CRESP,1,0))
dat
# 20. How many wrong answers do we have in total?
w <- count(filter(dat, accuracy == 0))
w
# there are 185 wrong answers

# 21. What's the percentage of wrong responses?
perc <- (w/(nrow(dat)-1))*100
perc
# 5.557224 % wrong answers
# nrow(dat) includes the row of column names as well, hence while calculation of the percentage, 
#we have subtracted 1 from the total number of rows.

# 22. Create a subset "correctResponses" that only contains those data points where subjects 
# responded correctly. 
correctResponses <- filter(dat, accuracy == 1)
correctResponses

# 23. Create a boxplot of StimulDS1.RT - any outliers?
boxplot(dat$StimulDS1.RT)
# Yes, there are many outliers

# 24. Create a histogram of StimulDS1.RT with bins set to 50.
hist(dat$StimulDS1.RT, breaks=50)

# 25. Describe the two plots - any tails? any suspiciously large values?
#hist(dat$StimulDS1.RT, breaks=50000)
## The plots are positively skewed, with suspiciously large values at 14000 and possibly 8000
## Histogram has a Tail - Right. 

# 26. View summary of correct_RT.
summary(correctResponses)

# 27. There is a single very far outlier. Remove it and save the result in a new dataframe named 
# "cleaned".
outliers <- boxplot(correctResponses$StimulDS1.RT, plot = FALSE)$out
max(outliers)
cleaned <- correctResponses %>%
  filter(correctResponses$StimulDS1.RT != max(outliers))
## Removed the single very far outlier which is captured in max(outliers) and saved the result in the new dataframe "cleaned".

###############
### Exercise 2: Deriving sampling distributions
###############
## In this exercise, we're going to derive sampling distributions with 
## different sizes.

## a) Load the package languageR. We're going to work with the dataset 'dative'. 
## Look at the help and summary for this dataset.
library(languageR)
library(dplyr)
?dative
summary(dative)

## The term dative alternation is used to refer to the alternation between 
## a prepositional indirect-object construction
## (The girl gave milk (NP) to the cat (PP)) and a double-object construction 
## (The girl gave the cat (NP) milk (NP)).
## The variable 'LenghtOfTheme' codes the number of words comprising the theme.

## b) Create a contingency table of 'LenghtOfTheme' using table(). 
##    What does this table show you?
table(dative$LengthOfTheme)
#The contingency table for "LengthOfTheme" shows the frequency distribution of the number of words comprising a theme.

## c) Look at the distribution of 'LenghtOfTheme' by plotting a histogram and a boxplot. 
##    Do there appear to be outliers? Is the data skewed?
hist(dative$LengthOfTheme)
boxplot(dative$LengthOfTheme)
#As we can see from the boxplot, there are a few outliers in the data.
#As we can see from the histogram, the data is positively skewed

## d) Now we're going to derive sampling distributions of means for different 
##    sample sizes. 
##    What's the difference between a distribution and a sampling distribution?
# Distribution is the frequency distribution of values of one sample of a population
# Sampling Distribution is the distribution of a statistic(Mean, Median or likewise) of 
#several different samples of a population

## e) We are going to need a random sample of the variable 'LengthOfTheme'. 
##    First create a random sample of 5 numbers using sample(). 
##    Assign the outcome to 'randomsampleoflengths'
randomsampleoflengths <- sample(dative$LengthOfTheme, 5)

## f) Do this again, but assign the outcome to 'randomsampleoflengths2'. 
randomsampleoflengths2 <- sample(dative$LengthOfTheme, 5)

## g) Now calculate the mean of both vectors, and combine these means 
##    into another vector called 'means5'.
means5 <- c(mean(randomsampleoflengths),mean(randomsampleoflengths2))

## h) In order to draw a distribution of such a sample, we want means of 
##    1000 samples. However, we don't want to repeat question e and f 
##    1000 times. We can do this in an easier way: 
##    by using a for-loop. See dataCamp or the course books for 
##    how to write loops in R.
for (i in 1:1000) {
  means5_new <- append(means5,mean(sample(dative$LengthOfTheme, 5)))
}


## i) Repeat the for-loop in question h, but use a sample size of 50. 
##    Assign this to 'means50' instead of 'means5'.
for (i in 1:1000) {
  means50 <- append(means50,mean(sample(dative$LengthOfTheme, 50)))
}

## j) Explain in your own words what 'means5' and 'means50' now contain. 
##    How do they differ?
#means5: means5 now contains the distribution of the mean or the sampling distribution (in this case the statistical 
#function is mean) from 1000 different samples of a population, each of size 5.
#means50: means50 now contains the distribution of the mean or the sampling distribution from 1000 different samples 
#of a population, each of size 50.
#The higher the sample size, the more precise the statistical function would be. 
#Hence the mean of means5 vector is higher than the mean of means50 vector.

## k) Look at the histograms for means5 and means50. Set the number of breaks to 15.
##    Does means5 have a positive or negative skew?
hist(means5_new, breaks = 15)
hist(means50, breaks = 15)
#As we can see in the histogram plot obtained, means5 has a positive skew. 
#means50 doesn't appear to be skewed, the values are more like they're normally distributed.

## l) What causes this skew? In other words, why does means5 have bigger 
##    maximum numbers than means50?
# The skew in the means5 sampling distribution is caused, because the sample is of a smaller size compared to the 
#sample size of means50. When the sample size is large, it is more representative of a population 
#rather than a smaller sample size. Hence, the sample distribution of the mean values of smaller sample size 
#tend to have extreme values causing the skew. 

###############
### Exercise 3: Confidence interval
###############

## A confidence interval is a range of values that is likely to contain an 
## unknown population parameter.
## The population parameter is what we're trying to find out. 
## Navarro discusses this in more depth in chapter 10.

## a) What does a confidence interval mean from the perspective of experiment replication?
#The confidence interval tells us how stable the estimate is. 
#With respect to experiment replication, if the confidence interval is narrow, 
#that means that the replication will succeed. 

## b) Let's calculate the confidence interval for our means from the previous 
##    exercise.
##    First, install and load the packages 'lsr' and 'sciplot'
#install.packages("lsr")
#install.packages("sciplot")
library(lsr)
library(sciplot)

## c) Look at the description of the function ciMean to see which arguments it takes.
?ciMean

## d) Use ciMean to calculate the confidence interval of the dataset dative from
##    the previous exercise.
##    Also calculate the mean for the variable LengthOfTheme.
ciMean(dative)
mean(dative$LengthOfTheme)

## e) Does the mean of the sample fall within the obtained interval? 
##    What does this mean?
#Yes, the mean of the variable LengthofTheme fall within the confidence Interval. 
#This means that the possibility of a value in the field "LengthOfTheme" occurring by chance is less than 5%, 
#so we can reject the Null Hypothesis.

## f) As the description of dative mentions, the dataset describes the 
##    realization of the dative as NP or PP in two corpora.
##    The dative case is a grammatical case used in some languages 
##    (like German) to indicate the noun to which something is given.
##    This dataset shows us, among other things, how often the theme is 
##    animate (AnimacyOfTheme) and how long the theme is (LengthOfTheme).
##    Plot this using the function bargraph.CI(). Look at the help for this function. 
##    Use the arguments 'x.factor' and 'response'.
?bargraph.CI()
bargraph.CI(x.factor = dative$AnimacyOfTheme, response = dative$LengthOfTheme)

## g) Expand the plot from question f with the ci.fun argument 
##    (this argument takes 'ciMean'). 
##    Why does the ci differ in this new plot compared to the previous plot?
bargraph.CI(x.factor = dative$AnimacyOfTheme, response = dative$LengthOfTheme, ci.fun = function(x) {ciMean(x)})
#The CI differ in the new plot, because in the second barchart, Confidence Interval is plotted based on the 
#CI Mean of the values of the fields specified.