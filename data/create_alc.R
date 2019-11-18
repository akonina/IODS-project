# Alena Konina. 17.11.
# Chapter 3. Logistic regression. Data wrangling
# Data taken from here: https://archive.ics.uci.edu/ml/datasets/Student+Performance
# Working with 2 files: student-por.csv, student-mat.csv

# exploring initial files 
student_mat <- read.csv("student-mat.csv", sep = ";", header = TRUE)
dim(student_mat)
str(student_mat)

student_por <- read.csv("student-por.csv", sep = ";", header = TRUE)
dim(student_por)
str(student_por)

# The "student-mat" file contains more observations than "student-por", but the same 33 factorial and interval variables.

# joining the two datasets using the dplyr package
library(dplyr)
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
math_por <- inner_join(student_mat, student_por, by = join_by, suffix = c(".math",".por"))
glimpse(math_por)

# We now have a dataset with 382 observations and 53 columns, both factorial and interval, because some of the variables are doubled depending on the dataset they initially came from.
# now we are creating a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(student_mat)[!colnames(student_mat) %in% join_by]

# combining these 'duplicated' answers by either: taking the rounded average (if the two variables are numeric) simply choosing the first answer (else).
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- select(two_columns, 1)
  }
}

# combining weekday and weekend alcohol use and adding it to the the new dataset
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# creating a binary high_use variable and adding it to the the new dataset
alc <- mutate(alc, high_use = alc_use > 2)

glimpse(alc)
# 382 observations, 35 variables

write.csv(alc, file = "alc.csv")
read.csv("alc.csv")
