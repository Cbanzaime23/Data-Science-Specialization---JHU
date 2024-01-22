library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


## View each datasets
View(NEI)
View(SCC)


### 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
png(file = "plot4.png", width = 800, height = 600, units = "px", pointsize = 12)

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

dev.off()