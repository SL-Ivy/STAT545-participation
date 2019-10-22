---
title: "cm009 Exercises: tidy data"
output: 
  html_document: 
    keep_md: yes
editor_options: 
  chunk_output_type: inline
---


```r
library(tidyverse)
lotr  <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/lotr_tidy.csv")
guest <- read_csv("https://raw.githubusercontent.com/STAT545-UBC/Classroom/master/data/wedding/attend.csv")
email <- read_csv("https://raw.githubusercontent.com/STAT545-UBC/Classroom/master/data/wedding/emails.csv")
```

<!---The following chunk allows errors when knitting--->



## Exercise 1: Univariate Pivoting

Consider the Lord of the Rings data:


```r
lotr
```

```
## # A tibble: 18 x 4
##    Film                       Race   Gender Words
##    <chr>                      <chr>  <chr>  <dbl>
##  1 The Fellowship Of The Ring Elf    Female  1229
##  2 The Fellowship Of The Ring Hobbit Female    14
##  3 The Fellowship Of The Ring Man    Female     0
##  4 The Two Towers             Elf    Female   331
##  5 The Two Towers             Hobbit Female     0
##  6 The Two Towers             Man    Female   401
##  7 The Return Of The King     Elf    Female   183
##  8 The Return Of The King     Hobbit Female     2
##  9 The Return Of The King     Man    Female   268
## 10 The Fellowship Of The Ring Elf    Male     971
## 11 The Fellowship Of The Ring Hobbit Male    3644
## 12 The Fellowship Of The Ring Man    Male    1995
## 13 The Two Towers             Elf    Male     513
## 14 The Two Towers             Hobbit Male    2463
## 15 The Two Towers             Man    Male    3589
## 16 The Return Of The King     Elf    Male     510
## 17 The Return Of The King     Hobbit Male    2673
## 18 The Return Of The King     Man    Male    2459
```

1. Would you say this data is in tidy format?
Each row is an observation; Each column is a variable; Each cell is a value.
It means each value belongs to exactly one variable and one observation.
There are mutiple rows for same film, but each value for the race, geneder, words belongs to exactly one variable (film).

2. Widen the data so that we see the words spoken by each race, by putting race as its own column.


```r
(lotr_wide <- lotr %>% 
  pivot_wider(id_cols = c(-Race, -Words), 
              names_from = Race, 
              values_from = Words))
```

```
## # A tibble: 6 x 5
##   Film                       Gender   Elf Hobbit   Man
##   <chr>                      <chr>  <dbl>  <dbl> <dbl>
## 1 The Fellowship Of The Ring Female  1229     14     0
## 2 The Two Towers             Female   331      0   401
## 3 The Return Of The King     Female   183      2   268
## 4 The Fellowship Of The Ring Male     971   3644  1995
## 5 The Two Towers             Male     513   2463  3589
## 6 The Return Of The King     Male     510   2673  2459
```

3. Re-lengthen the wide LOTR data from Question 2 above.


```r
lotr_wide %>% 
  pivot_longer(cols = c(-Film, -Gender), # - sign means those col won't be changed
               names_to  = "Race", 
               values_to = "Words")
```

```
## # A tibble: 18 x 4
##    Film                       Gender Race   Words
##    <chr>                      <chr>  <chr>  <dbl>
##  1 The Fellowship Of The Ring Female Elf     1229
##  2 The Fellowship Of The Ring Female Hobbit    14
##  3 The Fellowship Of The Ring Female Man        0
##  4 The Two Towers             Female Elf      331
##  5 The Two Towers             Female Hobbit     0
##  6 The Two Towers             Female Man      401
##  7 The Return Of The King     Female Elf      183
##  8 The Return Of The King     Female Hobbit     2
##  9 The Return Of The King     Female Man      268
## 10 The Fellowship Of The Ring Male   Elf      971
## 11 The Fellowship Of The Ring Male   Hobbit  3644
## 12 The Fellowship Of The Ring Male   Man     1995
## 13 The Two Towers             Male   Elf      513
## 14 The Two Towers             Male   Hobbit  2463
## 15 The Two Towers             Male   Man     3589
## 16 The Return Of The King     Male   Elf      510
## 17 The Return Of The King     Male   Hobbit  2673
## 18 The Return Of The King     Male   Man     2459
```

## Exercise 2: Multivariate Pivoting

Congratulations, you're getting married! In addition to the wedding, you've decided to hold two other events: a day-of brunch and a day-before round of golf.  You've made a guestlist of attendance so far, along with food preference for the food events (wedding and brunch).


```r
guest %>% 
  DT::datatable(rownames = FALSE) # roname = FALSE to remove default id for each row
```

