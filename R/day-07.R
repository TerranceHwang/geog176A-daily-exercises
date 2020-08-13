# Name: Terrance Hwang
# Date: August 13, 2020
# Purpose: Day 7 Assignment

library(ggplot2)
library(tidyverse)
url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'
covid = read_csv(url)
head(covid)

region = data.frame(state = state.name, region = state.region)
head(region)

covid %>%
  right_join(region, by = "state") %>%
  group_by(region, date) %>%
  summarize(cases  = sum(cases), deaths = sum(deaths)) %>%
  pivot_longer(cols = c('cases', 'deaths')) ->
covid_region

ggplot(covid_region, aes(x = date, y = value)) +
  geom_line(aes(col = region)) +
  facet_grid(name~region, scale = "free_y") +
  theme_linedraw() +
  theme(legend.position = "bottom") +
  theme(legend.position = "NA") +
  labs(title = "Total Cases and Deaths: Region",
       y = "Daily Total Count",
       x = "Date",
       caption = "Daily Exercise 07",
       subtitle = "Source: NY-Times" )

ggsave("img/regional-cases-deaths.png")

