## ----setup, include=FALSE------------------------------------------------
library(tidyverse)
library(stringr)
library(forcats)
library(readxl)
library(knitr)
library(kableExtra) # striping
knitr::opts_chunk$set(echo = TRUE, comment = "")

## ------------------------------------------------------------------------
dat <- read_excel("../data/ih-trial_results_20171020.xlsx", sheet = 1)

## ------------------------------------------------------------------------
dat <- dat %>% 
  fill(sex, age, treatment)

## ------------------------------------------------------------------------
dat <- dat %>% 
  mutate(subject = paste0("A", str_pad(subject, 3, "left", "0")))

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
  tidyr::separate(sex, c("sex", "neuter_status"), 1)

## ---- results='asis', echo=FALSE-----------------------------------------
dat %>% show_df()

## ---- size=0.1-----------------------------------------------------------
dat <- dat %>%
  mutate(age = case_when(
                    str_detect(age, "month") ~ parse_number(age) / 12,
                    TRUE ~ parse_number(age)))

## ------------------------------------------------------------------------
dat <- dat %>%
  tidyr::gather("week", "value", `week 1`:`week 4`) %>% 
  mutate(week = parse_number(week))

## ---- results='asis', echo=FALSE-----------------------------------------
dat %>% show_df()

## ---- fig.height=3-------------------------------------------------------
ggplot(dat, aes(x = value)) +
  geom_histogram(binwidth = 5) +
  coord_cartesian(ylim = c(0, 10)) + 
  labs(title = "Quick histogram of all values",
       subtitle = "NB: y axis truncated")

## ------------------------------------------------------------------------
dat %>% 
  dplyr::filter(value > 50) %>% 
  dplyr::select(subject, week, rep, value) %>% 
  kable(format = "html")

## ------------------------------------------------------------------------

dat <- dat %>%
  mutate(value = case_when(subject == "A006" &
                             week == 1 &
                             rep == 2 ~         6.04,
                           
                           subject == "A012" &
                             week == 2 &
                             rep == 2 ~         7.76,
                           
                           subject == "A012" &
                             week == 3 &
                             rep == 1 ~         7.23,
                           
                           subject == "A003" &
                             week == 4 &
                             rep == 2 ~         4.08,
                           
                           subject == "A004" &
                             week == 4 &
                             rep == 1 ~         7.37,
                           
                           TRUE ~               value))
  

## ------------------------------------------------------------------------
write_csv(dat, "../data/ih-trial_results_20171020_tidy.csv")

