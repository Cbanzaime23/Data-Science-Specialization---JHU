library(jsonlite)
library(httpuv)
library(httr)
install.packages("openssl")
library(openssl)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at 
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app(appname = "Getting_and_Cleaning_Data_Week2_Quiz",
                   key = "9c93cee11b4f644c6600",
                   secret = "3e19bb564bf2c03c265423e56fc24df6ac03b658")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

#Take action on http error
stop_for_status(req)

#Extract content from a request
json1  <- content(req)

#Convert the json1 to data.frame
gitDF <- jsonlite::fromJSON(jsonlite::toJSON(json1))

#View

#Subset data.frame
gitDF[gitDF$full_name == "jtleek/datasharing", "created_at"]


#Number 2
acs <- read.csv("C:/Users/chiie/Desktop/Desktop/R Working Directory/getdata_data_ss06pid.csv")
View(acs)

install.packages("RMySQL")
library("RMySQL")
install.packages("sqldf")
library(sqldf)

sqldf("select pwgtp1 from acs where AGEP < 50")
sqldf("select * from acs where AGEP<50 and pwgtp1")

#Number3
unique(acs$AGEP)
#is equivalent
sqldf("select distinct AGEP from acs")

#Number4
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
nchar(htmlCode[10])
nchar(htmlCode[20])
nchar(htmlCode[30])
nchar(htmlCode[100])

#Number5
con <- url("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for")
htmlCode2 = readLines(con)

