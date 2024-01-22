#Getting and Cleaning Data
#Week 3 Quiz

# Number 1

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/Housing.csv")
list.files(".data")
Housing <- read.csv("C:/Users/chiie/Desktop/Desktop/R Working Directory/data/Housing.csv")

View(Housing)

library(dbplyr)

Housing$ACR

agricultureLogical <- filter(Housing, ACR == 3, AGS == 6)
View(agricultureLogical)

which(agricultureLogical)

agricultureLogical <- Housing$ACR == 3 & Housing$AGS == 6
head(which(agricultureLogical), 3)

#Number 2
fileurl2 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
dst2 <- 'C:/Users/chiie/Desktop/Desktop/R Working Directory/data/q2.jpg'
download.file(fileurl2, dst2, mode = 'wb')
data2 <- readJPEG(dst2, native = TRUE)
data2
quantile(data2, probs = c(0.3, 0.8))


#Number 3 
library(jpeg)
library(data.table)
library(dplyr)
library(Hmisc)


#Download the csv files
fileUrl3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileUrl4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

#Set the directory
dst3 <- 'C:/Users/chiie/Desktop/Desktop/R Working Directory/data/GDP.csv'
dst4 <- 'C:/Users/chiie/Desktop/Desktop/R Working Directory/data/Educational.csv'

#Download the dataset
download.file(fileUrl3, dst3)
download.file(fileUrl4, dst4)

#Read csv
GDP <- read.csv(dst3)
Educational <- read.csv(dst4)

#View data
View(GDP)
View(Educational)

gdp <- fread(fileUrl3, skip=4, nrows = 190, select = c(1, 2, 4, 5), col.names=c("CountryCode", "Rank", "Economy", "Total"))

educ <- fread(fileUrl4)

#Merge edu and gdp by country code
merge = merge(gdp, educ, by = 'CountryCode')
#how many matches?
nrow(merge)

View(merge)
arrange(merge, desc(Rank))#[13, Economy]
arrange(merge, desc(Rank))[13, 3]

#Question # 4
tapply(merge$Rank, merge$`Income Group`, mean)

#5
merge$RankGroups <- cut2(merge$Rank, g=5)
table(merge$RankGroups, merge$`Income Group`)
