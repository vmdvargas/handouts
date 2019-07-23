# Linear models

library(readr)
library(dplyr)

person <- read_csv(
  file = ...,
  col_types = cols_only(
    ... = 'i',  # Age
    ... = 'd',  # Wages or salary income past 12 months
    ... = 'i',  # Educational attainment
    ... = 'f',   # Sex
    ... = 'f',  # Occupation recode based on 2010 OCC codes
    ... = 'i')) # Usual hours worked per week past 12 months

person <- within(person, {
  SCHL <- factor(SCHL)
  levels(SCHL) <- list(
    'Incomplete' = c(1:15),
    'High School' = 16,
    'College Credit' = 17:20,
    'Bachelor\'s' = 21,
    'Master\'s' = 22:23,
    'Doctorate' = 24)}) %>%
  filter(
    WAGP > 0,
    WAGP < max(WAGP, na.rm = TRUE))

# Formula Notation

fit <- lm(
  formula = ...,
  data = ...)

fit <- lm(
  ...,
  person)

# Metadata matters

fit <- lm(
  ...,
  person)

# GLM families

fit <- ...(...,
  ...,
  person)

# Logistic Regression

fit <- glm(...,
  ...,
  person)

...(fit, update(fit, ...), test = 'Chisq')

# Random Intercept

library(...)
fit <- ...(
  ...,
  data = person)

# Random Slope

fit <- lmer(
  ...
  data = person)

fit <- lmer(
  log(WAGP) ~ (WKHP | SCHL),
  data = person,
  control = ...)

ggplot(person,
  aes(x = WKHP, y = log(WAGP), color = SCHL)) +
  geom_point() +
  geom_line(...) +
  labs(title = 'Random intercept and slope with lmer')
