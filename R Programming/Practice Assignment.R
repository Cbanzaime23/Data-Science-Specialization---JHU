#Download and unzip the file on your working directory
dataset_url <- "http://s3.amazonaws.com/practice_assignment/diet_data.zip"
download.file(dataset_url, "diet_data.zip")
unzip("diet_data.zip", exdir = "diet_data")

list.files("diet_data")

andy <- read.csv("diet_data/Andy.csv")
head(andy)

length(andy$Day)

#Dimension of the andy data.frame
dim(andy)

#To get the feel of the data
str(andy)
summary(andy)
names(andy)

#How we would want to see andy's starting weight
andy[1, "Weight"] #rownum, colname

#andy final weight
andy[30, "Weight"]

#Alternatively, you could create a subset of the 'Weight' column where the data where 'Day' is equal to 30.
andy[which(andy$Day == 30), "Weight"]
andy[which(andy[,"Day"] == 30), "Weight"]

#Doing the same thing
subset(andy$Weight, andy$Day==30)

#Let's assign Andy's starting and ending weight to vectors:
andy_start <- andy[1, "Weight"]
andy_end <- andy[30, "Weight"]

#loss
andy_loss <- andy_start - andy_end

#list files
files <- list.files("diet_data")
files

#files subsetting
files[1:5]

#lets take a look at john's
john <- read.csv(files[3])
john

files_full <- list.files("diet_data", full.names=TRUE)
files_full

head(read.csv(files_full[3]))

#combining data from andy and david0];1 
andy_david <- rbind(andy, read.csv(files_full[2]))

#Checking the data
head(andy_david)
tail(andy_david)

#25th day for andy_david
day_25 <- andy_david[which(andy_david$Day == 25), ]

#Example of a loop
for (i in 1:5) {print(i)}


#Lets apply the concept of loop
dat <- data.frame()
for (i in 1:5) {
        dat <- rbind(dat, read.csv(files_full[i]))
}
str(dat)


#Out of curiousity
for (i in 1:5) {
        dat2 <- data.frame()
        dat2 <- rbind(dat2, read.csv(files_full[i]))
}
str(dat2)
head(dat2)

#What if we want ot know the median of dat weight
median(dat$Weight, na.rm = TRUE)

#Median weight of day 30
dat_30 <- dat[which(dat[, "Day"] == 30),]
dat_30
median(dat_30$Weight)

#Sample function
weightmedian <- function(directory, day)  {
        files_list <- list.files(directory, full.names=TRUE)                        #creates a list of files
        dat <- data.frame()#creates an empty data frame
        for (i in 1:5) {                                
                #loops through the files, rbinding the together 
                dat <- rbind(dat, read.csv(files_list[i]))
        }
        dat_subset <- dat[which(dat[, "Day"] == day),]              
        #subsets the rows that match the 'day' argument
        median(dat_subset[, "Weight"], na.rm=TRUE)                                  #identifies the median weight 
        #while stripping out the NAs
}
#run
weightmedian("diet_data", 17)

#creating an empty data frame
summary(files_full)
tmp <- vector(mode = "list", length = length(files_full))
summary(tmp)

for (i in seq_along(files_full)) {
        tmp[[i]] <- read.csv(files_full[[i]])
}
str(tmp)

#apply function
str(lapply(files_full, read.csv))

str(tmp[[1]])
head(tmp[[1]][,"Day"])

#do.call function
output <- do.call(rbind, tmp)
str(output)


#From Clever Programmer
#First, create a nums vector
nums <- c(1:10)
nums

#Create a duplicate of a vector
dup <- numeric()
dup

#Fill in the dup vector
for(i in nums){
        dup <- c(dup, i)
}
dup
#dup is now a replicate of nums

data <- read.csv("C:/Users/chiie/Desktop/R files/specdata/001.csv")
#Sulfate column
data[["sulfate"]]
#mean of sulfate column
mean(data[["sulfate"]], na.rm = TRUE)








