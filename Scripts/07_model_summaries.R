library(sjPlot)
library(kableExtra)
library(magick)
#__________________________----

## All butterflies

tab_model(butterfly_lsmodel, title="Butterfly Forewing length against June Mean Temperature", file="Output/Tables/butterfly_lsmodel_summary.html")
webshot2::webshot(url="Output/Tables/butterfly_lsmodel_summary.html", file="Output/Tables/butterfly_lsmodel_summary.png", vwidth=400, vheight=300 )


## Male butterflies

tab_model(male_lsmodel2, title="Male Forewing length against June Mean Temperature. [-26] represents a removed outlier at the 26th datapoint", file="Output/Tables/male_butterfly_lsmodel_summary.html")
webshot2::webshot(url="Output/Tables/male_butterfly_lsmodel_summary.html", "Output/Tables/male_butterfly_lsmodel_summary.png", )
## Female Butterflies

tab_model(female_lsmodel, title="Female Forewing Length against June Mean Temperature", file="Output/Tables/female_butterfly_lsmodel_summary.html")
webshot2::webshot(url="Output/Tables/female_butterfly_lsmodel_summary.html", file="Output/Tables/female_butterfly_lsmodel_summary.png")