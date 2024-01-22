#Week4 GACD

#Editing text variables

#Fixing character vectors - tolower(), toupper()
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras2.csv")
cameraData <- read.csv("./data/cameras2.csv")
names(cameraData)

#Coverting all column names to lowercase
tolower(names(cameraData))

#Coverting all column names to uppercase
toupper(names(cameraData))

#Fixing character vectors - strsplit()
splitBNames <- strsplit(names(cameraData), "\\.")
splitBNames[[5]]
splitBNames[[6]]

#Quick aside - lists
mylist <- list(letters = c("A", "b", "c"), numbers = 1:3, matrix(1:25, ncol = 5))
head(mylist)

#Selecting  the first element of the list
mylist[1]

#Subset
mylist$letters
mylist[[1]]

#Fixing character vectors = sapply()
#Applies a function to each element in a vector of list
#Important parameters: X,FUN
splitBNames[[6]][1]

#this function will remove the "." in location
firstElement <- function(x){x[1]}
sapply(splitBNames, firstElement)

#Peer review data
fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
#download.file(fileUrl1, destfile = "./data/reviews2.csv")
#download.file(fileUrl2, destfile = "./data/solution2.csv")
#reviews <- read.csv("./data/reviews.csv")
#solutions <- read.csv("./data/solutions.csv")
head(reviews, 2)

#Fixing character vector - gsub()
testName <- "this_is_a_test"
sub("_", "", testName)
gsub("_","", testName)
gsub("_"," ", testName)

#Finding values -grep(),grepl()
grep("Alameda", cameraData$intersection)
table(grepl("Alameda", cameraData$intersection))
      
cameraData2 <- cameraData[!grepl("Alameda", cameraData$intersection),]
cameraData2

#More on grep()
grep("Alameda", cameraData$intersection, value = TRUE)
grep("JeffStreet", cameraData$intersection)
length(grep("JeffStreet", cameraData$intersection))

#More useful string functions
library(stringr)
nchar("Christian Ibanez")

#take part of the string
substr("Christian Ibanez", 1, 9)

paste("Jeffrey", "Leek")
paste0("Jeffrey", "Leek")
str_trim("Jeff          ")


#WOrking with dates
d1 <- date()
d1
class(d1)

d2 <- Sys.Date()
d2
class(d2)

#Formatting dates
#%d == day as number(0-31)
#%a == abbreviate weekday
#%A == unabbreviated weekday
#%m == month(00-12)
#%b == abbreviated month
#%B == unabbreavidated month
#%y == 2 digit year
#%Y == four digit year
format(d2, "%a %b %d")

#Creating dates
x <- c("1jan1960", "2jan1960", "31mar1960", "30jul1960")
z <- as.Date(x, "%d%b%Y")
z

z[1] - z[2]
as.numeric(z[1]-z[2])

#Converting to julian
weekdays(d2)
months(d2)
julian(d2)

#Lubridate
library(lubridate)
ymd("20140108")
mdy("08/04/2013")
dmy("03-04-2013")

#Dealing with times
ymd_hms("2011-08-03 10:15:03")
ymd_hms("2011-08-03 10:15:03", tz = "Pacific/Auckland")
?Sys.timezone

#Some functions have slightly differemt syntax
x <- dmy(c("1jan2013", "2jan2013", "31mar2013", "30jul2013"))
wday(x[1])
wday(x[1], label = TRUE)
