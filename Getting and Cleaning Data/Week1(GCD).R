#Checking if the file exist in the working directory
file.exists("Titanic.R")

#checking for a "data" directory and creating it if it doesn't exist
if (!file.exists("data")) {
        dir.create("data")
}

#getting data form the internet
download.file()

#Download a file form the web
fileUrl <- "https://data.batlimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv")
list.files(".data")
date()

#Reading data from working directory
TitanicData <- read.csv("Titanic.csv")
View(TitanicData)


#Reading XML
library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl, useInternal = TRUE)
rootNode <- xmlRoot(doc)

#Reading Json data
install.packages("jsonlite")
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)

names(jsonData$owner)
jsonData$owner$login

myjson <- toJSON(iris, pretty = TRUE)
cat(myjson)

iris2 <- fromJSON(myjson)
head(iris2)


#Data Table
library(data.table)
DF <- data.frame(x = rnorm(9), y = rep(c("a", "b", "c"), each = 3), z = rnorm(9))
head(DF, 3)

#Another way
DT <- data.table(x = rnorm(9), y = rep(c("a", "b", "c"), each = 3), z = rnorm(9))
head(DT, 3)

#show all tables
tables()

#Subset
DT[2, ]
DT[DT$y == "a", ]

#Subsetting 2nd and 3rd row
DT[c(2,3)]

#Column subsetting in data.table
#The argument you pass after the comma is called an 'experession"
#In R an expression is a collection fo statements enclosed in curly brackets
{
        x = 1
        y = 2
}
k = {print(10);5}
print(k)
 
#Calculating values for variables with expressions
DT[,list(mean(x),sum(z))]

#Adding a new column to your data table
DT[,w:=z^2]
DT

#Multiple operations
DT[,m:={tmp <- (x + z); log2(tmp + 5)}]
DT

#Adding a column with boolean values
DT[,a:=x > 0]
DT

DT[,b:=mean(x + w), by = a]
DT

#Special Variables
#.N
#An integer, length one
set.seed(123);
DT <- data.table(x = sample(letters[1:3], 1E5, TRUE))
DT[, .N, by = x]

#Keys
DT <- data.table(x = rep(c("a", "b", "c"), each = 100), y = rnorm(300))
setkey(DT, x)
DT['a']

#Joins
DT1 <- data.table(x = c("a", "a", "b", "dt1"), y = 1:4)
DT2 <- data.table(x = c("a", "b", "dt2"), z = 5:7)
setkey(DT1, x);setkey(DT2, x)
merge(DT1, DT2)

#Fast reading
big_df <- data.frame(x = rnorm(1E6), y = rnorm(1E6))
file <- tempfile()
write.table(big_df, file = file, row.names = FALSE, col.names = TRUE, sep = "\t", quote = FALSE )
system.time(fread(file))

system.time(read.table(file, header = TRUE, sep = "\t"))

#Link
https://github.com/raphg/Biostat-578/blob/master/Advanced_data_manipulation.Rpres


#Week 1 Quiz1
data <- read.csv("C:/Users/chiie/Desktop/Desktop/R files/getdata_data_DATA.gov_NGAP.csv", header = TRUE)
head(data)
View(data)

library(XML)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileUrl, useInternal = TRUE)
rootNode <- xmlRoot(doc)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = data.csv)


#Importing/Reading an Excel file
if(!file.exists("data")){
        dir.create("data")
}
fileUrl <- "https://inventory.data.gov/dataset/3fbe4fc6-95fc-4ee4-bda7-06f985ae8276/resource/1866644f-22ca-4b4c-8e71-40983e91e2c8/download/ngap2017.xlsx"
download.file(fileUrl,destfile = "./data/cameras.xlsx")
dateDownloaded <- date()

#reading the file into R
library(XML)
fileUrl <- "http://www.w3schools.com/xml/plant_catalog.xml"
doc <- xmlTreeParse(fileUrl)
rootNode <- xmlRoot(doc)

#Reading CSV
DT <- read.csv("C:/Users/chiie/Desktop/Desktop/R files/getdata_data_ss06pid.csv", header = TRUE)
head(DT)
View(DT)
