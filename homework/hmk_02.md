hmk_02
================
Elaine M. Wright

## Homework \#2

Here is the loaded library with the chunk option to hide the text that
generates when the library loads into this R session!

``` r
library(tidyverse)

a <- 5
b <- 9
a > b
```

    [1] FALSE

``` r
ls(environment())
```

    [1] "a" "b"

``` r
rm(list=ls())
```

``` r
ls(environment())
```

    character(0)
