## Male butterfly Linear model 

library(gpglot2)
library(ggpubr)
library(ISLR)
#__________________________----

## TIBBLE CREATION---
## creating a tibble that only has male butterflies
male_butterfly <- butterfly %>% filter(sex=="male")

## Checking the datatypes of the male butterflies
male_butterfly %>% glimpse()
#__________________________----

## PLOT --- 
## 
male_butterfly %>% ggplot(aes(june_mean_temperature, forewing_length)) + geom_point() + geom_smooth(method="lm") + stat_cor(method="pearson", p.accuracy=0.001, r.accuracy=0.001) + stat_regline_equation(geom="text", label.y=13.7)
male_butterfly %>% ggplot(aes(sex, june_mean_temperature)) + geom_boxplot()


#__________________________----

## MODEL ----
## Model indicates that june_mean_temperature does exert leverage over forewing_length
male_lsmodel <- lm(forewing_length ~ june_mean_temperature, data=male_butterfly)
summary(male_lsmodel)

## Checking model diagnostics
## some points violate homogeneity of variance, linearity, normality of residuals
performance::check_model(male_lsmodel, check=c("normality", "qq"))
performance::check_model(male_lsmodel, check=c("linearity", "homogeneity"))



## Here, I check if dropping a value improves my model
## lambda=1 fits within the 95% Confidence interval, so I will use lambda=1
## boxcox shows that including other terms is unlikely to help
MASS::boxcox(male_lsmodel)
best_lambda <- male_butterfly$june_mean_temperature[which.max(male_butterfly$forewing_length)]
print(best_lambda)

## checking outliers using cook's distance
## found outlier at row = 26
cooksD <- cooks.distance(male_lsmodel)
influential <- cooksD[(cooksD > (3 * mean(cooksD, na.rm = TRUE)))]
influential


## Here, I try dropping outliers
## R-squared increased
## Boxcox shows that lambda=1 is still above the 95% confidence interval
## Performance has improved
male_lsmodel2 <- lm(forewing_length[-26] ~ june_mean_temperature[-26], data=male_butterfly)
summary(male_lsmodel2)
performance::check_model(male_lsmodel2)
MASS::boxcox(male_lsmodel2)
best_lambda2 <- male_butterfly$june_mean_temperature[-26][which.max(male_butterfly$forewing_length[-26])]

## male_lsmodel2 is preferred

#__________________________----

## PLOT ----

## plotting male_lsmodel2 tibble
june_mean_temperature <- male_butterfly$june_mean_temperature[-26]
forewing_length <- male_butterfly$forewing_length[-26]

male_lsmodel2_tibble <- tibble(june_mean_temperature, forewing_length)

male_lsmodel2_tibble %>% ggplot(aes(june_mean_temperature, forewing_length)) + geom_point() + geom_smooth(method="lm", se=TRUE) + stat_cor(method="pearson", p.accuracy=0.001, r.accuracy=0.001) + stat_regline_equation(label.y=13.75)
