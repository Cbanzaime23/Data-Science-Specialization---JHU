#Practical Machine Learning Course Project

#Goal:
#"Predict the manner in which they did the exercise"
#Is it possible to predict how they did their exercise based on the


#QUESTION

#In the aforementioned study, six participants participated in a dumbell lifting exercise five different ways. The five ways, as described in the study, were "exactly according to the specification (Class A), throwing the elbows to the front (Class B), lifting the dumbbell only halfway (Class C), lowering the dumbbell only halfway (Class D) and throwing the hips to the front (Class E). Class A corresponds to the specified execution of the exercise, while the other 4 classes correspond to common mistakes."

#By processing data gathered from accelerometers on the belt, forearm, arm, and dumbell of the participants in a machine learning algorithm, the question is can the appropriate activity quality (class A-E) be predicted?



#INPUT DATA

#Load Libraries
library(AppliedPredictiveModeling)
library(caret)
library(rattle)
library(rpart.plot)
library(randomForest)


#Import Data
#Download Training Set
URL_Training <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
Training_CSV <- "pml-training.csv"
download.file(url=URL_Training, destfile=Training_CSV, method="curl")



URL_Testing <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"
Testing_CSV <- "pml-testing.csv"
download.file(url=URL_Testing, destfile=Testing_CSV, method="curl")



# Import data to R
DF_Training <- read.csv(Training_CSV, na.strings=c("NA",""), header=TRUE)
Colnames_Train <- colnames(DF_Training)

DF_Testing <- read.csv(Testing_CSV, na.strings=c("NA",""), header=TRUE)
Colnames_Test <- colnames(DF_Testing)



# Verify that the column names (excluding classe and problem_id) are identical in the training and test set.
all.equal(Colnames_Train[1:length(Colnames_Train)-1], Colnames_Test[1:length(Colnames_Train)-1])


#GET FEATURES

#Eliminate NA Columns
# Count the number of non-NAs in each col.
nonNAs <- function(x) {
        as.vector(apply(x, 2, function(x) length(which(!is.na(x)))))
}

# Build vector of missing data or NA columns to drop.
NonNACounts <- nonNAs(DF_Training)
Drop <- c()
for (count in 1:length(NonNACounts)) {
        if (NonNACounts[count] < nrow(DF_Training)) {
                Drop <- c(Drop, Colnames_Train[count])
        }
}



# Drop NA data and the first 7 columns as they're unnecessary for predicting.
DF_Training <- DF_Training[,!(names(DF_Training) %in% Drop)]

DF_Training <- DF_Training[,8:length(colnames(DF_Training))]

DF_Testing <- DF_Testing[,!(names(DF_Testing) %in% drops)]

DF_Testing <- DF_Testing[,8:length(colnames(DF_Testing))]

# Show remaining columns.
colnames(DF_Training)
colnames(DF_Testing)


# Verify that the column names (excluding classe and problem_id) are identical in the training and test set.
all.equal(colnames(DF_Training)[1:length(colnames(DF_Training))-1], colnames(DF_Testing)[1:length(colnames(DF_Testing))-1])

#Check for features that has low variability
nsv <- nearZeroVar(DF_Training, saveMetrics=TRUE)
nsv$nzv == FALSE

#No features in the training set that has near zero variability


#DEPLOY ALGORITHM

#Divide the entire Training set into 4 roughly equal sets
#And split each of them into 2(60% Training and 40% Testing)


set.seed(666)
Training_Subset <- createDataPartition(y=DF_Training$classe, p=0.25, list=FALSE)
DF_Subset1 <- DF_Training[Training_Subset,]
DF_Other <- DF_Training[-Training_Subset,]

set.seed(666)
Training_Subset <- createDataPartition(y=DF_Other$classe, p=0.33, list=FALSE)
DF_Subset2 <- DF_Other[Training_Subset,]
DF_Other <- DF_Other[-Training_Subset,]

set.seed(666)
Training_Subset <- createDataPartition(y=DF_Other$classe, p=0.5, list=FALSE)
DF_Subset3 <- DF_Other[Training_Subset,]
DF_Subset4 <- DF_Other[-Training_Subset,]
#We have now splitted the Training Set into 4 Set


# Divide each of these 4 sets into training (60%) and test (40%) sets.
set.seed(666)
Train <- createDataPartition(y=DF_Subset1$classe, p=0.6, list=FALSE)
DF_Subset_Training1 <- DF_Subset1[Train,]
DF_Subset_Testing1 <- DF_Subset1[-Train,]


