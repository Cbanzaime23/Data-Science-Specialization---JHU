# R Programming week 3
#Looping on the Command Line

#lapply: loop over a list and evaluate a function on each element
#sapply: Same as lapply but try to simplify the result
#apply: Apply a function over the amrgins of an array
#tapply: Apply a function over subset of a vector
#mapply: Multivariate version of lapply

#split:particularly in conjuction with lapply

#example
x <- list(a= 1:5, b = rnorm(10))
x
lapply(x, mean)
#outputs the mean of "a" and the mean of "b"
#applies the lapply function to every element of the list


#another example
x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
x
#getting the mean of every element of the list
lapply(x, mean)


#example of runif function 
#Uniform random variable; min = 0, max = 1
runif(2)

x <- 1:4
lapply(x, runif)

x <- 1:4
lapply(x, runif, min = 0, max = 10)

#creating a list of matrix
x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2))
x
#let say you want to extract the first column from each matrix
# you can create a function that will function inside of lapply
#creating a function called extract

lapply(x, function(extract) extract[,1])
#lapply always return a list

#sapply
x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d= rnorm(100, 5))
x
lapply(x, mean) #lapply returns list
sapply(x, mean) #sapply retuns a vector
mean(x)

#apply: used to evaluate a function (often an anonymous one) over the margins of an array

#200 random variable with 20 rows and 10 columns
x <- matrix(rnorm(200), 20, 10)
x
#getting the mean
apply(x, 2, mean) #getting the mean for each column
apply(x, 1, mean) #getting the mean for each rows
#getting the sum
apply(x, 2, sum) #getting the sum for each column
apply(x, 1, sum) # getting the sum for each row



#Higly optimized functions for sums and means dimensions
rowSums = apply(x, 1, sum)
rowMeans = apply(x, 1, mean)
colSums = apply(x, 2, sum)
colMeans =  apply(x, 2, mean)

#Quantiles of the rows of a matrix
#returns a 2 by 20 matrix
x <- matrix(rnorm(200), 20, 10)
x
apply(x, 1, quantile, probs = c(0.25, 0.50, 0.75))

#average matrix in an array
#a 3D matrix? (2 by 2 by 10), 2 by 2 matrix stack together
a <- array(rnorm(2 * 2 * 10), c(2, 2, 10))
a
apply(a, c(1,2), mean)
rowMeans(a, dims = 2)

#mapply is a multivariate apply of sorts which applies a function in parallel over a set of arguments

#tedious
list(rep(1,4), rep(2,3), rep(3,2), rep(4,1))

#easy
mapply(rep, 1:4, 4:1)

#another
mapply(rep, 10:1, 1:10)

noise <- function(n, mean, sd) {
        rnorm(n, mean, sd)
}
noise(5, 1, 2)

mapply(noise, 1:5, 1:5, 2)

#tapply
#tapply is used to apply a function over subsets of a vector
x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10) # 10 ones, 10 twos, 10 threes

#tapply
tapply(x, f, mean, simplify = FALSE) # returns a list
tapply(x, f, mean, simplify = TRUE) # returns a vector
tapply(x, f, range) #range gives the minimun and maximum


#split
x <- c(rnorm(10), runif(10), rnorm(10, 1))
x
f <- gl(3, 10) # 10 ones, 10 twos, 10 threes
f
split(x, f) #splitting the x into 3 groups


tapply(x, f, mean, simplify = FALSE) # returns a list
#alternative to tapply function with simplify = FALSE
lapply(split(x, f), mean)


library(datasets)
head(airquality)
#let say we want to calculate the mean of Ozone, Solar.R, Wind, Temp for a given month

#First, we have to split the data frame by month
s <- split(airquality, airquality$Month)
s
#the dataframe is not splitted into 9 pieces


#calculating the mean of 4 columns can be done in 3 ways
lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind", "Temp")])) #This returns a list

sapply(s, function(x) colMeans(x[, c("Ozone","Solar.R","Wind", "Temp")]))#This returns a vector

sapply(s, function(x) colMeans(x[, c("Ozone","Solar.R", "Wind", "Temp")], na.rm = TRUE))# removing NAs



#subsetting 4 columns from airquality data.frame
subset <- airquality[, c("Ozone", "Solar.R", "Wind", "Temp")]

#calculating colMeans for the subset
colMeans((subset))

#subsetting the  first 4 rows from airquality data.frame
rowSubset <- airquality[c(1:4), ]

#calculating rowMeans for the subset
rowMeans(rowSubset) #which is nonesense because you calculate the means of different class
    

#Splitting on More than One Level
x <- rnorm(10)
x
f1 <- gl(2, 5) # 1 and 2 repeated 5 times
f1
f2 <- gl(5, 2) # 1 to 5 repeated 2 times
f2
interaction(f1, f2)
str(split(x, list(f1, f2)))
#Droping the empty levels
str(split(x, list(f1, f2), drop = TRUE))

#Debugging in R

#Indication that something's not right
#message
#warning
#error
#condition

printmessage <- function(x){
        if(x > 0)
                print("x is greater than zero")
        else
                print("x is less than or equal to zero")
        invisible(x)
}

#The primary tools for debugging functions in R are
#traceback
#debuig
#browser
#trace
#recover












# calculate the average miles per gallon (mpg) by number of cylinders in the car (cy)


sapply(split(mtcars$mpg, mtcars$cyl), mean)
tapply(mtcars$mpg, mtcars$cyl, mean)

#Virginica Mean
tapply(iris$Sepal.Length, iris$Species, mean)

# what R code returns a vector of the means of the variables 'Sepal.Length', 'Sepal.Width', 'Petal.Length', and 'Petal.Width'?
apply(iris[, 1:4], 2, mean)

#How can one calculate the average miles per gallon (mpg) by number of cylinders in the car (cyl)?
sapply(split(mtcars$mpg, mtcars$cyl), mean)
tapply(mtcars$mpg, mtcars$cyl, mean)
with(mtcars, tapply(mpg, cyl, mean))

#what is the absolute difference in average hp of 4 cylinder and 8 cylinder
127

#Quiz Week 4
#1
set.seed(1)
rpois(5, 2)
#2
