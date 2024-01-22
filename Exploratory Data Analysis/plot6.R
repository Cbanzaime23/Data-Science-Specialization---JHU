
library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


## View each datasets
View(NEI)
View(SCC)


### 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (
#fips == "06037"
#fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
png(file = "plot6.png", width = 800, height = 600, units = "px", pointsize = 12)

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
  ggtitle("Motor Vehicle Sources of PM2.5: Baltimore City (24510) and \nLos Angeles City (06037) are both have decreasing Total \n Emission Trend from 1999-2008 but for the Los Angeles City , \n the Decreasing Trend is more significant") +
  theme(plot.title = element_text(hjust = 0.5, vjust = 0.5, face = "bold")) 

dev.off()