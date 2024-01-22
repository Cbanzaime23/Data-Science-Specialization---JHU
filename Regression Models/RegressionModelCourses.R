#Regression Models Course

#Executive Summary



#load the mtcars dataset
data(mtcars)
mtcars
head(mtcars)

#Show summary
summary(mtcars)
str(mtcars)

#Convert to factors the "vs" and "am"
mtcars$vs <- as.factor(mtcars$vs)
mtcars$am <- as.factor(mtcars$am)
str(mtcars)
names(mtcars)
num <- length(mtcars$am)
#Change the names
levels(mtcars$am) <- c("Automatic", "Manual")
names(mtcars)[9]<-paste("Transmission")

library("ggplot2")
ggplot(aes(x = Transmission , y = mpg), data = mtcars) + geom_boxplot(aes(fill = Transmission)) + xlab("Transmission Type") + ylab("Miles per Gallon") + ggtitle("The interquartile range of Manual Transmission is higher than Automatic Transmission when it comes to Miles per Gallon")

#The interquartile range of Manual Transmission is higher than Automatic Transmission when it comes to Miles per Gallon. Let's test this hypothesis.
#Perform a t.test between the mean of Automatic and Manual for MPG
#(Assuming equal variance,Assuming unequal variance)

Auto.Transmission <- subset(mtcars,select=mpg, Transmission == "Automatic")
Manual.Transmission <- subset(mtcars,select=mpg,Transmission == "Manual")

#assuming equal variance between the two groups
t.test(Auto.Transmission,Manual.Transmission, var.equal = TRUE)

#assuming unequal variance between the two groups
t.test(Auto.Transmission,Manual.Transmission, var.equal = FALSE)


#We showed that the difference between the mpg of Automatic and Manual is significant


#Calculate the significant diffenrence
Signif.Diff <- mean(Manual.Transmission$mpg) - mean(Auto.Transmission$mpg)
Signif.Diff

#Do a regression analysis to verify the result of out t.test
LinReg <- lm(mpg ~ Transmission, data = mtcars)$coeff

#Do a regression analysis to determine the coefficient/s that is/are significant
MultLinReg <- lm(mpg ~., data = mtcars)
summary(MultLinReg)
summary(MultLinReg)$coeff

step(MultLinReg)$coeff


#Perform ANOVA
ANOVA <- aov(mpg ~ ., data = mtcars)
summary(ANOVA)


lm(mpg ~ cyl, data = mtcars)$coeff

