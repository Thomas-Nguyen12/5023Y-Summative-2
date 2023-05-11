## CLEAN DATA ----

## Here, I tidy the unvoltine_butterfly dataset 

library(tidyverse)
library(janitor)

colnames(butterfly)

## Here, I clean the butterfly column names because JUN was in capitals, and Year had a capital letter
butterfly <- janitor::clean_names(butterfly)


## Here, I change the name of the rain and temperature columns to keep them coherent
butterfly <- butterfly %>% rename(june_mean_rain = rain_jun)
butterfly <- butterfly %>% rename(june_mean_temperature = jun_mean)

## Here, I check the summary statistics and datatypes of the dataset
## I found that june_mean_rain had a max value of 577. This is impossible and I will change it to 57.7
butterfly %>% summary()
butterfly %>% glimpse()
butterfly$june_mean_rain[butterfly$june_mean_rain == 577] <- 57.7

## Here, I check for missing values

butterfly %>% is.na() %>% sum()

## Here, I plot the correlation matrix between the variables in the dataset
GGally::ggpairs(butterfly)

## After running the above code, I found that there were four different datatypes for "sex"

## Here, I check the different input values for "sex"
butterfly$sex %>% unique()
## within "sex" I found: "Females", "Males", "Female", "Maes"
## Here, I change the text values in the "sex" column to just "male" and "female"

butterfly$sex[butterfly$sex == "Maes"] <- "male"
butterfly$sex[butterfly$sex == "Males"] <- "male"
butterfly$sex[butterfly$sex == "Females"] <- "female"
butterfly$sex[butterfly$sex == "Female"] <- "female"

## Here, I check the input values for "sex" again
butterfly$sex %>% unique()

# Here I check for duplicated values


for (i in colnames(butterfly)) {
  print (i)
  print(butterfly[i] %>% duplicated() %>% sum())
}
butterfly %>% head()

year_sex <- butterfly %>% select(year, sex) 

duplicated_years <- year_sex$year %>% duplicated()
checking_duplicated_values <- year_sex %>% mutate(duplicated_years)
checking_duplicated_values

## i found that certain values are repeated in the "year", jun_mean_temperature and jun_mean_rain column
## This is be due to some males and females being measured in the same year

## Here, I split the dataset into males and female sub-datasets to check for untidy data

male_butterfly <- butterfly %>% filter(sex == "male")
female_butterfly <- butterfly %>% filter(sex == "female")

## Here, I check the "male" sub-dataset

male_butterfly %>% head()
male_butterfly %>% summary()
male_butterfly %>% glimpse()
male_butterfly %>% duplicated() %>% sum()

## Here, I check each column of the "female" sub-dataset

female_butterfly %>% head()
female_butterfly %>% summary()
female_butterfly %>% glimpse()
female_butterfly %>% duplicated() %>% sum()

## Here, I use exploratory data analysis to check each subset of the dataset

GGally::ggpairs(male_butterfly)


GGally::ggpairs(female_butterfly)


## Everything is okay!

