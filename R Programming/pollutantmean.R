

#Scratch
# a list of values
nums <- c(2,3,4,5,6)
nums

#Construct an empty numerical vector
duplicate <- numeric()
dup

#for each value in nums
for (i in nums) {
        #the duplicate vector includes itself plus the            next duplicate value
        duplicate <- c(duplicate, i)
}
#duplicate resembles the nums
duplicate
nums == duplicate

#Pollutant Function
pollutantmean <- function(directory, pollutant, id = 1:332){
        ListOfFiles <- list.files(path = directory, pattern = ".csv", full.names = TRUE)
        values <- numeric()
        
        for (i in id) {
                data <- read.csv(ListOfFiles[i])
                values <- c(values, data[[pollutant]])
        }
        mean(values, na.rm = TRUE)
}

pollutantmean("C:/Users/chiie/Desktop/R files/specdata", "sulfate")

pollutantmean("specdata", "sulfate", 1:10)