#Getting and Cleaning Data
#Course Project

#Checking if the folder "data" in working directory already exists
if(!file.exists("./data")){dir.create("./data")}

#Link to the zip file to download       
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#Download the data and name it "Dataset.zip" and place it on "data" folder
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unziping the dataSet to "data"' folder directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")


# Reading the datasets
# Reading trainings tables from train folder
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
Subject_Train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")


# Reading testing tables from test folder
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
Subject_Test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# Reading feature vector from UCI HAR Dataset
features <- read.table('./data/UCI HAR Dataset/features.txt')

# Reading activity labels from UCI HAR Dataset
activityLabels <- read.table('./data/UCI HAR Dataset/activity_labels.txt')

#Assigning column names
#For train datasets
colnames(X_train) <- features[,2]#Second column of features
colnames(Y_train) <-"activityId"
colnames(Subject_Train) <- "subjectId"

#For test datasets
colnames(X_test) <- features[,2]#Second column of features
colnames(Y_test) <- "activityId"
colnames(Subject_Test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

#Merging all data
Merge_train <- cbind(Y_train, Subject_Train, X_train)
Merge_test <- cbind(Y_test, Subject_Test, X_test)
Train_And_Test <- rbind(Merge_train, Merge_test)


#Extract only the measurements on the mean and standard deviation for each measurement
#Get all the column names of Train_And_Test
colNames <- colnames(Train_And_Test)

#Create vector that will have a value "TRUE" for the columns names that matched the ff. regular expressions: "activityId", "subjectId", "mean..", "std"
ID_Mean_and_Std <- (grepl("activityId" , colNames) | 
                         grepl("subjectId" , colNames) | 
                         grepl("mean.." , colNames) | 
                         grepl("std.." , colNames) )

#subset "activityId", "subjectId", "mean..","std.." columns
For_Mean_And_Std <- Train_And_Test[ , ID_Mean_and_Std == TRUE]


#Using descriptive activity names to name the activities in the data set
setActivityNames <- merge(For_Mean_And_Std, activityLabels,
                              by='activityId',
                              all.x=TRUE)

#Creating a second, independent tidy data set with the average of each variable for each activity and each subject
