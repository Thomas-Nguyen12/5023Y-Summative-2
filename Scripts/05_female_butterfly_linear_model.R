## FEMALE LINEAR MODEL

library(ggplot2)
library(ggpubr)
library(ISLR)


## Creating a female subset of butterfly dataset
female_butterfly <- butterfly %>% filter(sex == "female")

##__________________________----
## PLOTS ----

## plotting forewing_length and june_mean_temperature in female butterflies
female_butterfly %>% ggplot(aes(june_mean_temperature, forewing_length)) + geom_point() + geom_smooth(method="lm", se=TRUE) + stat_cor(method="pearson", label.y=15) + stat_regline_equation(geom="text", label.y=14.9)

## Checking format of female data subset
str(female_butterfly)


##__________________________----
## MODEL ----



## Creating a linear model for female butterfly forewing length and june_mean_temperature
## R-squared value indicates no relationship
female_lsmodel <- lm(forewing_length ~ june_mean_temperature, data=female_butterfly)
summary(female_lsmodel)

## Checking model performance
## boxcox suggests highly likely linear relationship
performance::check_model(female_lsmodel)
MASS::boxcox(female_lsmodel)

## finding outliers
## found outliers at june_mean_temperature = 20, 26 and 30
female_cooksD <- cooks.distance(female_lsmodel)
female_influential <- female_cooksD[(female_cooksD > (3 * mean(female_cooksD, na.rm = TRUE)))]
female_influential

## Creating a new model excluding outliers called female_lsmodel2
## Model did not show improvements
## female_lsmodel2 still exhibits insignificant weak positive correlation 

female_lsmodel2 <- lm(forewing_length[-30:-20] ~ june_mean_temperature[-30:-20], data=female_butterfly)
summary(female_lsmodel2)

## Checking performance of female_lsmodel2
performance::check_model(female_lsmodel2)
MASS::boxcox(female_lsmodel2)

## Female lsmodel is preferred

##__________________________----
## PLOTS ----

## Plotting female_lsmodel2
female_forewing_length <- female_butterfly$forewing_length[-30:-20]
june_mean_temperature <- female_butterfly$june_mean_temperature[-30:-20]

female_lsmodel2_tibble <- tibble(june_mean_temperature, female_forewing_length)

female_lsmodel2_tibble %>% ggplot(aes(june_mean_temperature, female_forewing_length)) + geom_point() + geom_smooth(method="lm") + stat_cor(method="pearson", p.accuracy=0.001, r.accuracy=0.001) + stat_regline_equation(label.y=14.8)


## finding 95% confidence intervals of female_lsmodel
## Female forewing length ranges from 10.06288438 ~ 14.9488289
female_butterfly_confidence_intervals <- confint(female_lsmodel)
female_butterfly_confidence_intervals


