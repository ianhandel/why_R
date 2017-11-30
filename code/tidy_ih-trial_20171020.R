## ----setup, include=FALSE------------------------------------------------
library(tidyverse)
library(stringr)
library(forcats)
library(readxl)
library(knitr)
library(kableExtra) # striping
knitr::opts_chunk$set(echo = TRUE, comment = "")

## ---- warning=FALSE------------------------------------------------------
dat <- read_excel("../data/ih-trial_results_20171020.xlsx", sheet = 1)

## ------------------------------------------------------------------------
dat <- dat %>% 
  fill(sex, age, treatment)

## ------------------------------------------------------------------------
dat <- dat %>% 
  mutate(subject = str_c("A", str_pad(subject, 3, "left", "0")))

## ------------------------------------------------------------------------
dat %>%
  group_by(sex) %>%
  tally() %>% 
  kable(format = "html")

## ------------------------------------------------------------------------
dat <- dat %>%
  mutate(sex = case_when(sex == "female nneutered" ~ "fn",
                         sex == "male entire" ~ "me",
                         sex == "MN" ~ "mn",
                         TRUE ~ sex))

## ------------------------------------------------------------------------
dat <- dat %>% 
  separate(sex, c("sex", "neuter_status"), 1)

## ------------------------------------------------------------------------
dat <- dat %>% 
  mutate(sex = fct_recode(sex, male = "m", female = "f"),
         neuter_status = fct_recode(neuter_status, neutered = "n", entire = "e"))


## ---- size=0.1-----------------------------------------------------------
dat <- dat %>%
  mutate(age = case_when(
                    str_detect(age, "month") ~ parse_number(age) / 12,
                    TRUE ~ parse_number(age)))

## ------------------------------------------------------------------------
dat <- dat %>%
  gather("week", "value", `week 1`:`week 4`) %>% 
  mutate(week = parse_number(week))

## ---- fig.height=3-------------------------------------------------------
ggplot(dat, aes(x = value)) +
  geom_histogram(binwidth = 5) +
  coord_cartesian(ylim = c(0, 10))

## ------------------------------------------------------------------------
dat %>% 
  filter(value > 50) %>% 
  select(subject, week, rep, value) %>% 
  kable(format = "html")

## ------------------------------------------------------------------------

dat <- dat %>%
  mutate(value = case_when(subject == "A006" &
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
                           
                           TRUE ~               value))
  

## ------------------------------------------------------------------------
write_csv(dat, "../data/ih-trial_results_20171020_tidy.csv")

