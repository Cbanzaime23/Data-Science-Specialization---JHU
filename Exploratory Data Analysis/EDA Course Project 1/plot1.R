#Loading the data from wd into R
dataFile <- "C:\\Users\\Christian\\Documents\\R wd\\EDA Course Project 1\\household_power_consumption.txt"
data <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
View(data)
head(data)
str(data)

#Subsetting
subSetData <- data[data$Date %in% c("1/2/2007","2/2/2007"),]

str(subSetData)
globalActivePower <- as.numeric(subSetData$Global_active_power)

png("plot1.png", width=480, height=480)

#Global Active Power
hist(globalActivePower, col="blue", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()

hist(globalActivePower)
