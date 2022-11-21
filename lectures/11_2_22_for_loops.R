# lecture 2 Nov 22
library(tidyverse)


multiply <- function(x, y) {
  # test the inputs
  # if(!is.numeric(x) | !is.numeric(y)) {
  #   return(NA)
  # }
  
  # do the math
  # This tryCatch syntax is incorrect
  z <- tryCatch({
    x * y,
    warning = function(w) "There was a warning",
    error = function(e) paste("You can't multiply ", x, "by", y)
  })
  
  z
}

# Iteration

a <- 1:10
b <- rnorm(n=10, mean=3, sd = 2)
a + b 

c <- a[1] + b[1]
c[2] <- a[2] + b[2]

d <- as.double(rep(NA, length(a))) # initialize our results vector
for(i in 1:length(a)) {
  print(i)
  d[i] <- a[i] + b[i]
}
print(d)

# slightly safer way
d <- vector(length=0)
for(i in seq_along(a)) {
  print(i) # body of the loop
  d[i] <- a[i] + b[i]
}
print(seq_along(a))

# Write a for loop that calculates the mean
# of every column in mtcars
# and puts the result into a vector
# Extra credit: make the vector be named
# The names will be the names of the columns






df <- tibble(
  a=rnorm(10),
  b=rnorm(10),
  c=rnorm(10),
  d=rnorm(10)
)