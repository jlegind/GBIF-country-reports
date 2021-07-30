library(curl)
library(dplyr)

# download the GBIF analytics country occurrence records file
down <- curl_download("https://analytics-files.gbif.org/global/csv/occ_publisherCountry.csv", "gbif_country_stats.csv")
# make it a data-frame table
df <- read.csv(down, sep=",")


# filter for the relevant snapshots, like beginning_of_year and latest_snapshot
ff <- df %>% filter(snapshot %in% c("2021-01-01", "2021-07-01"))

# Groups are created and the result is piped into the mutate function which performs a calculation that is added to 
# a new column (records_added)
rr <- ff %>%
  mutate(added_records = occurrenceCount - filter(., snapshot == '2021-01-01') %>% pull(occurrenceCount))

# The 'beginning of year' rows are expunged. 
result<-rr[!(rr$snapshot=="2021-01-01"),]

