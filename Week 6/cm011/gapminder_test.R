library("tidyverse")
library("gapminder")

gapminder
write_csv(gapminder, "./gapminder.csv")
view(gapminder)

gapminder_sum <- gapminder %>%
  group_by (continent) %>%
  summarize(ave_lifeExp = mean(lifeExp))

view(gapminder_sum)
write_csv(gapminder_sum, './Week 6/cm011/gapminder_sum.csv')

gapminder_sum %>%
  ggplot(aes(x = continent, y=ave_lifeExp))+ geom_point()+ theme_classic()