### Stats with R Exercise sheet 4

##########################
#Week 5: t-test and friends
##########################


### Stats with R Exercise sheet 4 
## Aashita Balan; 7012436; aael00001@stud.uni-Saarland.de

## Anwesha Das; 7010703; anda00002@stud.uni-saarland.de

## Janani Karthikeyan, 7010329, jaka00004@stud.uni-saarland.de

###########################################################################################
###########################################################################################
###############
### Cleaning Data
###############
install.packages("effsize")
library(lsr)
library(tidyr)
library(effsize)
library(ggplot2)

# 1. Download the data file "digsym_clean.csv" from the moodle and save it in your 
# working directory. 
setwd("/Users/jananikarthikeyan/Documents/DSAI/Stats with R/Assignments/Assignment 5/")

# 2. Read in the data into a variable called "data".
data <- read.csv("digsym_clean.csv")

# 3. Get rid of the column "X"
data <- subset(data, select = -c(X))
View(data)
# Say you're interested in whether people respond with different accuracy to 
# right vs. wrong picture-symbol combinations.
# In other words, you want to compare the average accuracy for the digsym-right 
# and digsym-wrong condition.
# Like the conscientious researcher you are, you want to take a look at the data 
# before you get into the stats.
# Therefore, you will need to create a barplot of the mean accuracy data 
# (split out by condition) using ggplot and the summarySE function (given below).
# Let's do it step by step.
#install.packages("doBy")

summarySE <- function(data=NULL, measurevar, groupvars=NULL, na.rm=FALSE, conf.interval=.95) {
  # data: an input dataframe
  # measurevar: a column name of <data> (as string), on which we would like to calculate 
  #             standard deviation (SD), standard error (SE) and confidence interval (CI).
  # groupvars: categorical columns of <data> (as vector of strings ) which we would like to use
  #            to make all possible combinations for which we calculate SD, SE, CI based 
  #            on <measurevar>.
  # na.rm: should we remove NA
  # conf.interval: confidence interval
  library(doBy)
  
  length2 <- function (x, na.rm=FALSE) {
    if (na.rm) sum(!is.na(x))
    else       length(x)
  }
  
  # Collapse the data
  formula <- as.formula(paste(measurevar, paste(groupvars, collapse=" + "), sep=" ~ "))
  datac <- summaryBy(formula, data=data, FUN=c(length2,mean,sd), na.rm=na.rm)
  
  # Rename columns
  names(datac)[ names(datac) == paste(measurevar, ".mean",    sep="") ] <- measurevar
  names(datac)[ names(datac) == paste(measurevar, ".sd",      sep="") ] <- "sd"
  names(datac)[ names(datac) == paste(measurevar, ".length2", sep="") ] <- "N"
  
  # Calculate standard error of the mean
  datac$se <- datac$sd / sqrt(datac$N)  
  
  # Confidence interval multiplier for standard error
  # Calculate t-statistic for confidence interval: 
  # e.g., if conf.interval is .95, use .975 (above/below), and use df=N-1
  ciMult <- qt(conf.interval/2 + .5, datac$N-1)
  datac$ci <- datac$se * ciMult
  
  return(datac)
}

# 4. Apply the function summarySE on the accuracy data grouping by right/wrong condition
# (use the provided documentation inside the function above for the arguments description).
data_stat <- summarySE(data, measurevar = "accuracy", groupvars = "condition")
data_stat
# 5. Create the barplot (use ggplot2 for this and all tasks below) with error bars 
# (which the function summarySE readily provided).
# Gauging from the plot, does it look like there's a huge difference in accuracy 
# for responses to the right and wrong condition?
ggplot(data_stat, aes(x = condition, y = se,fill = condition))+
  geom_bar(stat = "identity")+
  geom_errorbar(aes(ymin = min(data_stat$se), ymax = max(data_stat$se)))
#There is a considerable difference for the responses between right and wrong condition.

# 6. Let's go back to our data frame "data", which is still loaded in your console
# Now that you've taken a look at the data, you want to get into the stats.
# You want to compute a t-test for the average accuracy data in the right and 
# wrong condition.
# Why can't you compute a t-test on the data as they are now? 
# Hint: Which assumption is violated?
# Among the t-test assumptions 

##Normal Distribution assumption is violated as data$accuracy is negatively skewed.
##Variance of data accuracy - Homogeneity of Variance is violated.
##hist(data$accuracy)