set.seed(666)
Train <- createDataPartition(y=DF_Subset2$classe, p=0.6, list=FALSE)
DF_Subset_Training2 <- DF_Subset2[Train,]
DF_Subset_Testing2 <- DF_Subset2[-Train,]


set.seed(666)
Train <- createDataPartition(y=DF_Subset3$classe, p=0.6, list=FALSE)
DF_Subset_Training3 <- DF_Subset3[Train,]
DF_Subset_Testing3 <- DF_Subset3[-Train,]



set.seed(666)
Train <- createDataPartition(y=DF_Subset4$classe, p=0.6, list=FALSE)
DF_Subset_Training4 <- DF_Subset4[Train,]
DF_Subset_Testing4 <- DF_Subset4[-Train,]


Total <-length(DF_Subset_Training4$classe) + length(DF_Subset_Training3$classe) + length(DF_Subset_Training2$classe) + length(DF_Subset_Training1$classe) +
        length(DF_Subset_Testing1$classe) + length(DF_Subset_Testing2$classe) + length(DF_Subset_Testing3$classe) + length(DF_Subset_Testing4$classe)

#Check
length(DF_Training$classe) == Total


#EVALUATION

#Random Forest


# Train on training set 1 of 4 with only cross validation.
set.seed(666)
ModelFit1 <- train(classe ~ ., method="rf", trControl=trainControl(method = "cv", number = 4), data=DF_Subset_Training1)
print(ModelFit1, digits=3)


# Run against testing set 1 of 4.
predictions <- predict(ModelFit1, newdata=DF_Subset_Training1)
print(confusionMatrix(predictions, DF_Subset_Training1$classe), digits=4)


# Run against 20 testing set provided by Professor Leek.
print(predict(ModelFit1, newdata=DF_Testing))






# Train on training set 1 of 4 with only both preprocessing and cross validation.
set.seed(666)
ModelFit1 <- train(classe ~ ., method="rf", preProcess=c("center", "scale"), trControl=trainControl(method = "cv", number = 4), data=DF_Subset_Testing1)

print(ModelFit1, digits=3)

# Run against testing set 1 of 4.
predictions <- predict(modFit, newdata=DF_Subset_Training1)
print(confusionMatrix(predictions, DF_Subset_Training1$classe), digits=4)

# Run against 20 testing set provided by Professor Leek.
print(predict(modFit, newdata=DF_Testing))






#Apply the Random Forest with Cross Validation and Preprocessing to other 3 sets

# Train on training set 2 of 4 with only both preprocessing and cross validation.
set.seed(666)
modFit <- train(classe ~ ., method="rf", preProcess=c("center", "scale"), trControl=trainControl(method = "cv", number = 4), data=DF_Subset_Testing2)
print(modFit, digits=3)

# Run against testing set 2 of 4.
predictions <- predict(modFit, newdata=DF_Subset_Training2)
print(confusionMatrix(predictions, DF_Subset_Training2$classe), digits=4)

# Run against 20 testing set provided by Professor Leek.
print(predict(modFit, newdata=DF_Testing))








# Train on training set 3 of 4 with only both preprocessing and cross validation.
set.seed(666)
modFit <- train(classe ~ ., method="rf", preProcess=c("center", "scale"), trControl=trainControl(method = "cv", number = 4), data=DF_Subset_Testing3)
print(modFit, digits=3)

# Run against testing set 3 of 4.
predictions <- predict(modFit, newdata=DF_Subset_Training3)
print(confusionMatrix(predictions, DF_Subset_Training3$classe), digits=4)

# Run against 20 testing set provided by Professor Leek.
print(predict(modFit, newdata=DF_Testing))





# Train on training set 4 of 4 with only both preprocessing and cross validation.
set.seed(666)
modFit <- train(classe ~ ., method="rf", preProcess=c("center", "scale"), trControl=trainControl(method = "cv", number = 4), data=DF_Subset_Testing4)
print(modFit, digits=3)

# Run against testing set 4 of 4.
predictions <- predict(modFit, newdata=DF_Subset_Training4)
print(confusionMatrix(predictions, DF_Subset_Training4$classe), digits=4)

# Run against 20 testing set provided by Professor Leek.
print(predict(modFit, newdata=DF_Testing))




#OUT OF SAMPLE ERROR


#Random Forest (preprocessing and cross validation) 
#Testing Set 1: 
        #1 - .9714 = 0.0286
#Testing Set 2: 
        #1 - .9634 = 0.0366
#Testing Set 3: 
        #1 - .9655 = 0.0345
#Testing Set 4: 
        #1 - .9563 = 0.0437



#CONCLUSION















