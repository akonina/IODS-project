# read the files: Human development and Gender inequality

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gi <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# data exploration on HD
dim(hd) # 195 observations and 8 variables
str(hd) # 6 numerical, 1 character, 1 interval
summary(hd) # all on different scales, missing data

# changing the column names
colnames(hd)
colnames(hd)[1] <- "hdi_rank"
colnames(hd)[2] <- "country"
colnames(hd)[3] <- "hdi"
colnames(hd)[4] <- "lifeexp"
colnames(hd)[5] <- "ed_exp"
colnames(hd)[6] <- "ed_mean"
colnames(hd)[7] <- "gni"
colnames(hd)[8] <- "gni_hdi"

# data exploration on GI
dim(gi) # 195 observations and 10 variables
str(gi) # 7 numerical, 1 character, 2 interval
summary(gi) # all on different scales, missing data

# changing the column names
colnames(gi)[1] <- "gii_rank"
colnames(gi)[2] <- "country"
colnames(gi)[3] <- "gii"
colnames(gi)[4] <- "matmort"
colnames(gi)[5] <- "teenbirths"
colnames(gi)[6] <- "parl"
colnames(gi)[7] <- "sed_m"
colnames(gi)[8] <- "sed_f"
colnames(gi)[9] <- "labor_f"
colnames(gi)[10] <- "labor_m"

# adding two new variables to the gi dataset
library(dplyr)
gi <- mutate(gi, sed_ratio = (sed_f / sed_m))
gi <- mutate(gi, labor_ratio = (labor_f / labor_m))

# joining the two datasets via country as identifier

# common columns to use as identifiers
human <- inner_join(hd, gi, by = "country", suffix = c(".hd",".gi"))
str(human)

# 195 observations, 19 variables

write.csv(human, file = "human.csv")
read.csv("human.csv")