# 7. We need to reshape the data to only one observation (average accuracy) per subject 
# and right/wrong condition. Here we will use cast() which we discussed in the tutorial
# for sheet 2. 
# Collapse the data, 
# using cast(data, var1 + var2 + var3 ... ~, function, value = var4, na.rm = T).
# Store the result in a new variable called "cdata". 
## Check ?cast or https://www.statmethods.net/management/reshape.html for more infos on 
## cast(). 
install.packages("reshape2")
library(reshape2)
cdata <- dcast(data, Subject ~ condition, mean, value.var = "accuracy")
cdata

# 8. Create histograms of the accuracy data depending on the right and wrong 
# condition and display them side by side.
ggplot(data, aes(x=accuracy, fill=condition))+ geom_bar(position = "dodge")

# 9. Display the same data in density plots. 
ggplot(data, aes(x=accuracy, fill = condition))+geom_density()

# 10. Based on the histograms and the density plots - are these data normally 
# distibuted?
# No the data is not normally distributed, the data is egatively skewed.

# 11. Create boxplots of the accuracy data.
ggplot(cdata, aes(x = Subject , y=cdata$`(all)`))+
  geom_boxplot() 
#ggboxplot(cdata, aes(x = Subject, y = cdata$`(all`))

# 12. Compute the t-test to compare the mean accuracy between wrong and right picture
# combinations.
# Do you need a paired t-test or independent sample t-test? why?
t.test(cdata$right, cdata$wrong, paired = TRUE)
##We need paired t-test because, based on the data, the experiment was conducted on the same group of people.

# 13. What does the output tell you? What conclusions do you draw?
# The output of the t-test tells us the confidence interval, hypothesis condition of the data that is provided. 
#From the output we can see that the confidence interval of teh data is between 0.01 and 0.04. The p-value we got is 0.005 which 
#does not fall in the confidence interval range. Hence the null hypothesis (true difference in means is equal to zero)  is true.

# 14. Compute the effect size using CohensD.
cohensD(accuracy ~ condition, data)

# 15. Which effect size do we get? How do you interpret this result?
# We got the effect size as 0.1234318. According to CohensD evaluation, the effect size we got is considered a "small effect size"

# 16. In addition to the long-format data we've just been working on, you may also 
# encounter data sets in a wide format (this is the format we have been using in 
# class examples.)
# Let's do a transformation of our data set (cdata) to see what it would look like in a wide 
# format.
# Use spread() from the tidyr package.
spread1 <- spread(cdata, Subject, right)
spread2 <- spread(cdata, Subject, wrong)

# 17. Compute the t-test again on the wide format data - note that for wide-format 
# data you need to use a different annotation for the t-test.
t.test(spread1, spread2, paired = FALSE)
#We have used th annotation "paired=FALSE" (Welch two sample t-test) because the format of the data is not numeric or logical, so we cannot used paired t-test

# 18. Compare the t-test results from the wide-format and the long-format data. 
# What do you notice?
# Comparing the t-tests, in Welch two sample t-test, we notice that the confidence interval range is narrower than paired t-test, degrees of freedom is higher than paired t-test, and p-value is higher than paired t-test

# 19. Compute CohensD on the wide format data. What do you notice?
cohensD(spread1$wrong, spread2$right)
#CohensD effect size for the wide-format data is higher than the CohensD effect size of the long-format data

# 20. Let's try the t-test again, but for a different question:
# Suppose you are interested in whether reaction times in the digit symbol 
# task differ depending on gender.
# In other words, you want to test whether or not men perform significantly 
# faster on average than women, or vice versa.
# Collapse the original data, using 
# cast(data, var1 + var2 + var3 ... ~ ., function, value = var4, na.rm = T).
# Store the result in a new variable called "cdat"
cdat <- dcast(data, accuracy ~ Subject + Gender, mean,na.rm = TRUE, nan.rm = TRUE)
cdat
# 21. Take a look at cdat using head().
head(cdat)

# 22. Compute the t-test to compare the accuracy means of female and male 
# participants.
# Which t-test do you need and why? How do you interpret the result?
t.test(cdat$accuracy, cdat$`(all)`, paired = FALSE)
#We need one sample t-test. 

###############
### T-Test
###############
#In this exercise we will try to explore the independent samples t-test 
#and its affect on different samples. 
#We will take the same example discussed in the lecture. A class has two tutors, and we want to find out which tutor is better by
#comparing the performance of the students in the final exam by tutor group. 

#1. Generate 10 samples from a normal distribution with mean 0 and sd 10 and save it a variable names "first_tutor_grades"
first_tutor_grades <- rnorm(10, 0, 10)

#2. Create a vector named "first_tutor" having same 10 values -> "tutor1"
first_tutor <- rep(c("tutor1"),10)

