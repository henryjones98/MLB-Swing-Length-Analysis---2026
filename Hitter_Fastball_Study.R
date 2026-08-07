### Model Regressions and Comparison ###

Run_Value_Model <- lm(Run_Value ~ Avg_Bat_Speed + 
                        Hard_Swing_Percentage + 
                        Swing_Length + 
                        Swing_Tilt + 
                        Attack_Angle +
                        Attack_Direction +
                        Contact_Point_vs_Batter, data = Hitters_vs_Fastballs_NoDuplicates)
summary(Run_Value_Model)

xwOBA_Model <- lm(xwOBA ~ Avg_Bat_Speed + 
                        Hard_Swing_Percentage + 
                        Swing_Length + 
                        Swing_Tilt + 
                        Attack_Angle +
                        Attack_Direction +
                        Contact_Point_vs_Batter, data = Hitters_vs_Fastballs_NoDuplicates)
summary(xwOBA_Model)

Hard_Hit_Rate_Model <- lm(Hard_Hit_Percentage ~ Avg_Bat_Speed + 
                    Swing_Length + 
                    Swing_Tilt + 
                    Attack_Angle +
                    Attack_Direction +
                    Contact_Point_vs_Batter, data = Hitters_vs_Fastballs_NoDuplicates)
summary(Hard_Hit_Rate_Model)

Whiff_Percentage_Model <- lm(Whiff_Percentage ~ Avg_Bat_Speed + 
                    Hard_Swing_Percentage + 
                    Swing_Length + 
                    Swing_Tilt + 
                    Attack_Angle +
                    Attack_Direction +
                    Contact_Point_vs_Batter, data = Hitters_vs_Fastballs_NoDuplicates)
summary(Whiff_Percentage_Model)

install.packages(gtsummary)
install.packages("modelsummary")
library(gtsummary)
library(modelsummary)

my_models <- list(
  "Run Value" = Run_Value_Model,
  "Expected On-Base" = xwOBA_Model,
  "Hard Hit Rate" = Hard_Hit_Rate_Model,
  "Whiff %" = Whiff_Percentage_Model
)

modelsummary(my_models)
modelsummary(my_models, stars = c('*' = .1, '**' = .05, '***' = .01))

### Comparison of Bat speed vs. Swing Length and how it impacts Hard Contact Percentage vs. Fastballs ###

library(ggplot2)
installed.packages("ggpubr")
library(ggpubr)
BatSpeed_SwingLength_Plot <- ggplot(data = Hitters_vs_Fastballs, aes(x = Swing_Length, y = Avg_Bat_Speed, color = Hard_Hit_Percentage)) + 
  geom_point(size = 3.5) + scale_color_gradient(low = "blue", high = "red") +
  geom_smooth(method = "lm", color = "#e74c3c", se = FALSE) + 
  stat_cor(aes(label = ..rr.label..), label.x = 5.75, label.y = 74.5)
BatSpeed_SwingLength_Plot

### Pivot Table categorizing how Swing Length and Attack Angle impact Hard Contact vs. Fastballs ###

install.packages("tidyverse")
library(tidyverse)

install.packages("pivottabler")
library(pivottabler)
pt <- PivotTable$new()
pt$addData(Hitters_vs_Fastballs_NoDuplicates)
pt$addColumnDataGroups("Swing_Length_Category")
pt$addRowDataGroups("Attack_Angle_Category")
pt$defineCalculation(calculationName = "Hard Hit %", summariseExpression = "round(mean(Hard_Hit_Percentage, mean.rm = TRUE), digits = 1)")
pt$renderPivot()