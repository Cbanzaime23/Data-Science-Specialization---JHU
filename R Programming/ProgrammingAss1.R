#R Programming
#Programming Assignment 1
#Part 1


#Pollutant Function
#Example on how to use PollutantMean function
#PollutantMean(directory = "C:/Users/chiie/Desktop/R files/specdata", pollutant = "sulfate", id = 10:30)

pollutantmean <- function(directory, pollutant, id = 1:332) {
        fileList <- list.files(path = directory, pattern = ".csv", full.names = TRUE)
        values <- numeric()
        
        for(i in id ){
                data <- read.csv(fileList[i])
                values <- c(values, data[[pollutant]])
        }
        mean(values, na.rm = TRUE)
}
#Example
pollutantmean("C:/Users/chiie/Desktop/Desktop/R Working Directory/specdata/", "sulfate")






#Part 2
#Complete Function
complete <- function(directory, id = 1:332){
        filelist <- list.files(path = directory, pattern = ".csv", full.names = TRUE)
        nobs <- numeric()
        
        #For loop
        for (i in id) {
                data <- read.csv(filelist[i])
                nobs <- c(nobs, sum(complete.cases(data)))
        }
        
        data.frame(id, nobs)
}
#Example
complete("specdata/", id = 1:10)











#Part 3
#Correlation Function
corr <- function(directory, threshold = 0) {
        
        
        
        id = 1:332
        #Collection of list of all files in the specdata
        filename <- list.files(path = directory, pattern = ".csv",  full.names = TRUE)
        
        
        #Empty Numeric Vector
        result <- numeric()
        for(i in seq(filename)) {
                airquality <- read.csv(filename[i])
                good <- complete.cases(airquality)
                airquality <- airquality[good, ]
                if (nrow(airquality) > threshold) {
                        # We need [[]] around pollutant instead of [] since                          airquality["sulfate"]
                        # is a data.frame but we need a vector here. Hence,                          [[]]. Please note that using either
                        #[[]] or [] gives the same results as the test cases
                        correlation <- cor(airquality[["sulfate"]], airquality[["nitrate"]])
                        result <- append(result, correlation)
                        #print(correlation)
                }
        }
        result
}

#Example
corr("C:/Users/chiie/Desktop/R files/specdata", threshold = 200)

#wd
"C:/Users/chiie/Desktop/R files"




#understanding how corr function works

#filename example
filename <- list.files(path = "C:/Users/chiie/Desktop/R files/specdata/", pattern = ".csv",  full.names = TRUE)


#seq(filename) example
seq(filename)
result <- numeric()
#airquality <- read.csv(filename[i])
#reading the first csv file
airquality <- read.csv(filename[32])
airquality

#completecases returns a huge boolean vector
good <- complete.cases(airquality)
good

# airquality[good, ]
#returns all complete rows in filename[1]
airquality <- airquality[good, ]
airquality

#Lets define the threshold value
threshold = 100

#if statement
if (nrow(airquality) > threshold) {
        # If the number of complte rows is greater than the threshold, calculate the  correlation of
        correlation <- cor(airquality[["sulfate"]], airquality[["nitrate"]])
        correlation
}

#Store the calculated correlation in an array called "results"
#but first lets create an empty numeric vector called "results"

result <- append(result, correlation)
result
