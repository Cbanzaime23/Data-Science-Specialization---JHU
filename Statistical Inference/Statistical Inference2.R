library("ggplot2")

#Load ToothGrowth data
data("ToothGrowth")

#Display summary
summary(ToothGrowth)

#Display head
head(ToothGrowth)

#Unique Values in len
unique(ToothGrowth$len)

#Unique Values in Supp
unique(ToothGrowth$supp)

#Unique Values in Dose
unique(ToothGrowth$dose)


#Convert dose to a factor
ToothGrowth$dose <- as.factor(ToothGrowth$dose)


#Plot tooth length ('len') vs. the dose amount ('dose'), broken out by supplement delivery method ('supp')

ggplot(aes(x = dose, y = len), data = ToothGrowth) + geom_boxplot(aes(fill = dose)) + xlab("Dose Amount") + ylab("Tooth Length") + facet_grid(~ supp) + ggtitle("Tooth Length vs. Dose Amount \nby Delivery Method") + theme(plot.title = element_text(lineheight = .8, face = "bold"))


#Plot tooth length ('len') vs. supplement delivery method ('supp') broken out by the dose amount ('dose')
ggplot(aes(x = supp, y = len), data = ToothGrowth) + geom_boxplot(aes(fill = supp)) + xlab("Supplement Delivery") + ylab("Tooth Length") +  facet_grid(~dose) + ggtitle("Tooth Length vs Delivery Method \nby Dose Amound") + theme(plot.title = element_text(lineheight = 0.8, face = "bold"))



#run t-test on Supp and TootheGrowth
t.test(len ~ supp, data = ToothGrowth)

#Run t-test using dose amount 0.5 and 1.0
ToothGrowth_sub <- subset(ToothGrowth, ToothGrowth$dose %in% c(1.0, 0.5))
t.test(len ~ dose,data = ToothGrowth_sub)

#Run t-test using dose amount 0.5 and 2.0
ToothGrowth_sub <- subset(ToothGrowth, ToothGrowth$dose %in% c(0.5, 2.0))
t.test(len ~ dose,data = ToothGrowth_sub)


#Run t-test using dose amount 1.0 and 2.0
ToothGrowth_sub <- subset(ToothGrowth, ToothGrowth$dose %in% c(1.0, 2.0))
t.test(len ~ dose,data = ToothGrowth_sub)

