hmk_02
================
Elaine M. Wright

## Homework \#2

Here is the loaded library with the chunk option to hide the text that
generates when the library loads into this R session!

``` r
library(tidyverse)
```

Values are assigned to objects ‘a’ and ‘b’ and are then compared

``` r
a <- 5
b <- 9
a > b
```

    [1] FALSE

The ls functions shows us the objects in the global environment!

``` r
ls(environment())
```

    [1] "a" "b"

The rm function clears the global environment/workspace

``` r
rm(list=ls())
```

The ls function is used again to show that the environment/work space
has been cleared successfully!

``` r
ls(environment())
```

    character(0)
