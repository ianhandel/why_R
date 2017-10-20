# make some data foe my R and Excel talk

library(tidyverse)

N = 12
n_weeks = 4
n_reps = 3
n_silly = 5

set.seed(11)

dat <- tibble(subject = 1:N,
              sex = sample(c("mn", "fn", "MN", "female nneutered", "male neutered", "male entire"), N, replace = TRUE),
              age = sample(c(1:12, "6 months", "9 months"), N, replace = TRUE),
              treatment = rep(c("A", "B"), times = N/2),
              dummy= 1) %>% 
  inner_join(expand.grid(week = 1:n_weeks, rep = 1:n_reps) %>% mutate(dummy = 1)) %>% 
  dplyr::select(- dummy) %>% 
  mutate(value = sqrt(week * 2) + grepl("n", sex) + (treatment == "B") * 3 + rnorm(N * n_reps * n_weeks, rep , 2),
         value = round(value, 2),
         row = 1:n()) %>% 
  mutate(value = case_when(row %in% c(sample(1:n(), n_silly)) ~ value * 100,
                           TRUE ~ value))

  
  
# ggplot(dat, aes(x = week, y = value, group = paste(subject, rep), colour = treatment)) +
#   geom_line() +
#   facet_grid(rep ~ sex)

dat <- dat %>%
  dplyr::select(- row) %>% 
  mutate(week = paste0("week ", week)) %>% 
  spread(week, value, ) %>% 
  group_by(subject) %>% 
  mutate(sex = case_when(rep == 1 ~ sex,
                             TRUE ~ "")) %>% 
  ungroup() %>% 
  mutate(age = case_when(sex == "" ~ "",
                         TRUE ~ age),
         treatment = case_when(sex == "" ~ "",
                               TRUE ~ treatment)) %>% 

write_csv("data/ians-drug-trial_biochemistry-results_20171020.csv")
