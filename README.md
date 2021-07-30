# GBIF-country-reports
SQL and R scripts for generating the GBIF 2015 country report stats base file 

## Latest script is the R_version_of_matts_curl_script.R file
https://github.com/jlegind/GBIF-country-reports/blob/master/R_version_of_matts_curl_script.R

This is a simple R way of getting "new files added since beginning of year". It is a supplement to the CURL script Matt wrote.
It depends on packages CURL and dplyr so it is not to heavy in processing.

The key line is :

    ff <- df %>% filter(snapshot %in% c("2021-01-01", "2021-07-01"))
    
The dates in the filter function select the relevant snapshots we want to work with.
