
library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


## View each datasets
View(NEI)
View(SCC)

## 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
## make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

#Using Base Plotting System in R
# Plot the Total Emission per Year
df_grp_year_sum <- aggregate(Emissions ~ year, data = NEI, FUN = sum)

plot(df_grp_year_sum$year, df_grp_year_sum$Emissions, type = "l", 
     ylab = "Total Emission (PM2.5) in Tons in US",
     xlab = "Year (from 1999 - 2008)",
     main = "Yes, Total Emission from PM2.5 decreased (close to 50% reduction)\n in the US  from 1999 to 2008",
     ylim = c(0, max(df_grp_year_sum$Emissions) * 1.1)) # Set the minimum y value to 0
      


### 2.  Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (
#fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

NEI_24510 <- filter(NEI,fips == "24510")
df_grp_year_sum_24510 <- aggregate(Emissions ~ year, data = NEI_24510, FUN = sum)

plot(df_grp_year_sum_24510$year, df_grp_year_sum_24510$Emissions, type = "l", 
     ylab = "Total Emission (PM2.5) in Tons in Baltimore City(fips == 24510)",
     xlab = "Year (from 1999 - 2008)",
     main = "Yes, Total Emission from PM2.5 also decreased \n in the Baltimore City, Maryland from 1999 to 2008",
     ylim = c(0, max(df_grp_year_sum_24510$Emissions) * 1.1)) # Set the minimum y value to 0


### 3. Of the four types of sources indicated by the type type (point, nonpoint, onroad, 
#nonroad) variable, which of these four sources have seen decreases in emissions from 
#1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? 
#Use the ggplot2 plotting system to make a plot answer this question.

df_grp_year_type_sum_24510 = NEI_24510 %>% group_by(year, type)  %>%
  summarise(total_Emissions = sum(Emissions),
            .groups = 'drop')

ggplot(df_grp_year_type_sum, 
       aes(x = year, y = total_Emissions, group = type, color = type)) +
  geom_line(size = 1) +
  xlab("Year (from 1999 - 2008)") +
  ylab("Total Emission (PM2.5) in Tons") +
  scale_color_manual(values = c("red", "black", "blue", "purple")) +
  ggtitle("NONPOINT, NON-ROAD and ON-ROAD are all have decreasing \nEmission Trend from 1999-2008 but for the POINT, there is a increasing \nTrend from 1999-2005 and decreasing from 2005-2008")


### 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

merged_NEI_SCC <- left_join(NEI, SCC, by = "SCC")
#View(merged_NEI_SCC[grepl("Coal", merged_NEI_SCC$Short.Name), ])
merged_NEI_SCC_Coal <- merged_NEI_SCC[grepl("Coal", merged_NEI_SCC$Short.Name), ]


merged_NEI_SCC_Coal_grp_year_sum = merged_NEI_SCC_Coal %>% group_by(year)  %>%
  summarise(total_Emissions = sum(Emissions),
            .groups = 'drop')

ggplot(merged_NEI_SCC_Coal_grp_year_sum, aes(x=year, y=total_Emissions)) +
  geom_line(size = 1) + 
  ylab("Total Emission (PM2.5) in Tons") +
  xlab("Year (from 1999 - 2008)") +
  labs(title = "Coal Combustion-Related Sources of PM2.5: There is a decrease \nDecrease from 1998 to 2002, slight increase from 2002 to 2005 and \nsignificant decrease from 2005 to 2008") + # add a chart title
  theme(plot.title = element_text(hjust = 0.5, vjust = 0.5, face = "bold"))  + # center the title horizontally and vertically
  # Customize y-axis
  scale_y_continuous(labels = comma, 
                     limits = c(0, max(merged_NEI_SCC_Coal_grp_year_sum$total_Emissions) * 1.1), # set the maximum limit 10% higher than the max value of y
                     expand = c(0, 0.05)) # remove white space at the top of the chart


### 5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City

merged_NEI_SCC_24510 <- filter(merged_NEI_SCC,fips == "24510")
merged_NEI_SCC_24510_Motor <- merged_NEI_SCC_24510[grepl("Vehicles|Motor", merged_NEI_SCC_24510$Short.Name), ]

merged_NEI_SCC_24510_Motor_grp_year_sum = merged_NEI_SCC_24510_Motor %>% group_by(year)  %>%
  summarise(total_Emissions = sum(Emissions),
            .groups = 'drop')

ggplot(merged_NEI_SCC_24510_Motor_grp_year_sum, aes(x=year, y=total_Emissions)) +
  geom_line(size = 1) + 
  ylab("Total Emission (PM2.5) in Tons") +
  xlab("Year (from 1999 - 2008)") +
  labs(title = "Motor Vehicle Sources of PM2.5 in Baltimore City: Significant \ndecrease from 1998 to 2002, slight decrease from 2002 to 2008") + # add a chart title
  theme(plot.title = element_text(hjust = 0.5, vjust = 0.5, face = "bold"))  + # center the title horizontally and vertically
  # Customize y-axis
  scale_y_continuous(labels = comma, 
                     limits = c(0, max(merged_NEI_SCC_24510_Motor_grp_year_sum$total_Emissions) * 1.1), # set the maximum limit 10% higher than the max value of y
                     expand = c(0, 0.05)) # remove white space at the top of the chart

### 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (
#fips == "06037"
#fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

merged_NEI_SCC_Motor <- merged_NEI_SCC[grepl("Vehicles|Motor", merged_NEI_SCC$Short.Name), ]
merged_NEI_SCC_Motor_06037_24510 <- merged_NEI_SCC_Motor[grepl("06037|24510", merged_NEI_SCC_Motor$fips), ]


merged_NEI_SCC_Motor_06037_24510_year_sum = merged_NEI_SCC_Motor_06037_24510 %>% group_by(year, fips)  %>%
  summarise(total_Emissions = sum(Emissions),
            .groups = 'drop')

ggplot(merged_NEI_SCC_Motor_06037_24510_year_sum, 
       aes(x = year, y = total_Emissions, group = fips, color = fips)) +
  geom_line(size = 1) +
  xlab("Year (from 1999 - 2008)") +
  ylab("Total Emission (PM2.5) in Tons") +
  scale_color_manual(values = c("red", "blue")) +
  ggtitle("Motor Vehicle Sources of PM2.5: Baltimore City (24510) and \nLos Angeles City (06037) are both have decreasing \nTotal Emission Trend from 1999-2008 but for the Los Angeles City , \n the Decreasing Trend is more significant")


