library(ggExtra)
library(ggplot2)
library(ggthemes)
library(colorBlindness)


## Do colourblind check
#__________________________----
## PLOTS ----


#__________________________----

## All butterfly plot
p2 <- butterfly %>% ggplot(aes(june_mean_temperature, forewing_length)) + geom_point() + 
  geom_smooth(level=0.95, method="lm", linetype="dashed") + 
  theme_stata() + 
  stat_cor(method="pearson", label.y=c(15.5)) +
  labs(x="June Mean Temperature (celsius)", y = "Forewing Length (cm)", title="Butterfly Forewing Length against June Mean Temperature") +
  stat_regline_equation(label.y=15.5, label.x=13.3) +
  theme(legend.position='bottom', 
        legend.justification='right',
        legend.direction='horizontal')  
p2 <- ggExtra::ggMarginal(p2, type = "density", fill="grey") 
## Checking plots for colour-blindness
cvdPlot(p2)

## saving the plot
ggsave("02_butterfly_linear_model.png", plot=p2, path="Output/Plots", dpi=1000, width=10, height=10)

#__________________________----

## male linear model Plot

p3 <- male_lsmodel2_tibble %>% ggplot(aes(june_mean_temperature, male_forewing_length)) + 
  geom_point() +
  geom_smooth(method="lm", level=0.95, linetype="dashed") +
  theme_stata() +
  stat_cor(method="pearson", p.accuracy=0.001, r.accuracy=0.001) +
  labs(x="June Mean Temperature (celsius)", y = "Forewing Length (cm)", title="Male Forewing Length against Mean Temperature") +
  stat_regline_equation(label.y=13.88, label.x=13) 
p3 <- ggExtra::ggMarginal(p3, type="density", fill="grey")

## Checking plots for colour-blindness
cvdPlot(p3)

ggsave("03_male_buterfly_linear_model.png", plot=p3,  path="Output/Plots", dpi=1000, width=10, height=10)

#__________________________----

## Female linear model plot

p4 <- female_butterfly %>% ggplot(aes(june_mean_temperature, forewing_length)) + 
  geom_point() +
  geom_smooth(method="lm", level=0.95, linetype="dashed") +
  theme_stata() +
  stat_cor(method="pearson", p.accuracy=0.001, r.accuracy=0.001) +
  labs(x="June Mean Temperature (celsius)", y = "Forewing Length (cm)", title="Female Butterfly Forewing Length against June Mean Temperature") +
  stat_regline_equation(label.y=15, label.x=11.8) 
p4 <- ggExtra::ggMarginal(p4, type="density", fill="grey")

## Checking plots for colourblindness
cvdPlot(p4)

## Saving the plot
ggsave("04_female_linear_model.png", path="Output/Plots", plot=p4, width=10, height=10, dpi=1000)

## Plot for comparing forewing length in Males and Females
p5 <- butterfly %>% ggplot(aes(sex, forewing_length)) + geom_jitter(aes(colour=sex)) + theme_stata() + xlab("sex") + ylab("forewing length (cm)") + ggtitle("Forewing Length Comparison between Males and Females") + geom_bracket(xmin="female", xmax="male", y.position=15.2, label="Two sample t-test, p < 0.05") + geom_boxplot(aes(colour=sex), alpha=0) 
p5 <- ggExtra::ggMarginal(p5, type="density", groupFill = TRUE)
cvdPlot(p5)
ggsave("05_forewing_length_comparison.png", path="Output/Plots", plot=p5, width=10, height=10, dpi=1000)