<!--html_preserve--><div id="htmlwidget-10edaeeb8939d761efc2" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-10edaeeb8939d761efc2">{"x":{"filter":"none","data":[[1,1,1,1,2,2,3,4,5,5,5,6,6,7,7,8,9,10,11,12,12,12,12,12,13,13,14,14,15,15],["Sommer Medrano","Phillip Medrano","Blanka Medrano","Emaan Medrano","Blair Park","Nigel Webb","Sinead English","Ayra Marks","Atlanta Connolly","Denzel Connolly","Chanelle Shah","Jolene Welsh","Hayley Booker","Amayah Sanford","Erika Foley","Ciaron Acosta","Diana Stuart","Cosmo Dunkley","Cai Mcdaniel","Daisy-May Caldwell","Martin Caldwell","Violet Caldwell","Nazifa Caldwell","Eric Caldwell","Rosanna Bird","Kurtis Frost","Huma Stokes","Samuel Rutledge","Eddison Collier","Stewart Nicholls"],["PENDING","vegetarian","chicken","PENDING","chicken",null,"PENDING","vegetarian","PENDING","fish","chicken",null,"vegetarian",null,"PENDING","PENDING","vegetarian","PENDING","fish","chicken","PENDING","PENDING","chicken","chicken","vegetarian","PENDING",null,"chicken","PENDING","chicken"],["PENDING","Menu C","Menu A","PENDING","Menu C",null,"PENDING","Menu B","PENDING","Menu B","Menu C",null,"Menu C","PENDING","PENDING","Menu A","Menu C","PENDING","Menu C","Menu B","PENDING","PENDING","PENDING","Menu B","Menu C","PENDING",null,"Menu C","PENDING","Menu B"],["PENDING","CONFIRMED","CONFIRMED","PENDING","CONFIRMED","CANCELLED","PENDING","PENDING","PENDING","CONFIRMED","CONFIRMED","CANCELLED","CONFIRMED","CANCELLED","PENDING","PENDING","CONFIRMED","PENDING","CONFIRMED","CONFIRMED","PENDING","PENDING","PENDING","CONFIRMED","CONFIRMED","PENDING","CANCELLED","CONFIRMED","PENDING","CONFIRMED"],["PENDING","CONFIRMED","CONFIRMED","PENDING","CONFIRMED","CANCELLED","PENDING","PENDING","PENDING","CONFIRMED","CONFIRMED","CANCELLED","CONFIRMED","PENDING","PENDING","PENDING","CONFIRMED","PENDING","CONFIRMED","CONFIRMED","PENDING","PENDING","PENDING","CONFIRMED","CONFIRMED","PENDING","CANCELLED","CONFIRMED","PENDING","CONFIRMED"],["PENDING","CONFIRMED","CONFIRMED","PENDING","CONFIRMED","CANCELLED","PENDING","PENDING","PENDING","CONFIRMED","CONFIRMED","CANCELLED","CONFIRMED","PENDING","PENDING","PENDING","CONFIRMED","PENDING","CONFIRMED","CONFIRMED","PENDING","PENDING","PENDING","CONFIRMED","CONFIRMED","PENDING","CANCELLED","CONFIRMED","PENDING","CONFIRMED"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th>party<\/th>\n      <th>name<\/th>\n      <th>meal_wedding<\/th>\n      <th>meal_brunch<\/th>\n      <th>attendance_wedding<\/th>\n      <th>attendance_brunch<\/th>\n      <th>attendance_golf<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

1. Put "meal" and "attendance" as their own columns, with the events living in a new column.


```r
(guest_long <- guest %>% 
  pivot_longer(cols      = c(-party, -name), 
               names_to  = c(".value", "event"),
               names_sep = "_"))
```

```
## # A tibble: 90 x 5
##    party name            event   meal       attendance
##    <dbl> <chr>           <chr>   <chr>      <chr>     
##  1     1 Sommer Medrano  wedding PENDING    PENDING   
##  2     1 Sommer Medrano  brunch  PENDING    PENDING   
##  3     1 Sommer Medrano  golf    <NA>       PENDING   
##  4     1 Phillip Medrano wedding vegetarian CONFIRMED 
##  5     1 Phillip Medrano brunch  Menu C     CONFIRMED 
##  6     1 Phillip Medrano golf    <NA>       CONFIRMED 
##  7     1 Blanka Medrano  wedding chicken    CONFIRMED 
##  8     1 Blanka Medrano  brunch  Menu A     CONFIRMED 
##  9     1 Blanka Medrano  golf    <NA>       CONFIRMED 
## 10     1 Emaan Medrano   wedding PENDING    PENDING   
## # ... with 80 more rows
```

