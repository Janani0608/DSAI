### Stats with R Exercise sheet 3

##########################
#Tests for Categorical Data
##########################

## This exercise sheet contains the exercises that you will need to complete and 
## submit by 23:55 on Monday, November 30th. Write the code below the questions. 
## If you need to provide a written answer, comment this out using a hashtag (#). 
## Submit your homework via moodle.


## Please write below your (and your teammates) name, matriculation number. 
## Name:
## Matriculation number:
##Name: Aashita Balan; Matriculation number: 7012436; email id:aael00001@stud.uni-Saarland.de

##Name: Anwesha Das; Matriculation number: 7010703; email id: anda00002@stud.uni-saarland.de

##Name: Janani Karthikeyan, Matriculation number: 7010329, email id: jaka00004@stud.uni-saarland.de

## Change the name of the file by adding your matriculation numbers
## (exercise0N_firstID_secondID_thirdID.R)

## Only 1 member needs to submit! 

## It is better if you do the datacamp exercise first on ggplot! It will help you in the assignment. 

#################################################################################
#################################################################################


###############
### Exercise 1: Plotting graphs using ggplot.
###############
# There are many ways of making graphs in R, and each has their own advantages 
# and disadvantages. One popular package for making plots is ggplot2. 
# The graphs produced with ggplot2 look professional and the code is quite easy 
# to manipulate.
# In this exercise, we'll plot a few graphs with ggplot2 to show its functionalities.
# You'll find all the information you'll need about plotting with ggplot2 here: 
# http://www.cookbook-r.com/Graphs/


# Also, you have been assigned the ggplot2 course in DataCamp. Please work through 
# this course first to easily solve the assignment below

## a) First install and load the ggplot2 package. Look at the help for ggplot.
#install.packages("ggplot2")
library(ggplot2)
?ggplot

## b) We're going to be plotting data from the dataframe 'ratings' 
##    (included in languageR). 
##    Look at the description of the dataset and the summary.
str(ratings)
summary(ratings)

## For each word, we have three ratings (averaged over subjects), one for the 
## weight of the word's referent, one for its size, and one for the words' 
## subjective familiarity. Class is a factor specifying whether the word's 
## referent is an animal or a plant. 
## Furthermore, we have variables specifying various linguistic properties, 
## such as word's frequency, its length in letters, the number of synsets 
## (synonym sets) in which it is listed in WordNet [Miller, 1990], its 
## morphological family size (the number of complex words in which 
## the word occurs as a constituent), and its derivational entropy (an 
## information theoretic variant of the family size measure). 
## Don't worry, you don't have to know what all this means yet in order to 
## be able to plot it in this exercise!

## c) Let's look at the relationship between the class of words and the length. 
##    In order to plot this, we need a dataframe with the means.
##    Below you'll find the code to create a new dataframe based on the existing 
##    dataset ratings.
##    Plot a barplot of ratings.2 using ggplot. Map the two classes to two 
##    different colours. 
##    Remove the legend.
summary(ratings)
condition <- c("animal", "plant")
frequency <- c(mean(subset(ratings, Class == "animal")$Frequency), mean(subset(ratings, Class == "plant")$Frequency))
length <- c(mean(subset(ratings, Class == "animal")$Length), mean(subset(ratings, Class == "plant")$Length))
ratings.2 <- data.frame(condition, frequency, length)
ratings.2
#Plotting the data by assigning two different colours to the classes "animals" and "plants"
ggplot(ratings.2, aes(condition, fill = frequency))+ 
  geom_col(aes(y = frequency), show.legend=FALSE) 


## d) Let's assume that we have additional data on the ratings of words. 
##    This data divides the conditions up into exotic and common animals 
##    and plants.
##    Below you'll find the code to update the dataframe with this additional data.
##    Draw a line graph with multiple lines to show the relationship between 
##    the frequency of the animals and plants and their occurrence.
##    Map occurrence to different point shapes and increase the size 
##    of these point shapes.
condition <- c("animal", "plant")
frequency <- c(7.4328978, 3.5864538)
length <- c(5.15678625, 7.81536584)
ratings.add <- data.frame(condition, frequency, length)
ratings.3 <- rbind(ratings.2, ratings.add)
occurrence <- c("common", "common", "exotic", "exotic")
ratings.3 <- cbind(ratings.3, occurrence)
ratings.3
ggplot(data=ratings.3, aes(x=frequency,y=occurrence, group=condition,shape=condition,color=condition))+
  geom_line() + 
  geom_point(size=3, fill="white")
## e) Based on the graph you produced in question d, 
##    what can you conclude about how frequently 
##    people talk about plants versus animals, 
##    with regards to how common they are?
#Based on the graph produced in (d), the frequency is more for exotic animals and common plants. 
#So, people talk more frequently about exotic animals.

