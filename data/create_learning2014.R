# Alena Konina. 14.11
# Exercise 2. Regression and model validation
# Data wrangling

# read and explore data
fulldata <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep = "\t", header = 1)
dim(fulldata)
str(fulldata)

# 183 rows and 60 columns

# combine question variables via dplyr
library(dplyr)
# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(fulldata, one_of(deep_questions))
fulldata$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(fulldata, one_of(surface_questions))
fulldata$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(fulldata, one_of(strategic_questions))
fulldata$stra <- rowMeans(strategic_columns)

# create column 'attitude' by scaling the column "Attitude"
fulldata$attitude <- fulldata$Attitude / 10

# select columns
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(fulldata, one_of(keep_columns))
str(learning2014)

# change the name of the second column
colnames(learning2014)[2] <- "age"

# change the name of "Points" to "points"
colnames(learning2014) [7] <- "points"

# select rows where points is greater than zero
learning2014 <- filter(learning2014, points > 0)

# wrangled dataset
str(learning2014)

# set the working directory to the IODS-project folder
getwd()
setwd("/Users/laboratoryforcognitivestudies/IODS-project/data")

# save the learning2014 dataset to the 'data' folder
write.csv(learning2014, file = "learning2014.csv")

# read learning2014
read.csv("learning2014.csv")
str(learning2014)
head(learning2014)