2. Use `tidyr::separate()` to split the name into two columns: "first" and "last". Then, re-unite them with `tidyr::unite()`.


```r
guest_long %>% 
  separate(name, into = c("first", "last"), sep=" ") %>%
  unite(col = "name", first, last, sep = " ")
```

```
## # A tibble: 90 x 5
##    party name            event   meal       attendance
##    <dbl> <chr>           <chr>   <chr>      <chr>     
##  1     1 Sommer Medrano  wedding PENDING    PENDING   
##  2     1 Sommer Medrano  brunch  PENDING    PENDING   
##  3     1 Sommer Medrano  golf    <NA>       PENDING   
##  4     1 Phillip Medrano wedding vegetarian CONFIRMED 
##  5     1 Phillip Medrano brunch  Menu C     CONFIRMED 
##  6     1 Phillip Medrano golf    <NA>       CONFIRMED 
##  7     1 Blanka Medrano  wedding chicken    CONFIRMED 
##  8     1 Blanka Medrano  brunch  Menu A     CONFIRMED 
##  9     1 Blanka Medrano  golf    <NA>       CONFIRMED 
## 10     1 Emaan Medrano   wedding PENDING    PENDING   
## # ... with 80 more rows
```

3. Which parties still have a "PENDING" status for all members and all events?


```r
guest_long %>% 
  group_by(party) %>% 
  summarize(all_pending = all(attendance == "PENDING"))
```

```
## # A tibble: 15 x 2
##    party all_pending
##    <dbl> <lgl>      
##  1     1 FALSE      
##  2     2 FALSE      
##  3     3 TRUE       
##  4     4 TRUE       
##  5     5 FALSE      
##  6     6 FALSE      
##  7     7 FALSE      
##  8     8 TRUE       
##  9     9 FALSE      
## 10    10 TRUE       
## 11    11 FALSE      
## 12    12 FALSE      
## 13    13 FALSE      
## 14    14 FALSE      
## 15    15 FALSE
```

4. Which parties still have a "PENDING" status for all members for the wedding?


```r
guest %>% 
  group_by(party) %>% 
  summarize(pending_wedding = all(attendance_wedding == "PENDING"))
```

```
## # A tibble: 15 x 2
##    party pending_wedding
##    <dbl> <lgl>          
##  1     1 FALSE          
##  2     2 FALSE          
##  3     3 TRUE           
##  4     4 TRUE           
##  5     5 FALSE          
##  6     6 FALSE          
##  7     7 FALSE          
##  8     8 TRUE           
##  9     9 FALSE          
## 10    10 TRUE           
## 11    11 FALSE          
## 12    12 FALSE          
## 13    13 FALSE          
## 14    14 FALSE          
## 15    15 FALSE
```


5. Put the data back to the way it was.


```r
guest_long %>% 
  pivot_wider(id_cols     = c(party, name), 
              names_from  = event, # use the value in the event col to name the new col
              names_sep   = "_", 
              values_from = c(meal, attendance))
```

```
## # A tibble: 30 x 8
##    party name  meal_wedding meal_brunch meal_golf attendance_wedd~
##    <dbl> <chr> <chr>        <chr>       <chr>     <chr>           
##  1     1 Somm~ PENDING      PENDING     <NA>      PENDING         
##  2     1 Phil~ vegetarian   Menu C      <NA>      CONFIRMED       
##  3     1 Blan~ chicken      Menu A      <NA>      CONFIRMED       
##  4     1 Emaa~ PENDING      PENDING     <NA>      PENDING         
##  5     2 Blai~ chicken      Menu C      <NA>      CONFIRMED       
##  6     2 Nige~ <NA>         <NA>        <NA>      CANCELLED       
##  7     3 Sine~ PENDING      PENDING     <NA>      PENDING         
##  8     4 Ayra~ vegetarian   Menu B      <NA>      PENDING         
##  9     5 Atla~ PENDING      PENDING     <NA>      PENDING         
## 10     5 Denz~ fish         Menu B      <NA>      CONFIRMED       
## # ... with 20 more rows, and 2 more variables: attendance_brunch <chr>,
## #   attendance_golf <chr>
```

6. You also have a list of emails for each party, in this worksheet under the variable `email`. Change this so that each person gets their own row. Use `tidyr::separate_rows()`


```r
email %>% 
  separate_rows(guest, sep = ", ")
```

