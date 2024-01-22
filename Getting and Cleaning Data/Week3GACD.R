#Week3
#Subsetting - Quick Review
set.seed(13435)
X <- data.frame("var1"= sample(1:5), "var2"=sample(6:10), "var3"= sample(11:15))
X <- X[sample(1:5), ]; X$var2[c(1,3)] = NA
X

#Subsetting a specific column
X[,1]
X[,"var1"]
X[1:2,"var2"]

#Subsetting using logical ands and ors
X[(X$var1 <= 3 & X$var3 > 11),]
X[(X$var1 <= 3 | X$var3 > 15),]

#Dealing with missing values
X[which(X$var2 > 8),]

#Sorting
sort(X$var1)
sort(X$var1, decreasing = TRUE)
sort(X$var2, na.last = TRUE)

#Ordering
#Rearrange the order of X data frame using var1 as index
X[order(X$var1),]

#ordering with plyr
library(plyr)
arrange(X, var1)

arrange(X, desc(var1))

#Adding rows and column
X$var4 <- rnorm(5)
X

#Using Cbind 
Y <- cbind(X, rnorm(5))
Y

#Using Rbind
Z <- rbind(Y, rnorm(5))
Z

#Summarising data
#Getting the data from the web
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/restaurants.csv")
restData <- read.csv("./data/restaurants.csv")

#look at the dataset
head(restData, n =3)
tail(restData, n =3)

summary(restData)
str(restData)

#Quantile
quantile(restData$councilDistrict, na.rm = TRUE)
quantile(restData$councilDistrict, probs = c(0.5, 0.75, 0.9))

#Make a table
table(restData$zipCode, useNA = "ifany")
table(restData$councilDistrict, restData$zipCode)

#Check for missing values
sum(is.na(restData$councilDistrict)) #No missing values
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0)

#Row and column sums
colSums(is.na(restData))
all(colSums(is.na(restData)) == 0)

#Values with specific characteristics
table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212", "21213"))

restData[restData$zipCode %in% c("21212", "21213"),]

#Cross tabs
data("UCBAdmissions")
DF <- as.data.frame(UCBAdmissions)
summary(DF)

xt <- xtabs(Freq ~ Gender + Admit, data = DF)
xt

#Flat tables
warpbreaks$replicate <- rep(1:9, len = 54)
xt <- xtabs(breaks ~ .,data = warpbreaks)
xt
ftable(xt)

#Size of a data set
fakeData <- rnorm(1e5)
object.size(fakeData)

print(object.size(fakeData), units = "MB")


#Creating New Variables
#Creating sequences
s1 <- seq(1, 10, by = 2) ; s1
s2 <- seq(1, 10, length = 3) ; s2
x <- c(1,3,8,25,100); seq(along = x)

#Subsetting variables
restData$nearMe <- restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)

#Creating binary variables
restData$zipWrong <- ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode < 0)

#Creating categorical variables
restData$zipGroups <- cut(restData$zipCode, breaks = quantile(restData$zipCode))
table(restData$zipGroups)

#Create an table based on that
table(restData$zipGroups, restData$zipCode)

#Easier Cutting
library(Hmisc)
restData$zipGroups <- cut2(restData$zipCode, g = 4)
table(restData$zipGroups)

#Creating factor variables
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]

class(restData$zcf)

#Levels of factor variables
yesno <- sample(c("yes", "no"), size = 10, replace = TRUE)
yesnofac <- factor(yesno, levels = c("yes", "no"))
relevel(yesnofac, ref = "yes")

as.numeric(yesnofac)

#Cutting produces factor variables
library(Hmisc)
restData$zipGroups <- cut2(restData$zipCode, g = 4)
table(restData$zipGroups)

#Using the mutate function
library(Hmisc); library(plyr)
restData2 <- mutate(restData, zipGroups = cut2(zipCode, g =4))
table(restData2$zipGroups)

#Common transforms
abs(x)
sqrt(x)
ceiling(x)
floor(x)
round(x, digits = n)
signif(x, digits = n)
cos(x), sin(x)
log(x)
log2(x), log10(x)
exp(x)

#Reshaping Data
#The goal is tidy data

#1. each variable forms a column
#2. each observation forms a row
#3. each table/file store  data about one kind of obsevation (people/hospital)

#start with reshaping
install.packages("reshape2")
library(reshape2)
head(mtcars)

#Melting data frames
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id = c("carname", "gear", "cyl"), measure.vars = c("mpg", "hp"))
head(carMelt, n = 3)
tail(carMelt, n = 3)

#Casting data frames
cylData <- dcast(carMelt, cyl ~ variable)
cylData

cylData <- dcast(carMelt, cyl ~ variable, mean)
cylData

head(InsectSprays)
tapply(InsectSprays$count, InsectSprays$spray, sum)

#Another way - split
spIns = split(InsectSprays$count, InsectSprays$spray)
spIns

#Another way - apply
sprCount <- lapply(spIns, sum)
sprCount

#Another way - combine
unlist(sprCount)
sapply(spIns, sum)

#Another way - plyr package
ddply(InsectSprays,.(spray),summarize,sum=sum(count))

#Creating a new variable
spraySums <- ddply(InsectSprays,.(spray), summarize, sum = ave(count, FUN = sum))
dim(spraySums)
head(spraySums)

#Managing Data frames with dplyr - basic tools
library(dplyr)
options(width = 105)

chicago <- readRDS("chicago.rds")
dim(chicago)
str(chicago)
names(chicago)

head(select(chicago, city:dptp))
head(select(chicago, -(city:dptp)))

#Doing the same function in base R
i <- match("city", names(chicago))
j <- match("dptp", names(chicago))
head(chicago[, -(i:j)])


chic.f <- filter(chicago, pm25tmean2 > 30)
head(chic.f)
chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80)
head(chic.f)

#Arranging according to the date column
chicago <- arrange(chicago,date)
head(chicago)
tail(chicago)
chicago <- arrange(chicago, desc(date))
head(chicago)
tail(chicago)

#Changing variable name
chicago <- rename(chicago, pm25 = pm25tmean2, dewpoint = dptp)
head(chicago)

chicago <- mutate(chicago, pm25detrend = pm25 - mean(pm25, na.rm = TRUE))
head(select(chicago, pm25, pm25detrend))


chicago <- mutate(chicago, tempcat = factor(1* (tmpd > 80), labels = c("cold", "hot")))
hotcold <- group_by(chicago, tempcat)
hotcold

summarize(hotcold, pm25 = mean(pm25, na.rm =TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))

chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)
years <- group_by(chicago, year)
summarize(years, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))

chicago %>% mutate(month = as.POSIXlt(date)$mon + 1) %>% group_by(month) %>% summarize(pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))


#Merging Data
#Peer Review data
if(!file.exists("./data")){dir.create("./data")}
fileUrl1 <- #Data not available
fileUrl2 <- #Data not available

download.file(fileUrl1, destfile = "./data/reviews.csv")
download.file(fileUrl2, destfile = "./data/solutions.csv")
reviews <- read.csv("./data/reviews.csv")
solutions <- read.csv("./data/solutions.csv")
head(reviews, 2)
head(solutions, 2)
