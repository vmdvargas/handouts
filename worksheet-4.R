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

#Homework 

#Exercise 1

gather(tidy_survey, 
       key = "attr",
       value = "val", 
       -participant)

#Exercise 2 Use filter and select to return just the annual payroll data for the top level 
#construction sector (“23—-“).

cbp_23 <- fread('data/cbp15co.csv', na.strings = '') %>%
  filter(NAICS == '23----')  %>%
  select(starts_with('FIPS'), 
         starts_with('AP'))

#Exercise 3 Write code to create a data frame giving, for each state, the number of counties 
#in the CBP survey with establishements in mining or oil and gas extraction (‘21—-‘) 
#along with their total employment (“EMP”). Group the data using both FIPSTATE and FIPSCTY 
#and use the fact that one call to summarize only combines across the lowest level of grouping. 
#The dplyr function n counts rows in a group.

cbp_21 <- fread('data/cbp15co.csv', na.strings = '') %>%
  filter(NAICS == '21----') %>%
  group_by(FIPSTATE, FIPSCTY) %>%
  summarize(EMP = sum(EMP)) %>%
  summarize(EMP = sum(EMP), counties = n())


#Exercise 4 A “pivot table” is a transformation of tidy data into a wide summary table. 
#First, data are summarized by two grouping factors, then one of these is “pivoted” into columns.
#Starting from a filtered CBP data file, chain a split-apply-combine procedure into the tidyr 
#function spread to get the total number of employees (“EMP”) in each state (as rows) 
#by 2-digit NAICS code (as columns).

pivot <- fread('data/cbp15co.csv', na.strings = '') %>%
  filter(str_detect(NAICS, '[0-9]{2}----')) %>%
  group_by(FIPSTATE, NAICS) %>%
  summarize(EMP = sum(EMP)) %>%
  spread(key = NAICS, value = EMP)


