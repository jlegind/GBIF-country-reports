# GBIF-country-reports
SQL and R scripts for generating the GBIF 2015 country report stats base file 

## Latest script is the R_version_of_matts_curl_script.R file
https://github.com/jlegind/GBIF-country-reports/blob/master/R_version_of_matts_curl_script.R

This is a simple R way of getting "new files added since beginning of year". It is a supplement to the CURL script Matt wrote.
Neither CURL and dplyr pull in too many dependencies, so it is not to heavy in processing.

## Usage
One of the key lines is :

    ff <- df %>% filter(snapshot %in% c("2021-01-01", "2021-07-01"))
    
The dates in the filter function selects the relevant snapshots we want to calculate on.

The snapshot rows to be subtracted are set here:

    rr <- ff %>%
    mutate(added_records = occurrenceCount - filter(., snapshot == '2021-01-01') %>% pull(occurrenceCount))

## Future added features
There could be other csv files added and analyzed from https://analytics-files.gbif-uat.org/

For instance a 
