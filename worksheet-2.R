# Getting Started

library(readr)
person <- read_csv(
  file = 'data/census_pums/sample.csv',
  col_types = cols_only(
    ... = 'i',
    ... = 'd',
    ... = 'c',
    ... = 'c'))

## Layered Grammar

library(...)
...(person, ...(x = WAGP)) +
  ..._histogram()

library(dplyr)
person <- filter(
  person,
  WAGP > 0,
  WAGP < max(WAGP, na.rm = TRUE))

ggplot(person,
  aes(...)) +
  geom_point()

ggplot(person,
  aes(x = SCHL, y = WAGP)) +
  ...

## Layer Customization

ggplot(person,
  aes(x = SCHL, y = WAGP)) +
  geom_boxplot(...) +
  geom_point()

ggplot(person,
  aes(x = SCHL, y = WAGP)) +
  geom_boxplot() +
  geom_point(
    ... = 'red',
    ... = 'summary',
    fun.y = ...)

## Adding Aesthetics

ggplot(person,
  aes(x = SCHL, y = WAGP, ...)) +
  geom_boxplot()

person$SEX <- factor(person$SEX, levels = ...)

ggplot(person,
  aes(x = SCHL, y = WAGP, color = SEX)) +
  geom_boxplot()

# Storing and Re-plotting

... ggplot(person,
  aes(x = SCHL, y = WAGP, color = SEX)) +
  geom_point(
    stat = 'summary',
    fun.y = 'mean')

schl_wagp <- ... +
  scale_color_manual(
    values = c('black', 'red'))

ggsave(...,
  plot = ...,
  width = 4, height = 3)

# Smooth Lines

ggplot(person,
  aes(x = SEX, y = WAGP)) + 
  geom_point() +
  ...(
    method = ...,
    aes(group = 0))

# Axes, Labels and Themes

sex_wagp <- ggplot(person,
  aes(x = SEX, y = WAGP)) + 
  geom_point() +
  geom_smooth(
    method = 'lm',
    aes(group = 0))

sex_wagp + ...(
  ... = 'Wage Gap',
  x = ...,
  ... = 'Wages (Unadjusted USD)')

sex_wagp + ...(
  trans = 'log10')

sex_wagp + ...()

sex_wagp + theme_bw() +
  labs(title = 'Wage Gap') +
  theme(
    ... = element_text(
      face = 'bold',
      hjust = 0.5))

# Facets

person$SCHL <- factor(person$SCHL)
levels(person$SCHL) <- list(
  'High School' = '16',
  'Bachelor\'s' = '21',
  'Master\'s' = '22',
  'Doctorate' = '24')

ggplot(...,
  aes(x = SEX, y = WAGP)) + 
  geom_point() +
  geom_smooth(
    method = 'lm',
    aes(group = 0)) +
  ...
