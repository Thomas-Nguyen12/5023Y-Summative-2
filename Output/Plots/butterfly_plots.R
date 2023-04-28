library(ggExtra)
library(ggplot2)
library(kableExtra)
library(ggthemes)
library(colorBlindness)
library(sjPlot)
library(gtsummary)
tbl_regression(male_lsmodel2)
## Do colourblind check
#__________________________----
## PLOTS ----

## All butterfly plot

p <- butterfly %>% ggplot(aes(june_mean_temperature, forewing_length)) + 
  geom_point(aes(colour=sex)) + 
  geom_smooth(aes(colour=sex), level=0.95, method="lm", linetype="dashed") + 
  theme_stata() + 
  stat_cor(method="pearson", aes(colour=sex), label.y=c(15.5, 15.35), p.accuracy=0.001, r.accuracy=0.001) +
  labs(x="June Mean Temperature (celsius)", y = "Forewing Length (cm)", title="Butterfly Forewing Length against June Mean Temperature") +
  stat_regline_equation(label.y=c(15.5, 15.35), label.x=13.3, aes(colour=sex)) +
  theme(legend.position='bottom', 
        legend.justification='right',
        legend.direction='horizontal') 
  
ggExtra::ggMarginal(p, type = "density", groupColour = TRUE, groupFill=TRUE) 
## Checking colours against colorblindness
cvdPlot(p)

#__________________________----

p1 <- butterfly_lsmodel2_tibble %>% ggplot(aes(june_mean_temperature, forewing_length)) + geom_point() + 
  geom_smooth(level=0.95, method="lm", linetype="dashed") + 
  theme_stata() + 
  stat_cor(method="pearson", label.y=c(15.5)) +
  labs(x="June Mean Temperature (celsius)", y = "Forewing Length (cm)", title="Butterfly Forewing Length against June Mean Temperature") +
  stat_regline_equation(label.y=15.5, label.x=13.3) +
  theme(legend.position='bottom', 
        legend.justification='right',
        legend.direction='horizontal') 
ggExtra::ggMarginal(p1, type = "density", fill="grey") 

## Checking plots for colour-blindness
cvdPlot(p1)
#__________________________----

## male linear model Plot

p2 <- male_lsmodel2_tibble %>% ggplot(aes(june_mean_temperature, forewing_length)) + 
  geom_point() +
  geom_smooth(method="lm", level=0.95, linetype="dashed") +
  theme_stata() +
  stat_cor(method="pearson", p.accuracy=0.001, r.accuracy=0.001) +
  labs(x="June Mean Temperature (celsius)", y = "Forewing Length (cm)", title="Male Forewing Length against Mean Temperature") +
  stat_regline_equation(label.y=13.88, label.x=13)
ggExtra::ggMarginal(p2, type="density", fill="grey")

## Checking plots for colour-blindness
cvdPlot(p2)


#__________________________----

## Female linear model plot

p3 <- female_lsmodel %>% ggplot(aes(june_mean_temperature, forewing_length)) + 
  geom_point() +
  geom_smooth(method="lm", level=0.95, linetype="dashed") +
  theme_stata() +
  stat_cor(method="pearson", p.accuracy=0.001, r.accuracy=0.001) +
  labs(x="June Mean Temperature (celsius)", y = "Forewing Length (cm)", title="Female Butterfly Forewing Length against June Mean Temperature") +
  stat_regline_equation(label.y=14.65, label.x=11.8)
ggExtra::ggMarginal(p3, type="density", fill="grey")

## Checking plots for colourblindness
cvdPlot(p3)

