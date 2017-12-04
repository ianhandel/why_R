# Import data from ian's dug trial 20171020 and tidy / clean / export
# 
# Ian Handel
# 


library(tidyverse)
library(stringr)
library(forcats)
library(readxl)
library(knitr)


dat <- read_excel("data/ih-trial_results_20171020.xlsx",
                  sheet = 1) %>% 
  fill(sex, age, treatment) %>% 
  mutate(subject = str_c("A", str_pad(subject, 3, "left", "0"))) %>%
  mutate(sex = case_when(sex == "female nneutered" ~ "fn",
                         sex == "male entire" ~ "me",
                         sex == "MN" ~ "mn",
                         TRUE ~ sex)) %>% 
  separate(sex, c("sex", "neuter_status"),sep = 1) %>% 
  mutate(sex = fct_recode(sex,
                            male = "m",
                            female = "f"),
         neuter_status = fct_recode(neuter_status,
                                      neutered = "n",
                                      entire = "e")) %>%
  mutate(age = case_when(
                    str_detect(age, "month") ~ parse_number(age) / 12,
                    TRUE ~ parse_number(age))) %>%
  gather("week", "glucose", `week 1`:`week 4`) %>% 
  mutate(week = parse_number(week)) %>% 
  mutate(glucose = case_when(subject == "A006" &
                             week == 1 &
                             rep == 2 ~         1.62,
                           
                           subject == "A012" &
                             week == 2 &
                             rep == 2 ~         7.76,
                           
                           subject == "A012" &
                             week == 3 &
                             rep == 1 ~         11.78,
                           
                           subject == "A003" &
                             week == 4 &
                             rep == 2 ~         9.35,
                           
                           subject == "A004" &
                             week == 4 &
                             rep == 1 ~         16.54,
                           
                           TRUE ~               glucose))
  
write_csv(dat, "data/ih-trial_results_20171020_tidy.csv")

