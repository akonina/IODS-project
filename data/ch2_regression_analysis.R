read.csv("learning2014.csv")
# data structure
dim(learning2014)
str(learning2014)
head(learning2014)

## These data result form a survey conducted during an Introduction to Social Statistics course in the fall of 2014.
## This particular dataframe contains responses from 166 people who took the exam. There are 7 data entries for each participant: gender, age, attitude towards learning, questions related to deep learning, surface learning and strategic learning, as well as the exam grade.

summary(learning2014$gender)
# 110 women and 56 men undertook the survey

summary(learning2014$age)
# Their age ranged from 17 to 55 years old with a mean of 25.51

summary(learning2014$attitude)
summary(learning2014$deep)
summary(learning2014$stra)
summary(learning2014$surf)
# Their attitude, as well as the questions pertaining to deep, surface and strategic learning, were measured on a scale from 1 to 5

summary(learning2014$points)
# The exam grades varied from 7 points to 33 with a mean of 22.72

# graphical exploration
library(GGally)
library(ggplot2)

pairs(learning2014[-1], col = learning2014$gender)
p <- ggpairs(learning2014, mapping = aes(col = gender, alpha = 0.3), lower = list(combo = wrap("facethist", bins = 20)))
p

# The plot demonstrates paired correlations between all the variables except gender. It is a binary variable and should not be simply correlated with continuous ones.
# Here gender is used in all of the paired plots for a more detailed visual analysis.
# We can also see the boxplots for eacch variable and analyze them visually. None of the variables contains an alarming amount of outliers except for age.

# We are now interested in exploring whether we can explain the student exam grade by relating it with other available variables.
# A multiple regression model is fitted with a response variable 'points' and explanatory variables 'attitude', 'stra' and 'surf'.
lm <- lm(points ~ attitude + stra + surf, data = learning2014)
lm
summary(lm)

# The model with three explanatory variables is able to account for 21% of the variance (multiple R squared).
# It shows that the only variable with a statistically significant relationship with examn grade is 'attitude'.
# Now we have to try out and take the two other factors one by one in a search of a more parsimonious model.

lm1 <- lm(points ~ attitude + stra, data = learning2014)
lm1
summary(lm1)

lm2 <- lm(points ~ attitude + surf, data = learning2014)
lm2
summary(lm2)

# Taking out the 'surf' or 'stra' variables did not affect the multiple R squared and thus the fit of the model.
# It makes it safe to conclude that they do not affect the exam grade and we can proceed with the only significant factor 'attitude'.

lm3 <- lm(points ~ attitude, data = learning2014)
lm3
summary(lm3)

# The fitted model explains 19% of the variance, the attitude is concluded to be a statistically significant predictor for the exam grade.
# Next, to make sure that the model is fitted correctly, residuals analysis is due.

# Residuals vs. Fitted values
plot(lm3, which = c(1))

# QQ plot (theoretical quantiles)
plot(lm3, which = c(2))

#Residuals vs. Leverage
plot(lm3, which = c(5))

# The residuals vs. fitted values are equally distributed and do not demonsrate any pattern.
# The QQ plot shows a nice fit along the line with no cause for concern.
# The Leverage plot does nor show any particular outliers.
# The model is valid.