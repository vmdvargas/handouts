library(readr)
library(dplyr)

# read in data
cty_to_cty <- readr::read_csv('data/cty-to-cty_clean.csv')

state_movers <- cty_to_cty %>% group_by(current_state) %>%
  summarise(sum_new_movers = sum(movers_state_est, na.rm = TRUE)) %>% 
  arrange(sum_new_movers)


# pretend this takes a really long time!
Sys.sleep(10)