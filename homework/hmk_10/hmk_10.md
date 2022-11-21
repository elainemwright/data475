Homework 10: Decisions & Loops
================
Elaine M. Wright

# Decisions

Write a function that accepts the current time as a parameter and prints
“Good morning”, “Good afternoon”, or “Good evening” depending on the
time. It is fine for the time to be in numeric format (e.g., `2317` for
11:17 pm). Bonus points if the function accepts time objects (see the
`lubridate` package).

``` r
library(tidyverse)

greeting <- function(time){
    if (time > 0 & time < 1200){
        print("Good Morning")} 
    else if (time >= 1200 & time < 1800){
      print("Good Afternoon")}
    else if (time > 2401 | time < 0){
      print("Please enter a valid time")}
    else {
      print("Good Evening")}
    }

greeting(1200)
```

    [1] "Good Afternoon"

``` r
greeting(0600)
```

    [1] "Good Morning"

``` r
greeting(0000)
```

    [1] "Good Evening"

``` r
greeting(2600)
```

    [1] "Please enter a valid time"

``` r
greeting(-10)
```

    [1] "Please enter a valid time"

-   The purpose of this function is to print a message to the console,
    so its primary purpose is a **side effect**. However, all functions
    must return something. What would be a logical value for this
    function to return?
    -   I’m not sure how to actually write this in the code just yet,
        but I think a logical value for this function to return would be
        a True or False dependent upon whether the function successfully
        prints the correct message to the console.
-   Should the function have default behavior in case the user does not
    pass an argument?
    -   My initial thought for a default behavior would be to prompt the
        user for an argument if the user does not pass an argument the
        first time using the function. Again, I’m not certain how to
        implement this idea into the code, so far in my testing I
        haven’t been able to figure this out, but I’m hoping I can soon!
        If my understanding is correct I think this is more of an ‘error
        handling’ situation.
-   What would you like to happen if this function is passed the wrong
    data type (e.g., a negative number)?
    -   To mitigate this, I made an `else if` statements that set
        “bounds” for the numbers input into the function. The statement
        returns the phrase “Please enter a valid time” to any value
        entered that is less than zero or greater than 2400.

# Loops

1.  Write a `for` loops that calculates the mean of each column of
    mtcars

``` r
library(tidyverse)

df <- mtcars

means <- vector("double", length = ncol(df))

for (i in 1:ncol(df)){
  if (is.numeric(df[[i]])) {
    means[i] <- mean(df[[i]]) 
  }
}

print(means)
```

     [1]  20.090625   6.187500 230.721875 146.687500   3.596563   3.217250
     [7]  17.848750   0.437500   0.406250   3.687500   2.812500

2.  Write a function (using a for loop) that calculates the mean of all
    numeric columns of *any* data frame. This function should be able to
    accept data frames with non-numeric columns.

``` r
library(tidyverse)

mean_any_df <- function(df) {
  
  numeric_only <- select_if(df, is.numeric)
  
  mean_df <- vector("double", length = ncol(numeric_only))
  
  for (i in seq_along(numeric_only)){
    mean_df[i] <- mean(numeric_only[[i]])
  }
  names(mean_df) <- colnames(numeric_only)
  
  mean_df
}

mean_any_df(diamonds)
```

           carat        depth        table        price            x            y 
       0.7979397   61.7494049   57.4571839 3932.7997219    5.7311572    5.7345260 
               z 
       3.5387338 

## Why not loops?

According to our textbook, for loops are a great way to deliberately
iterate in an obviously and clear way. However, for loops require lots
of repeated code within each loop. Vectorized functions are encouraged
because it offers a way to use patterns in a way that every loop has its
own function, which results in higher efficiency and less error.
