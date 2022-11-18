library(tidyverse)
# using RDS file to share a "binary" of 
tabel1 <- readRDS("C:\\Users\\elain\\Documents\\GitHub\\data475\\lectures\\table1.RDS")
glimpse(tabel1)

tabel1_long <- tabel1 %>% 
  pivot_longer(c(cases, population), 
               names_to = "parameter",
               values_to = "number")
glimpse(tabel1_long)

ggplot(tabel1_long, aes(x = year, y = number,
                        color = parameter))+
  geom_line() +
  facet_wrap(~country)

library(nycflights13)
