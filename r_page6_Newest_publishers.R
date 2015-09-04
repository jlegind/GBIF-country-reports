#Create the "Newest publishers from <country>" page 6
#Depends on data frame 'iso_country' from grand_merger.R
library(rgbif)
library(dplyr)

newest_publishers <- data.frame(country=character(), title=character(), rank=integer(), stringsAsFactors = FALSE)
limits = 4 #Max number of organizations/publishers returned

# Uses the rgbif organizations() function to retrieve new publishers by country 
for (k in iso_country$iso_code){ 
    new_orgs <- organizations(query=k, limit=limits)
    if (new_orgs$meta$count == 0){ new_orgs$data$title = rep("", limits) }
    for (j in 1:limits){
        newest_publishers[nrow(newest_publishers)+1, ] <- c(k, new_orgs$data$title[j], j)    
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

