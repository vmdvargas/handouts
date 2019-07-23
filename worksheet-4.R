## Tidy Concept

trial <- read.delim(sep = ',', header = TRUE, text = "
block, drug, control, placebo
    1, 0.22,    0.58,    0.31
    2, 0.12,    0.98,    0.47
    3, 0.42,    0.19,    0.40
")

## Gather 

library(tidyr)
tidy_trial <- gather(trial,
  key = "treatment",
  value = "response",
  -block)

## Spread 

survey <- read.delim(sep = ',', header = TRUE, text = "
participant,   attr, val
1          ,    age,  24
2          ,    age,  57
3          ,    age,  13
1          , income,  30
2          , income,  60
")

tidy_survey <- spread(survey,
  key = attr,
  value = val)

#specify fill for missing data
tidy_survey <- spread(survey,
  key = attr,
  value = val,
  fill=0)

## Sample Data 

library(data.table)
cbp <- fread('data/cbp15co.csv')
#optimize to read large data

str(cbp)

cbp <- fread(
  'data/cbp15co.csv',
  na.strings = NULL,
  colClasses = c(
    FIPSTATE='character',
    FIPSCTY='character'))

acs <- fread(
  'data/ACS/sector_ACS_15_5YR_S2413.csv',
  colClasses = c(FIPS = 'character'))

str(acs)

## dplyr Functions 

library(dplyr)
cbp2 <- filter(cbp,
               grepl('----', NAICS),
               !grepl('------', NAICS))

str(cbp2)

?grep

#stringr package - maybe for text? - create same filtering condition as dplyr
library(stringr)
cbp2 <- filter(cbp,
               str_detect(NAICS, '[0-9]{2}----'))

#mutate - transform columns
#str_c - string  combine
cbp3 <- mutate(cbp2,
               FIPS = str_c(FIPSTATE, FIPSCTY))

#remove dashes from cbp3
cbp3 <- mutate(cbp2,
               FIPS = str_c(FIPSTATE, FIPSCTY),
               NAICS = str_remove(NAICS, '-+'))

#use pipe %>%
cbp <- cbp %>%
  filter(
    str_detect(NAICS, '[0-9]{2}----')
  ) %>%
  mutate(
    FIPS = str_c(FIPSTATE, FIPSCTY),
    NAICS = str_remove(NAICS, '-+')
  )

#names() see name of columns
names(cbp)

cbp <- cbp %>%
  select(
    FIPS,
    NAICS,
    starts_with('N')
  )

#starts_with - select 

## Join

sector <- fread(
  'data/ACS/sector_naics.csv',
  colClasses = c(NAICS = 'character'))

View(sector)

#inner_join - many to 1 match up, joining by "NAICS) - where there is overlap
cbp <- cbp %>%
  inner_join(sector)


## Group By 

cbp_grouped <- cbp %>%
  group_by(FIPS, Sector)

## Summarize 

cbp <- cbp %>%
  group_by(FIPS, Sector) %>%
  select(starts_with('N'), -NAICS) %>%
  summarize_all(sum)

acs_cbp <- cbp %>%
  inner_join(acs)
