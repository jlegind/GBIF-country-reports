#Create the "Most recent datasets..." page 6
library(rgbif)
library(dplyr)
mycsv <- read.csv("../Page6_most_recent_datasets_from.csv", sep=";", encoding="UTF-8")

enforcer <- data.frame(country=character(), rank=integer(), stringsAsFactors = FALSE)

for (j in 1:5){
    for (k in iso_country$iso_code){        
        enforcer[nrow(enforcer)+1, ] <- c(k, j)
    }
}
enforcer$rank = as.integer(enforcer$rank)

#left_join from the dplyr package is used to join enforcer and mycsv. lapply and the as.character function coerces factors to char
combo <- data.frame(lapply(left_join(enforcer, mycsv, by=c('country'='country','rank'='rn')), as.character), stringsAsFactors = F)
#converts NAs to 0
combo[is.na(combo)] <- ""

count_vec <- vector()
df <- data.frame(count=integer())

#Occurrence count from the GBIF API - occ_count() - fills a vector that is then tagged on to the combo data frame
for (j in combo$key){
    if (j == ""){
        count_vec <- c(count_vec, "")        
    }else{        
        count_vec <- c(count_vec, occ_count(datasetKey = j))    
    }
}

combo$count <- count_vec

fct<-as.character(unique(combo$rank))
df_recent_datasets <- data.frame(iso_country$iso_code)

for (j in fct){
    newdf<-combo[combo$rank==j, c('dataset_title','count')]
    for (k in colnames(newdf)){
        df_recent_datasets[,paste(k, "rank",j , sep="_")]<-newdf[,k]    
    }    
}
