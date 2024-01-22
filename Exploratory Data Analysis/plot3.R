
library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


## View each datasets
View(NEI)
View(SCC)


### 3. Of the four types of sources indicated by the type type (point, nonpoint, onroad, 
#nonroad) variable, which of these four sources have seen decreases in emissions from 
#1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? 
#Use the ggplot2 plotting system to make a plot answer this question.
png(file = "plot3.png", width = 800, height = 600, units = "px", pointsize = 12)

NEI_24510 <- filter(NEI,fips == "24510")
#df_grp_year_sum_24510 <- aggregate(Emissions ~ year, data = NEI_24510, FUN = sum)

df_grp_year_type_sum_24510 = NEI_24510 %>% group_by(year, type)  %>%
  summarise(total_Emissions = sum(Emissions),
            .groups = 'drop')

ggplot(df_grp_year_type_sum, 
       aes(x = year, y = total_Emissions, group = type, color = type)) +
  geom_line(size = 1) +
  xlab("Year (from 1999 - 2008)") +
  ylab("Total Emission (PM2.5) in Tons") +
  scale_color_manual(values = c("red", "black", "blue", "purple")) +
  ggtitle("NONPOINT, NON-ROAD and ON-ROAD are all have decreasing \nEmission Trend from 1999-2008 but for the POINT, there is a increasing \nTrend from 1999-2005 and decreasing from 2005-2008") + 
  theme(plot.title = element_text(hjust = 0.5, vjust = 0.5, face = "bold")) 
dev.off()