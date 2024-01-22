library(AppliedPredictiveModeling)
library(caret)
library(rattle)
library(rpart.plot)
library(randomForest)

# Download data.

#Download the training data
url_raw_training <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
file_dest_training <- "pml-training.csv"

download.file(url=url_raw_training, destfile=file_dest_training, method="curl")


#Download the training data
url_raw_testing <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"
file_dest_testing <- "pml-testing.csv"

download.file(url=url_raw_testing, destfile=file_dest_testing, method="curl")




# Import the data treating empty values as NA.
df_training <- read.csv(file_dest_training, na.strings=c("NA",""), header=TRUE)

colnames_train <- colnames(df_training)

df_testing <- read.csv(file_dest_testing, na.strings=c("NA",""), header=TRUE)

colnames_test <- colnames(df_testing)

# Verify that the column names (excluding classe and problem_id) are identical in the training and test set.
all.equal(colnames_train[1:length(colnames_train)-1], colnames_test[1:length(colnames_train)-1])



# Count the number of non-NAs in each col.
nonNAs <- function(x) {
        as.vector(apply(x, 2, function(x) length(which(!is.na(x)))))
}


# Build vector of missing data or NA columns to drop.
# Drop all columns that are less than 19622
colcnts <- nonNAs(df_training)
drops <- c()
for (cnt in 1:length(colcnts)) {
        if (colcnts[cnt] < nrow(df_training)) {
                drops <- c(drops, colnames_train[cnt])
        }
}

#Show all the column names that needs to be scrap
drops


# Drop NA data and the first 7 columns as they're unnecessary for predicting.

#NA data
df_training <- df_training[,!(names(df_training) %in% drops)]
#first 7 columns
df_training <- df_training[,8:length(colnames(df_training))]

#NA data
df_testing <- df_testing[,!(names(df_testing) %in% drops)]
#first 7 columns
df_testing <- df_testing[,8:length(colnames(df_testing))]

# Show remaining columns for training set
colnames(df_training)

#Show the remaining columns for test set
colnames(df_testing)

#Check if the columns names for training and test set are the same
all.equal(colnames(df_training)[1:length(colnames(df_training))-1], colnames(df_testing)[1:length(colnames(df_testing))-1])





