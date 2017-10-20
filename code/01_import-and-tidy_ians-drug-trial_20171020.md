Ians drug trial analysis
================

Import and tidy data
====================

``` r
dat <- readxl::read_excel("../data/ians-drug-trial_biochemistry-results_20171020.xls", sheet = 1) %>% 
  
  skimr::skim()
```
