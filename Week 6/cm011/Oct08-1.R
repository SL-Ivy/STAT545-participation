data_url <- "http://gattonweb.uky.edu/sheather/book/docs/datasets/GreatestGivers.xls"

# read_csv can directly import URLS but read_excel requires you to first download it.
# This is the old way

download.file(url = data_url,
              destifile = paste('./datesets/', file_name))

# Task: Change above to use the "here::here" pacakge
library("here")
download.file(url = data_url,
              destfile = here::here("in-class_test", "greatestGivers.xls"))

library(readxl)
philanthropists <- read_excel(here::here("test", file_name), trim_ws = TURE)

# download doesn't work for Windows
