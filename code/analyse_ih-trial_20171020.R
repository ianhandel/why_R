library(tidyverse)
library(knitr)
library(kableExtra) 
library(lme4)

ude_graphics("../images/why-R_presentation_20171130_design/why-R_presentation_20171130_design.001.png")

dat <- read_csv("../data/ih-trial_results_20171020_tidy.csv")


dat %>%
  group_by(treatment) %>% 
  summarise(n = sum(!is.na(age)),
            mean = mean(age),
            median = median(age),
            sd = sd(age),
            min = min(age),
            max = max(age)) %>% 
  ungroup() %>% 
  map_if(is_bare_double, ~round(.x, 2)) %>% 
  as_tibble() %>% 
  kable(caption = "Age by treatment group",
        table.attr = "style='width:30%;'") %>% 
  kable_styling(bootstrap_options = "bordered", full_width = FALSE)

dat %>%
  group_by(treatment) %>% 
  summarise(male = 100 * mean(sex == "male"),
            n = sum(sex == "male")) %>% 
  ungroup() %>% 
  map_if(is_bare_double, ~round(.x)) %>%
  as_tibble() %>% 
  mutate(male = paste0(n, " (",male, " %)")) %>%
  dplyr::select(-n) %>% 
  kable(caption = "Sex by treatment group",
        table.attr = "style='width:30%;'") %>% 
  kable_styling(bootstrap_options = "bordered", full_width = FALSE)


ggplot(dat) +
  aes(week, glucose, group = paste(subject, rep), colour = treatment) +
  geom_point() +
  geom_line(alpha = 0.5) +
  facet_grid(sex ~ treatment) +
  labs(title = "Value vs time by treatment and sex",
       subtitle = "Response greater in A than B?",
       x = "Week",
       y = "glucose (mg/L)") +
  guides(colour = FALSE) +
  theme_bw()

mod <- lmer(glucose ~ treatment * week + age + sex + (1 | subject), data = dat)
sjPlot::sjt.lmer(mod, digits.std = 3)$data %>% 
  as_tibble() %>%
  select(coef.name:std.se1) %>% 
  kable(type = "text")

