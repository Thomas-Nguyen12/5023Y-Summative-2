library(sjPlot)


#__________________________---- VISUAL MODEL SUMMARIES

## visual model summary for All butterflies
## webshot2 will take a picture of the model summaries and store it as a .png file in Output/Tables

tab_model(butterfly_lsmodel, title="Butterfly Forewing length against June Mean Temperature", file="Output/Tables/butterfly_lsmodel_summary.html")
webshot2::webshot(url="Output/Tables/butterfly_lsmodel_summary.html", file="Output/Tables/butterfly_lsmodel_summary.png", vwidth=400, vheight=300 )


## Visual model summary for Male butterfly linear model

tab_model(male_lsmodel2, title="Male Forewing length against June Mean Temperature. [-26] represents a removed outlier at the 26th datapoint", file="Output/Tables/male_butterfly_lsmodel_summary.html")
webshot2::webshot(url="Output/Tables/male_butterfly_lsmodel_summary.html", "Output/Tables/male_butterfly_lsmodel_summary.png", )


## Visual model summary for Female Butterfly linear model

tab_model(female_lsmodel, title="Female Forewing Length against June Mean Temperature", file="Output/Tables/female_butterfly_lsmodel_summary.html")
webshot2::webshot(url="Output/Tables/female_butterfly_lsmodel_summary.html", file="Output/Tables/female_butterfly_lsmodel_summary.png")