#3. Create a data frame named "data_frame" having 2 columns "first_tutor", "first_tutor_grades" created above.
data_frame <- data.frame(first_tutor, first_tutor_grades)

#4. Change the column names of the data frame to "tutor" and "score"
colnames(data_frame) <- c("tutor", "score")

#5. repeat the steps 1-4 with the following changes:
  #i) generate another 10 samples with mean 10 and sd 25. save it in a variable: second_tutor_grades
  #ii)Create a vector named "second_tutor" having 10 same values -> "tutor2"
  #iii) Create a data frame named "data_frame2" having 2 columns "second_tutor", "second_tutor_grades" created above.
  #iv) Change the column names of the data frame to "tutor" and "score"
second_tutor_grades <- rnorm(10, 10, 25) 
second_tutor <- rep(c("tutor2"),10)
data_frame2 <- data.frame(second_tutor, second_tutor_grades)
colnames(data_frame2) <- c("tutor", "score")
data_frame2
#6. combine both data frames into a new one and name it "final_df"
# final_df should have 2 columns (tutor, score) having 20 rows. e.g.
#   tutor      score
#1  tutor1     9.09
#2  tutor1     4.66
#3  tutor1     3.56
#4  tutor2     1.56
#5  tutor2     545

final_df <- rbind(data_frame, data_frame2)
final_df

#7. run the independent samples TTest (independentSamplesTTest) and formulate the findings as discussed in the lecture. 
#	What do you observe? 
#	independentSamplesTTest also provides thes effect size (Cohen's d). How do you interpret the effect size?
?independentSamplesTTest
final_df$tutor <- as.factor(final_df$tutor)
independentSamplesTTest(score~tutor, data = final_df, var.equal=FALSE, 
                        one.sided=FALSE, conf.level=.95 )
cohensD(score~tutor, data = final_df)
## Effect size of 0.302 is a small. 

#8. Time to play around!
#	repeat the whole experiment you performed above with different sample size, mean and standard deviation  
#	repeat it 3 times changing all the values (sample size, mean, sd) and formulate the findings.  
#	what do you observe when we keep the means and sd same?

third_tutor_grades <- rnorm(100, 1, 1) 
third_tutor <- rep(c("tutor3"),100)
data_frame3 <- data.frame(third_tutor, third_tutor_grades)
colnames(data_frame3) <- c("tutor", "score")

fourth_tutor_grades <- rnorm(100, 5, 15) 
fourth_tutor <- rep(c("tutor4"),100)
data_frame4 <- data.frame(fourth_tutor, fourth_tutor_grades)
colnames(data_frame4) <- c("tutor", "score")

add_frame <- rbind(data_frame3, data_frame4)
add_frame$tutor <- as.factor(add_frame$tutor)
independentSamplesTTest(score~tutor, data = add_frame, var.equal=FALSE, 
                        one.sided=FALSE, conf.level=.95)

## trial 2
third_tutor_grades <- rnorm(1000, 1, 1) 
third_tutor <- rep(c("tutor3"),1000)
data_frame3 <- data.frame(third_tutor, third_tutor_grades)
colnames(data_frame3) <- c("tutor", "score")

fourth_tutor_grades <- rnorm(1000, 2, 2) 
fourth_tutor <- rep(c("tutor4"),1000)
data_frame4 <- data.frame(fourth_tutor, fourth_tutor_grades)
colnames(data_frame4) <- c("tutor", "score")

add_frame <- rbind(data_frame3, data_frame4)
add_frame$tutor <- as.factor(add_frame$tutor)
independentSamplesTTest(score~tutor, data = add_frame, var.equal=FALSE, 
                        one.sided=FALSE, conf.level=.95)


## trial 3
third_tutor_grades <- rnorm(100, 1, 1) 
third_tutor <- rep(c("tutor3"),100)
data_frame3 <- data.frame(third_tutor, third_tutor_grades)
colnames(data_frame3) <- c("tutor", "score")

fourth_tutor_grades <- rnorm(100, 10, 10) 
fourth_tutor <- rep(c("tutor4"),100)
data_frame4 <- data.frame(fourth_tutor, fourth_tutor_grades)
colnames(data_frame4) <- c("tutor", "score")

add_frame <- rbind(data_frame3, data_frame4)
add_frame$tutor <- as.factor(add_frame$tutor)
independentSamplesTTest(score~tutor, data = add_frame, var.equal=FALSE, 
                        one.sided=FALSE, conf.level=.95)

## degrees of freedom:  99.201 
## p-value:  <.001 
## negligible
