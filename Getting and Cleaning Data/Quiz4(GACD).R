#Getting and Cleaning Data
#Quiz 4

#1
library(data.table)
#Download the data
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile = "./data/quiz4data.csv")

#Reading the data
d <- read.csv("./data/quiz4data.csv")

#Show all the column names of d data.frame
names(d)

#split the names(d) when there is "wgtp"
strsplit(names(d), split = "wgtp")

#From the splited list, return the 123th element
strsplit(names(d), split = "wgtp")[123]


#2
#Download the data
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile = "./data/GDP.csv")


#Reading the data
GDP <- read.csv("./data/GDP.csv")

#View data
View(GDP)

#Show the 5th column of GDP
GDP[,5]

#Subsitute the "," by ""(Nothing) in GDP[,5]
clean <- gsub(",","",GDP[,5])
clean

#Get the mean
mean(as.numeric(clean[1:215]),na.rm = TRUE)

x <- mean(as.numeric(clean[5:194]))
y <- mean(as.numeric(clean[221]))
z <- mean(as.numeric(clean[223:235]))

mean(x, y, z)



#3
#In the data set from Question 2 what is a regular expression that would allow you to count the number of countries whose name begins with "United"? 
#Assume that the variable with the country names in it is named countryNames. How many countries begin with United? 
#

#Returns the number of rows which country name is starting with "United"
grep("^United",countryNames)
grep("^United",GDP$X.2)

#Count how many countries matched
length(grep("^United",GDP$X.2))



#4
#Download and save the csv
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile = "./data/quiz4data2.csv")




data2 <- read.csv("./data/quiz4data2.csv")
View(data2)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile = "./data/quiz4data3.csv")

data3 <- read.csv("./data/quiz4data3.csv")
View(data3)


#setnames(data2, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))
#Changing some column names
colnames(data2)[1] <- "CountryCode"
colnames(data2)[3] <- "rankingGDP"
colnames(data2)[5] <- "Long.Name"
colnames(data2)[6] <- "gdp"

#Changed
colnames(data2)

#Merge data2 and data3 by primary key which is CountryCode
all <- merge(data2, data3, by = "CountryCode")


#returns TRUE for values in all$Special.Notes that matched "june"
grepl("june", tolower(all$Special.Notes))

#returns TRUE for values in all$Special.Notes that matched "fiscal year end"
grepl("fiscal year end", tolower(all$Special.Notes))

#returns a table of numbers of TRUE and FALSE
table(grepl("june", tolower(all$Special.Notes)), grepl("fiscal year end", tolower(all$Special.Notes))

#Returns the number of TRUEs in the first and second argument
table(grepl("june", tolower(all$Special.Notes)), grepl("fiscal year end", tolower(all$Special.Notes)))[4]




#5
install.packages("quantmod")
library(quantmod)
amzn <- getSymbols("AMZN",auto.assign=FALSE)
sampleTimes <- index(amzn)

#shows the rows with matched the "^2012"
grep("^2012",sampleTimes)

#Counts how may matched
#How many values were collected in 2012?
length(grep("^2012",sampleTimes))

#How many values were collected on Mondays in 2012? 
library(lubridate)

#Returns the values of rows that matched the "^2012"
sampleTimes[grep("^2012",sampleTimes)]

#Return the count of dates in 2012 that are mondays

#Convert to as.Date
as.Date(sampleTimes[grep("^2012",sampleTimes)])

#Converting the dates to weekdays
weekdays(as.Date(sampleTimes[grep("^2012",sampleTimes)]))

#find the mondays in weekdays
weekdays(as.Date(sampleTimes[grep("^2012",sampleTimes)])) == "Monday"
                             

#Return the count of dates in 2012 that are mondays                            
sum(weekdays(as.Date(sampleTimes[grep("^2012",sampleTimes)]))=="Monday")
