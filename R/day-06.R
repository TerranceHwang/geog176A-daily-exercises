# Title: Daily Exercise 06
# Author: Terrance Hwang
# Purpose: Creating ggplot graphs

library(ggplot2)
library(tidyverse)
url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'
covid = read_csv(url)
head(covid)

covid %>%
  filter(date == max(date)) %>%
  group_by(state) %>%
  summarize(cases = sum(cases, na.rm = TRUE)) %>%
  ungroup() %>%
  slice_max(cases, n = 6) %>%
  pull(state) ->
  top_states

covid %>%
  filter(state %in% top_states) %>%
  group_by(state, date) %>%
  summarise(cases = sum(cases)) %>%
  ungroup() %>%
  ggplot(aes(x = date, y = cases, color = state)) +
  geom_line(size = 2) +
  facet_wrap(~state) +
  ggthemes::theme_gdocs() +
  theme(legend.position = 'NA') +
  labs(title = "Total Case Counts",
       subtitle = "Data Source: NY-Times",
       x = "Date",
       y = "Cases",
       caption = "Daily Exercise 06")

ggsave("img/state-total-cases.png")

covid %>%
  group_by(date) %>%
  summarize(cases = sum(cases)) %>%
  ggplot(aes(x = date, y = cases)) +
  geom_col(fill = "red", color = "red", alpha = .25) +
  geom_line(color = "red", size = 2) +
  ggthemes::theme_gdocs() +
  labs(title = "National Total Case Counts",
       x = "Date",
       y = "Cases",
       caption = "Daily Exercise 06")

ggsave("img/national-total-cases.png")
