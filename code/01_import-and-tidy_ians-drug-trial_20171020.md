Ians drug trial analysis
================

Import and tidy data
====================

``` r
dat <- readxl::read_excel("../data/ians-drug-trial_biochemistry-results_20171020.xls", sheet = 1) %>% 
  
  skimr::skim() %>% 
  print()
```

    ## Skim summary statistics
    ##  n obs: 36 
    ##  n variables: 9 
    ## 
    ## Variable type: character 
    ##         var missing complete  n min max empty n_unique
    ## 1       age      24       12 36   1   8     0        9
    ## 2       sex      24       12 36   2  16     0        5
    ## 3 treatment      24       12 36   1   1     0        2
    ## 
    ## Variable type: numeric 
    ##       var missing complete  n  mean     sd  min  p25 median  p75 max
    ## 1     rep       0       36 36  2      0.83 1    1      2    3      3
    ## 2 subject       0       36 36  6.5    3.5  1    3.75   6.5  9.25  12
    ## 3  week 1       0       36 36 22.38  99.74 0.34 4.07   5.78 7.88 604
    ## 4  week 2       0       36 36 27.8  128.29 0.4  5.24   6.89 8.54 776
    ## 5  week 3       0       36 36 26.56 119.42 1.85 4.27   6.77 9.06 723
    ## 6  week 4       0       36 36 38.57 137.11 0.93 6.05   7.49 9.35 737
    ##       hist
    ## 1 ▇▁▁▇▁▁▁▇
    ## 2 ▇▃▇▃▃▇▃▇
    ## 3 ▇▁▁▁▁▁▁▁
    ## 4 ▇▁▁▁▁▁▁▁
    ## 5 ▇▁▁▁▁▁▁▁
    ## 6 ▇▁▁▁▁▁▁▁
