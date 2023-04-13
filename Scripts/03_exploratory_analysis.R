## Linear Model

library(tidyverse)
library(ggplot2)
library(ggpubr)
library(ISLR)
#__________________________----
## PLOTS ----

## Plotting a scatter matrix for all variables
## plot shows no clear relationship between variables
## Will examine each relationship more closely
GGally::ggpairs(butterfly)


## Here, i plot forewing_length against year 
butterfly %>% 
  ggplot(aes(year, forewing_length)) + geom_point() + 
  geom_smooth(method="lm", se=FALSE) + 
  stat_cor(method="pearson", p.accuracy=0.001, r.accuracy=0.01)


## Here, i plot forewing_length against year for males and females
butterfly %>% 
  ggplot(aes(year, forewing_length)) + geom_point(aes(colour=sex)) + 
  geom_smooth(aes(colour=sex), method="lm", se=FALSE) + 
  stat_cor(method="pearson", p.accuracy=0.001, r.accuracy=0.01, aes(colour=sex))
## plot shows no relationship between year and forewing_length




## Here, I plot june_mean_rain against year for males and females
butterfly %>% ggplot(aes(year, june_mean_rain)) + geom_point(aes(colour=sex)) + 
  geom_smooth(aes(colour=sex), method="lm", se=FALSE) + 
  stat_cor(method="pearson", p.accuracy=0.001, r.accuracy=0.01, aes(colour=sex))



## Compare male and female forewing_length
butterfly %>% ggplot(aes(sex, forewing_length)) + geom_jitter(aes(colour=sex)) + 
  stat_summary(fun.y=mean, geom="crossbar", width=0.2) + 
  geom_segment(aes(x=1, xend=2, y=mean(female_butterfly$forewing_length), yend=mean(male_butterfly$forewing_length)), linetype="dashed") + 
  stat_compare_means(paired=FALSE, method="t.test", label.x.npc="right", comparisons=list(c("female", "male")), aes(label = sprintf("p = %5.4f", as.numeric(..p.format..))))


stat.test <- shapiro.test(
  butterfly$forewing_length
  
)
butterfly %>% ggplot(aes(forewing_length)) + geom_density(aes(colour=sex, fill=sex)) + stat_pvalue_manual(stat.test, label="p.adj", y.position=0.8, x.position=12, aes(colour=sex))
## Results show that forewing_length is statistically different between males and females
## The plot also shows that both male and femlae forewing_length are normally distributed



## Here, I plot the relationship between june_mean_rain and forewing_length between males and females
butterfly %>% ggplot(aes(june_mean_rain, forewing_length)) + geom_point(aes(colour=sex)) + 
  geom_smooth(se=FALSE, aes(colour=sex)) + 
  stat_cor(method="pearson", aes(colour=sex), label.x=c(400, 400), p.accuracy=0.001, r.accuracy=0.001)
## Results show no correlation between june_mean_rain and forewing_length




## Here, I plot the relationship between june_mean_temperature and forewing_length for all butterflies

butterfly %>% ggplot(aes(june_mean_temperature, forewing_length)) + geom_point() + 
  geom_smooth(method="lm", se=FALSE) + 
  stat_cor(method="pearson", p.accuarcy=0.001, r.accuracy=0.01)

# This plot suggests that there is a very weak positive correlation between june_mean_temperature and the forewing_length of all butterflies

#__________________________----
## MODEL ----

## Linear model for forewing_length and june_mean_temperature
## Linear model suggests no positive correlation
butterfly_lsmodel <- lm(forewing_length ~ june_mean_temperature)
summary(butterfly_lsmodel)
## Here, I check the performance of this linear model
## Boxcox suggests that including other interaction terms is unlikely to improve performance
performance::check_model(butterfly_lsmodel)
MASS::boxcox(butterfly_lsmodel)

## Checking for outliers
## Found outliers at x = 14, 17, 55, 57
cooksD <- cooks.distance(butterfly_lsmodel)
influential <- cooksD[(cooksD > (3 * mean(cooksD, na.rm = TRUE)))]
influential

## creating a new model excluding outliers
## Model improved but still suggests a very weak to no positive correlation
butterfly_lsmodel2 <- lm(forewing_length[-57:-17] ~ june_mean_temperature[-57:-17], data=butterfly)
summary(butterfly_lsmodel2)

#__________________________----
## PLOTS ----
## Here, I compare the correlation between june_mean_temperature and forewing_length for males and females

butterfly %>% ggplot(aes(june_mean_temperature, forewing_length)) + 
  geom_point(aes(colour=sex)) + geom_smooth(method="lm", se=TRUE, aes(colour=sex)) + 
  stat_cor(method="pearson", aes(colour=sex), p.accuracy=0.001) + 
  stat_regline_equation(label.y=c(15.3, 14.6), aes(colour=sex))
## This plot suggests that there is a weak positive correlation between female forewing_length and june_mean_temperature
## However, there is a moderate positive correlation between male forewing_length and june_mean_temperature








