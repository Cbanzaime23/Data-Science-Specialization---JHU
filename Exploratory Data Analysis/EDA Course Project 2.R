install.packages("downloader")
require(downloader)

if(!file.exists("./data")){dir.create("./data")}

dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download.file(dataset_url,destfile="./data/DataforPeerAssessment.zip")

# Unziping the dataSet to "data"' folder directory
unzip(zipfile="./data/DataforPeerAssessment.zip",exdir="./data")
library(ggplot2)


#Reading data from working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
View(NEI)
View(SCC)


NEI_data <- with(NEI, aggregate(Emissions, by = list(year), sum))


#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#Pm2.5 in the United States from 1999 to 2012
#the plot of PM2.5 Emissions per year in a line graph because this is a time series data
plot(NEI_data, type = "l", main = "How PM2.5 emissions changes from 1999 to 2012?", xlab = "year", ylab = "PM2.5 emissions", pch = 18, col = "red", lty = 6)


#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
#Extract from the NEI_data where fips == "24510"
Subset_24510 <- subset(NEI, fips == "06037")
Baltimore <- tapply(sub1$Emissions, sub1$year, sum)
plot(Baltimore, type = "l", main = "Hpw the PM2.5 emissions in Baltimore City changes from 1999 to 2012", xlab = "Year", ylab = "PM2.5 emissions", pch = 18, col = "red", lty = 5)


#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore County? Which have seen increases in emissions from 1999-2008? 

Subset_24510 <- subset(NEI, fips == "24510")
Baltimore_Sources <- aggregate(Subset_24510[c("Emissions")], list(type = Subset_24510$type, year = Subset_24510$year), sum)
qplot(year, Emissions, data = Baltimore_Sources, color = type, geom= "smooth")+ ggtitle("How the four sources increases and decrease from year 1999 to 2012?") + xlab("Year") + ylab("PM2.5 emissions") 


#Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
Sub_SCC <- SCC[grepl("Coal" , SCC$Short.Name), ]
colnames(SCC)
Sub_NEI <- NEI[NEI$SCC %in% SCC.sub$SCC, ]

plot <- ggplot(Sub_NEI, aes(x = factor(year), y = Emissions, fill =type)) + geom_bar(stat= "identity", width = .4) + xlab("year") +ylab("coal-related PM2.5 emissions") + ggtitle("How is the per year contribution of Coal-Related PM2.5 Emissions for 1999, 2002, 2005, 2008?") + geom_line(color = "red") + geom_point()


print(plot)








#How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
#subset NEI data by fips and type
Sub <- subset(NEI, fips == "06037" & type=="ON-ROAD")
#for the Los Angeles
Sub <- subset(NEI, fips == "06037" & type=="ON-ROAD")
baltimore_source <- aggregate(Sub[c("Emissions")], list(type = sub3$type, year = sub3$year, zip = sub3$fips), sum)

qplot(year, Emissions, data = baltimore_source, geom= "line") + theme_gray() + geom_line(color = "red")  + ggtitle("How the Motor Vehicle-Related Emissions in Baltimore City changed from 1999 to 2012") + xlab("year") + ylab("Levels of emission") 


#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
Sub <- subset(NEI, fips == "06037" & type=="ON-ROAD")
ON_ROAD_SOURCES <- aggregate(Sub[c("Emissions")], list(type = 
                                                             Sub$type, year = Sub$year, zip = Sub$fips), sum)

Baltimore_road_sources <- rbind(baltimore_source, ON_ROAD_SOURCES)

qplot(year, Emissions, data = Baltimore_road_sources, color = zip, geom= "smooth", ylim = c(-200, 5400)) + ggtitle("How the Motor vehicle Emissions in (24510) and (06037) counties varies each year from 1999 to 2008") + xlab("Year") + ylab("Emission Levels") +geom_point()

require(dplyr)
baltcitymary.emissions<-summarise(group_by(filter(NEI, fips == "36061"& type == 'ON-ROAD'), year), Emissions=sum(Emissions))
losangelscal.emissions<-summarise(group_by(filter(NEI, fips == "06037"& type == 'ON-ROAD'), year), Emissions=sum(Emissions))

baltcitymary.emissions$County <- "Baltimore City, MD"
losangelscal.emissions$County <- "Los Angeles County, CA"
both.emissions <- rbind(baltcitymary.emissions, losangelscal.emissions)

require(ggplot2)
ggplot(both.emissions, aes(x=factor(year), y=Emissions, fill=County,label = round(Emissions,2))) +
        geom_bar(stat="identity") + 
        facet_grid(County~., scales="free") +
        ylab(expression("total PM"[2.5]*" emissions in tons")) + 
        xlab("year") +
        ggtitle(expression("Motor vehicle emission variation in Baltimore and Los Angeles in tons"))+
        geom_label(aes(fill = County),colour = "white", fontface = "bold")




require(dplyr)
#png("plot3.png", width=number.add.width, height=number.add.height)
# Group total NEI emissions per year:
baltcitymary.emissions.byyear<-summarise(group_by(filter(NEI, fips == "06037"), year,type), Emissions=sum(Emissions))
# clrs <- c("red", "green", "blue", "yellow")
ggplot(baltcitymary.emissions.byyear, aes(x=factor(year), y=Emissions, fill=type,label = round(Emissions,2))) +
        geom_bar(stat="identity") +
        #geom_bar(position = 'dodge')+
        facet_grid(. ~ type) +
        xlab("year") +
        ylab(expression("total PM"[2.5]*" emission in tons")) +
        ggtitle(expression("PM"[2.5]*paste(" emissions in Baltimore ",
                                           "City by various source types", sep="")))+
        geom_label(aes(fill = type), colour = "white", fontface = "bold")