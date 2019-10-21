# Arithmetic
number * 2
number <- 5 + 2
number * 2
a * 2

# Vectors

(times <- c(60, 40, 33, 15, 20, 55, 35)) # Combine Values into a Vector or List
times / 60 # operations happen component-wise

# Functions
# function won't change the input
mean(times) # returned value is scalar, average for all elements
sqrt(times) # computes the (principal) square root of each element
range(times) # returns a vector containing the minimum and maximum of all the given arguments

# Comparisons
times < 30 # Logical vector. Return FALSE for all elements >= 30, TRUE for elements < 30.
times == 20 # Logical vector. Return FALSE for all elements not equal to 20, TRUE for elements =20.
times != 20 # Logical vector. Return FALSE for all elements equal to 20, TRUE for elements not equal to 20.
times > 20 & times < 50 # Logical vector. Return TRUE for elements meet both requirements joined by the `&`, FALSE for any other situations.
times < 20 | times > 50 # Logical vector. Return TRUE for elements meet either requirements joined by the `|`, return FALSE if not meet either requirement.
sum(times < 30) # reTRUEn number of elememts meet the requirment (<30)
a <- all(times < 30) #TRUE if all elements in times are less than 30.

# Subsetting:
times[3] # the 3rd element in times
times[-3] # except the 3rd element in times
times[c(2, 4)] #the 2nd and 4th
times[c(4, 2)]
times[1:5] # the 1-5th elements
times[times < 30]
times
times[times > 50] <- 50 # replace all the elements in times that larger than 50 with 50.
times[8] <- NA
times
mean(times, na.rm = TRUE) # a logical value indicating whether NA values should be stripped before the computation proceeds.
mean(times, 0, TRUE) # mean(x, trim = 0, na.rm = FALSE, ...)
mean(na.rm = TRUE, x = times) #specify each argument
?mean

mtcars
str(mtcars) # structure
names(mtcars) # list the name for each column
mtcars$mpg # The $ allows you extract elements by name from a named list
