---
output:
  pdf_document: default
  html_document: default
---
# "Analysis of *Hesperia Comma*, the Silver spotted Skipper and their responses to climate change" - 5023y Summative-2

## Project description: 

This project analyses how Hesperia comma butterflies respond to climate change, specifically temperature variations. I hypothesised a positive linear relationship between June temperatures and the *Hesperia comma* forewing length because juvenile hormones, ecdysteroids, and other signalling molecules are critical for proper growth and development in butterfly genes involved in growth and development. I found a significant positive linear relationship across butterflies as a whole and June mean temperature as well as in male butterflies. I did not find the same in Female butterflies.

I faced challenges with certain repeated values in the "year" column, having to check if these values interferred with the analysis. Fortunately, repeated years represented Male and Female butterflies being measured in the same year. Additionally, the dataset was relatively small, allowing only so much representation.

I hope to include more tidy data in the future, allowing me to see if there are any additional significant interaction terms and to validate my current results.

### How to use:

This project uses R version 4.2.3.

Additionally, This study uses R packages: tidyverse, for data importing, data tidying, exploratory data analysis, and data wrangling; ggpubr for visual model summaries; ISLR to spot anomalies using cook's distance; ggExtra to display additional graphics; GGally for scatter matrices; performance to create model checking plots; MASS to produce model checking boxcox plots; KableExtra and gt to produce model tables; ggthemes for ggplot themes; colorblindr to test for colour blindness; and sjplot to create model summary tables; webshot2 to produce a visual model summary table images; knitr and rmarkdown to produce a Rmarkdown document. I obtained the data by collecting museum samples of the Silver Spotted Skipper and comparing them against the measured weather data of each year.

All relevant files are located wtihin the Cloud/project folder.

> Data can be found within the Data/ folder called "univoltine_butterfly.csv"

R scripts are located in the Scripts/ folder. They are numbered to show the order of which to run them.

> All Tables and graphs used within the Rmarkdown file are located within the Output/Tables and Output/Plots folders.

## Project Structure

This is the basic project structure
```
.
├── Data
├── Examples
├── img
├── Output
│   ├── Plots
│   └── Tables
└── Scripts

```
This is the <b>full</b> project structure. <b>Note that this repository allowed the choice of different datasets (within Data/) and I chose the univoltine_butterfly.csv dataset.</b>

```
./
├── 5023Y-Summative-2.Rproj
├── Assignment_Brief_Summative_2.html
├── Assignment_Brief_Summative_2.Rmd
├── Assignment-002.html
├── butterfly.png
├── Data/
│   ├── cricket_song.csv
│   ├── elegans_offspring.xlsx
│   └── univoltine_butterfly.csv   # I analysed this dataset
├── Examples/
│   ├── analysis.R
│   ├── example paper 1.pdf
│   ├── example paper 2.pdf
│   ├── Felix et al 2012.pdf
│   ├── Li et al 2016.pdf
│   ├── Meuthen et al 2021.pdf
│   ├── Psalti et al 2021.pdf
│   └── Titanosaur.csv
├── img/
│   ├── analysis.png
│   ├── fly.png
│   ├── reporting.png
│   └── Rplot01.png
├── Output/    # the set of outputs that resulted from my analysis of the univoltine_butterfly.csv dataset
│   ├── Plots/
│   │   ├── 01_butterfly_split_sex_linear_model.png
│   │   ├── 02_butterfly_linear_model.png
│   │   ├── 03_male_buterfly_linear_model.png
│   │   ├── 04_female_linear_model.png
│   │   ├── 05_forewing_length_comparison.png
│   │   └── butterfly_plots.R
│   └── Tables/
│       ├── butterfly_lsmodel_summary.html
│       ├── butterfly_lsmodel_summary.png
│       ├── female_butterfly_lsmodel_summary.html
│       ├── female_butterfly_lsmodel_summary.png
│       ├── female_lsmodel_summary.html
│       ├── male_butterfly_lsmodel_summary.html
│       ├── male_butterfly_lsmodel_summary.png
│       └── model_summaries.R
├── README.html
├── README.md
├── README.pdf
├── report.pdf    # my report in pdf format
├── report.Rmd    # my Rmarkdown report
└── Scripts/    # the full set of analytical scripts I created
    ├── 01_import_unvoltine_butterfly_data.R
    ├── 02_tidy_univoltine_butterfly_data.R
    ├── 03_exploratory_analysis.R
    ├── 04_male_butterfly_linear_model.R
    ├── 05_female_butterfly_linear_model.R
    ├── 06_butterfly_plots.R
    └── 07_model_summaries.R

```





## Credits:
This was a solo project.
I used 'freecodecamp.org' for tutorials on how to write this README.md file and "w3schools.com" scripting tutorials.

