library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


## View each datasets
View(NEI)
View(SCC)


### 2.  Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (
#fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.
png(file = "plot2.png", width = 800, height = 600, units = "px", pointsize = 12)

NEI_24510 <- filter(NEI,fips == "24510")
df_grp_year_sum_24510 <- aggregate(Emissions ~ year, data = NEI_24510, FUN = sum)

plot(df_grp_year_sum_24510$year, df_grp_year_sum_24510$Emissions, type = "l", 
     ylab = "Total Emission (PM2.5) in Tons in Baltimore City(fips == 24510)",
     xlab = "Year (from 1999 - 2008)",
     main = "Yes, Total Emission from PM2.5 also decreased \n in the Baltimore City, Maryland from 1999 to 2008",
     ylim = c(0, max(df_grp_year_sum_24510$Emissions) * 1.1)) # Set the minimum y value to 0


dev.off()