library(dplyr)

# Get the directory where the R script is located
script_directory <- dirname(rstudioapi::getSourceEditorContext()$path)
# Set the working directory to the script's directory
setwd(script_directory)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./Data/summarySCC_PM25.rds")
SCC <- readRDS("./Data/Source_Classification_Code.rds")


## View each datasets
View(NEI)
View(SCC)

## 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
## make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

#Using Base Plotting System in R
# Plot the Total Emission per Year
png(file = "./Plots/plot1.png", width = 800, height = 600, units = "px", pointsize = 12)


df_grp_year_sum <- aggregate(Emissions ~ year, data = NEI, FUN = sum)

plot(df_grp_year_sum$year, df_grp_year_sum$Emissions, type = "l", 
     ylab = "Total Emission (PM2.5) in Tons in US",
     xlab = "Year (from 1999 - 2008)",
     main = "Yes, Total Emission from PM2.5 decreased (close to 50% reduction)\n in the US  from 1999 to 2008",
     ylim = c(0, max(df_grp_year_sum$Emissions) * 1.1)) # Set the minimum y value to 0


dev.off()