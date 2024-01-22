#Structure of a Data Analysis

library(kernlab)
data(spam)
View(spam)
#Perform the subsampling - sparate the dataset into 2 pieces

set.seed(3435)
trainIndicator <- rbinom(4601, size = 1, prob = 0.5)
table(trainIndicator)

#Split the Dataset
trainSpam <- spam[trainIndicator == 1, ]
testSpam <- spam[trainIndicator == 0, ]

head(trainSpam)
names(trainSpam)

table(trainSpam$type)

#Plots - Boxplot
plot(trainSpam$capitalAve ~ trainSpam$type)
plot(log10(trainSpam$capitalAve + 1) ~ trainSpam$type)


#Plots - Scatterplot
plot(log10(trainSpam[, 1:4] + 1))

#Clustering - 
hCLuster <- hclust(dist(t(trainSpam[, 1:57])))
plot(hCLuster)

#Clustering - After Log Transformation
hClusterUpdated <- hclust(dist(t(log10(trainSpam[, 1:55] + 1))))
plot(hClusterUpdated)


#Statistical Prediction/ Modelling
trainSpam$numType <- as.numeric(trainSpam$type) - 1
costFunction <- function(x, y) sum(x != (y > 0.5))
cvError <- rep(NA, 55)
library(boot)

#Create 55 models each with 1 predictor
for (i in 1:55) {
    lmFormula <- reformulate(names(trainSpam)[i], response = "numType")
    glmFit <- glm(lmFormula, family = "binomial", data = trainSpam)
    cvError[i] <- cv.glm(trainSpam, glmFit, costFunction, 2)$delta[2]
    
}

### Which predictor has minimum cross-validated error?
names(trainSpam)[which.min(cvError)]

## Use the best model from the group
predictionModel <- glm(numType ~ charDollar, family = "binomial", data = trainSpam)

## Get predictions on the test set
predictionTest <- predict(predictionModel, testSpam)
predictedSpam <- rep("nonspam", dim(testSpam)[1])

## Classify as "spam" for those with prob > 0.5
predictedSpam[predictionModel$fitted > 0.5] <- "spam"

#Classification Table
table(predictedSpam, testSpam$type)

#Error Rate
(61 + 458) / (1346 + 458 + 61 + 449)




