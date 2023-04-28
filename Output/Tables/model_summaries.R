library(sjPlot)
library(gtsummary)

#__________________________----

## All butterflies

tab_model(butterfly_lsmodel2, title="Butterfly Forewing length against June Mean Temperature")

## Male butterflies

tab_model(male_lsmodel2, title="Male Forewing length against June Mean Temperature. [-26] represents a removed outlier at the 26th datapoint")

## Female Butterflies

tab_model(female_lsmodel, title="Female Forewing Length against June Mean Temperature")