##########
##Exercise 2. Binomial distribution
##########
## Suppose there are 12 multiple choice questions in a quiz. 
## Each question has 4 possible answers, and only one of them is correct. 

## a) Please calculate the probability of getting exactly 5 answers right 
##    if you answer by chance. Calculate this using the dbinom() function.
dbinom(5, size = 12, prob = 0.25)

## b) Next please calculate the probability of answering 4 or less questions 
##    correctly by chance. 
pbinom(4,size = 12,prob = 0.25)
##########
##Exercise 3. Chi-square test
##########
## a) Consider the dataset dutchSpeakersDistMeta from sheet1. 
##    Load the package (languageR) and look at the summary of the variables, 
##    as well as their classes. Which variables are factors?
library(languageR)
summary(dutchSpeakersDistMeta)
sapply(dutchSpeakersDistMeta, class)
#Out of all the variables in dutchSpeakersDistMeta dataset, 
#the variables "Speaker", "Sex", "AgeGroup", "ConversationType", and "EduLevel" are factors.
## b) We want to find out whether there is a difference between males and females 
##    with respect to the age groups they are in.
##	  First use the function 'table()' to get the counts and create 
##    a contingency table of AgeGroup by Sex.
cont_table <- table(dutchSpeakersDistMeta$Sex, dutchSpeakersDistMeta$AgeGroup)
cont_df <- data.frame(cont_table)
##    Visualize your data with a single bar plot (use ggplot) that represents the counts with 
##    respect to each age group and each sex.
ggplot(cont_df, aes(Var2, Freq, fill = Var1)) +
  geom_bar(stat = "identity")
## c) Inspect the table you created in b). Does it look like there could be a significant 
##    difference between the sexes?
#There isn't a significant difference between male and femal in all the age groups. Because the difference is very minimal.
## d) We are going to calculate whether there's a difference between males and females 
##    regarding their age group using the function chisq.test. 
##    Look at the help of this function. 
##    Then use the  function to calculate whether there's a difference in our table from b). 
##    Is there a significant difference in age group?
?chisq.test
chisq.test(cont_table)
#We reject the null hypothesis because the p-value obtained from chisq.test() is higher than the cut-off for accepting the Null Hypothesis. 
#Hence there are significant differences between the data
## e) What are the degrees of freedom for our data? How are they derived?
#The degrees of freedom in our data is 4. Degrees of Freedom=Sample size-Parameters required.
#Therefore,Number of age groups in our data is 5 and the parameter we're considering is Gender which is 1.
#Then 5-1=4.

##########
##Exercise 4. Binomial versus chi-square
########## 
##    In this exercise, we will consider a made up example of there doctors can predict  
##    if a patient has temperature or not just by holding their hand  
##    Several doctors were blindfolded and were asked to tell if the experimenter  
##    has temperature/fever or not.  
##    There were a total of 200  trials, of which the doctors 
##    correctly indicated that a patient had fever 83 times.

## a) What is the null hypothesis, i.e. how often would we expect the doctor to 
##    be correct by chance (in raw number and in percentage)?
#Null hypothesis - Getting the temperature right by chance
# Based on the given data, we would expect the doctors to be correct 0.415 times (raw number 83/200) and 41.5 % of times
## b) Using a chisquare test, what do you conclude about whether this idea
##    of checking fever/temperature works? 
tests <- c(rep(0, 117), rep(1, 83))
tests
chisq.test(table(tests))
#As seen in the chi-squared test, this method of checking temperature does not work because 
#the p-value is less than 0.05 which means that null hypothesis can be accpeted. This implies, that the correct prediction 
#of doctors out of the 200 trials were by chance.
## c) Now calculate significance using the binomial test as we used it in exercise 2.
dbinom(83, size = 200, 0.5)
## d) The results from these two tests are slightly different. Which test do you think 
##    is better for our data, and why?
#chi-square test is better fitted for the data because binomial distribution is better suited for larger sample size.

##########
##Exercise 5.
##########
## Describe a situation where you would choose McNemar's test over the ChiSquare test. 
## What would be the problem of using the normal ChiSquare test in a case where 
## McNemar's test would be more appropriate?
#McNemar's test can be chosen where the contingency table is of size 2X2. 
#McNemar's test is performed on two groups of data on the same sample and it mostly measures the ratio change
#chi-square test checks for the dependency in data.
#McNemar's test is preferred over Chi-Square test where the priority is to find a ratio change and not the 
#dependency in the data.
#Ratio change observed will be different if we use chi-square where McNemar's should have been used.
