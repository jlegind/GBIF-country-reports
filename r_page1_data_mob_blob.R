#Requires csv file from HiveQL Page1_data_mobilization_blob.txt

library(dplyr)
data_mob_blob<-read.csv("page1_data_mob_blob.csv", na.strings="NAN")
iso_country <- read.csv("../country_iso_GBIF.csv", encoding="UTF-8", na.strings="NAN") 

data_mob_blob <- left_join(iso_country, data_mob_blob, by=c('iso_code'='pub_country'),type="left")

data_mob_blob[is.na(data_mob_blob)]<-0

colnames(data_mob_blob)[3:4] <- c("page1_blob_new_records", "page1_blob_total_records")
