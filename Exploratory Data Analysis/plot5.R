library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


## View each datasets
View(NEI)
View(SCC)


### 5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City
png(file = "plot5.png", width = 800, height = 600, units = "px", pointsize = 12)

merged_NEI_SCC <- left_join(NEI, SCC, by = "SCC")

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

dev.off()