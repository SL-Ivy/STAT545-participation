library("tidyverse")
library(here) # to check the current repo
gapminder_csv <- read_csv('./Week 6//cm011/gapminder_sum.csv') 
View(gapminder_csv)

#return a vector of character strings giving the names of the objects in the specified environment. 
ls() 

rm(list=ls()) #to remove all stored objects/vectors, but keep all the loaded packages, or can uncheck all the packages manually/ restar the R

#try to use here here, it don't have problem with / or \
here::here("a", "b","c","gapminder_sum.csv")