```
## # A tibble: 28 x 2
##    guest           email              
##    <chr>           <chr>              
##  1 Sommer Medrano  sommm@gmail.com    
##  2 Phillip Medrano sommm@gmail.com    
##  3 Blanka Medrano  sommm@gmail.com    
##  4 Emaan Medrano   sommm@gmail.com    
##  5 Blair Park      bpark@gmail.com    
##  6 Nigel Webb      bpark@gmail.com    
##  7 Sinead English  singlish@hotmail.ca
##  8 Ayra Marks      marksa42@gmail.com 
##  9 Jolene Welsh    jw1987@hotmail.com 
## 10 Hayley Booker   jw1987@hotmail.com 
## # ... with 18 more rows
```


## Exercise 3: Making tibbles

1. Create a tibble that has the following columns:

- A `label` column with `"Sample A"` in its entries.
- 100 random observations drawn from the N(0,1) distribution in the column `x`
- `y` calculated as the `x` values + N(0,1) error. 


```r
n <- 100
tibble(label = "Sample A",
             x = rnorm(n),
             y= x + rnorm(n))
```

```
## # A tibble: 100 x 3
##    label          x      y
##    <chr>      <dbl>  <dbl>
##  1 Sample A -0.776  -0.824
##  2 Sample A -2.79   -3.52 
##  3 Sample A  0.397  -1.33 
##  4 Sample A -0.714   0.104
##  5 Sample A -0.818  -0.323
##  6 Sample A  0.409  -1.37 
##  7 Sample A -0.0210  0.396
##  8 Sample A  1.23    1.58 
##  9 Sample A -0.330  -1.08 
## 10 Sample A -0.804  -1.73 
## # ... with 90 more rows
```


2. Generate a Gaussian sample of size 100 for each combination of the following means (`mu`) and standard deviations (`sd`).


```r
n <- 100
mu <- c(-5, 0, 5)
sd <- c(1, 3, 10)
FILL_THIS_IN(mu = mu, sd = sd) %>% 
  group_by_all() %>% 
  mutate(z = list(rnorm(n, mu, sd))) %>% 
  FILL_THIS_IN
```

```
## Error in FILL_THIS_IN(mu = mu, sd = sd): could not find function "FILL_THIS_IN"
```

3. Fix the `experiment` tibble below (originally defined in the documentation of the `tidyr::expand()` function) so that all three repeats are displayed for each person, and the measurements are kept. The code is given, but needs one adjustment. What is it?


```r
experiment <- tibble(
  name = rep(c("Alex", "Robert", "Sam"), c(3, 2, 1)),
  trt  = rep(c("a", "b", "a"), c(3, 2, 1)),
  rep = c(1, 2, 3, 1, 2, 1),
  measurement_1 = runif(6),
  measurement_2 = runif(6))
experiment %>% expand(nesting(name, trt, rep)) #expended format
```

```
## # A tibble: 6 x 3
##   name   trt     rep
##   <chr>  <chr> <dbl>
## 1 Alex   a         1
## 2 Alex   a         2
## 3 Alex   a         3
## 4 Robert b         1
## 5 Robert b         2
## 6 Sam    a         1
```

```r
experiment %>% complete(name, trt, rep)
```

```
## # A tibble: 18 x 5
##    name   trt     rep measurement_1 measurement_2
##    <chr>  <chr> <dbl>         <dbl>         <dbl>
##  1 Alex   a         1         0.131        0.777 
##  2 Alex   a         2         0.284        0.0812
##  3 Alex   a         3         0.979        0.312 
##  4 Alex   b         1        NA           NA     
##  5 Alex   b         2        NA           NA     
##  6 Alex   b         3        NA           NA     
##  7 Robert a         1        NA           NA     
##  8 Robert a         2        NA           NA     
##  9 Robert a         3        NA           NA     
## 10 Robert b         1         0.919        0.525 
## 11 Robert b         2         0.602        0.442 
## 12 Robert b         3        NA           NA     
## 13 Sam    a         1         0.246        0.0704
## 14 Sam    a         2        NA           NA     
## 15 Sam    a         3        NA           NA     
## 16 Sam    b         1        NA           NA     
## 17 Sam    b         2        NA           NA     
## 18 Sam    b         3        NA           NA
```

```r
experiment %>% complete(nesting(name, trt), rep)
```

```
## # A tibble: 9 x 5
##   name   trt     rep measurement_1 measurement_2
##   <chr>  <chr> <dbl>         <dbl>         <dbl>
## 1 Alex   a         1         0.131        0.777 
## 2 Alex   a         2         0.284        0.0812
## 3 Alex   a         3         0.979        0.312 
## 4 Robert b         1         0.919        0.525 
## 5 Robert b         2         0.602        0.442 
## 6 Robert b         3        NA           NA     
## 7 Sam    a         1         0.246        0.0704
## 8 Sam    a         2        NA           NA     
## 9 Sam    a         3        NA           NA
```


