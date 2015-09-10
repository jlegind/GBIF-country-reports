#Create the "Newest publishers from <country>" page 6
#Depends on data frame 'iso_country' from grand_merger.R
library(jsonlite)
library(dplyr)

newest_publishers <- data.frame(country=character(), title=character(), rank=integer(), stringsAsFactors = FALSE)
limits = 4 #Max number of organizations/publishers returned
cutoff_date = "2015-07-01"

# Uses the JSONLite to retrieve new publishers by country 
for (k in iso_country$iso_code){ 
    new_orgs <- fromJSON(paste("http://api.gbif.org/v1/organization?country=", k, sep=""))
    res <- new_orgs$results
    
    if (new_orgs$count == 0){ 
        res$title = rep("", limits) 
    }
    else{            
            res <- res[order(res$created, decreasing = T),][as.Date(res$created) < cutoff_date,]                     
    }
    for (j in 1:limits){    
        newest_publishers[nrow(newest_publishers)+1, ] <- c(k, res$title[j], j)    
    }
}

newest_publishers[is.na(newest_publishers)] <- ""

fct<-as.character(unique(newest_publishers$rank))
df_newest_publishers <- data.frame(iso_country$iso_code)

for (j in fct){
    newdf<-newest_publishers[newest_publishers$rank==j, c('title','rank')]
    for (k in colnames(newdf)){
        df_newest_publishers[,paste(k, "rank",j , sep="_")]<-newdf[,k]    
    }    
}

