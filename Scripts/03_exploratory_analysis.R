## EXPLORATORY ANALYSIS


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
## plot shows no significant relationship between year and forewing_length




## Here, I plot june_mean_rain against year for males and females
butterfly %>% ggplot(aes(year, june_mean_rain)) + geom_point(aes(colour=sex)) + 
  geom_smooth(aes(colour=sex), method="lm", se=FALSE) + 
  stat_cor(method="pearson", p.accuracy=0.001, r.accuracy=0.01, aes(colour=sex))



## Compare male and female forewing_length
butterfly %>% ggplot(aes(sex, forewing_length)) + geom_jitter(aes(colour=sex)) + 
  stat_summary(fun=mean, geom="crossbar", width=0.2) + 
  geom_segment(aes(x=1, xend=2, y=mean(female_butterfly$forewing_length), yend=mean(male_butterfly$forewing_length)), linetype="dashed") + 
  stat_compare_means(paired=FALSE, method="t.test", label.x.npc="right", comparisons=list(c("female", "male")), aes(label = sprintf("p = %5.4f", as.numeric(..p.format..))))


butterfly %>% ggplot(aes(forewing_length)) + geom_density(aes(fill=sex)) 
shapiro.test(male_butterfly$forewing_length)
shapiro.test(female_butterfly$forewing_length)
## Results show that forewing_length is statistically different between males and females
## The plot also shows that both male and femlae forewing_length are normally distributed
## Plots also show that year and june_mean_rain are not significantly correlated

## Creating a linear model comparison between female and male forewing length
## Found a statistically significant difference
## Checking confidence intervals
butterfly_compare <- lm(forewing_length ~ sex, data=butterfly)
butterfly_compare %>% summary()
forewing_length_confidence_intervals <- confint(butterfly_compare)
forewing_length_confidence_intervals

## Here, I plot the relationship between june_mean_rain and forewing_length between males and females
butterfly %>% ggplot(aes(june_mean_rain, forewing_length)) + geom_point(aes(colour=sex)) + 
  geom_smooth(se=FALSE, aes(colour=sex)) + 
  stat_cor(method="pearson", aes(colour=sex), label.x=c(400, 400), p.accuracy=0.001, r.accuracy=0.001)
## Results show no significant correlation between june_mean_rain and forewing_length




## Here, I plot the relationship between june_mean_temperature and forewing_length for all butterflies

butterfly %>% ggplot(aes(june_mean_temperature, forewing_length)) + geom_point() + 
  geom_smooth(method="lm", se=FALSE) + 
  stat_cor(method="pearson", p.accuarcy=0.001, r.accuracy=0.01)

# This plot suggests that there is a very weak positive correlation between june_mean_temperature and the forewing_length of all butterflies

#__________________________----
## Linear MODEL ----

## Linear model for forewing_length and june_mean_temperature
## Linear model suggests no positive correlation
butterfly_lsmodel <- lm(forewing_length ~ june_mean_temperature, data=butterfly)
summary(butterfly_lsmodel)
## Here, I check the performance of this linear model
## Boxcox suggests that including other interaction terms is unlikely to improve performance
performance::check_model(butterfly_lsmodel)
MASS::boxcox(butterfly_lsmodel)

## Checking for outliers
## Found outliers at june_mean_temperature = 14, 17, 55, 57
butterfly_cooksD <- cooks.distance(butterfly_lsmodel)
butterfly_influential <- butterfly_cooksD[(butterfly_cooksD > (3 * mean(butterfly_cooksD, na.rm = TRUE)))]
butterfly_influential

## creating a new model excluding outliers
## Model did not improve but still suggests a very weak to no positive correlation
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


## Checking the 95% confidence intervals for butterfly_lsmodel
## Butterfly forewing length ranges from 7.67706077 ~ 13.2906165
butterfly_confidence_intervals <- confint(butterfly_lsmodel)
butterfly_confidence_intervals





