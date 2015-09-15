#Makes the file for the phylum ranks in the taxon matrix - see comments to the r_taxon_matrix script
library(dplyr)

mycsv<-read.csv("../phylum_matrix.csv", na.strings="NAN", encoding="UTF-8")

enforcer <- data.frame(country=character(), taxon=character(),stringsAsFactors = FALSE)

for (j in iso_country[,1]){
    for (k in unique(mycsv[,2])){        
        enforcer[nrow(enforcer)+1, ] <- c(j, k)
    }
}


#left_join from the dplyr package is used to join enforcer and mycsv. lapply and the as.character function coerces factors to char
combo <- data.frame(lapply(left_join(enforcer, mycsv, by=c('taxon'='phylum', 'country'='country')), as.character), stringsAsFactors = F)
#converts NAs to 0
combo[is.na(combo)] <- 0

fct <- as.character(unique(combo$taxon))

df_phylum <- data.frame(iso_country$iso_code)

for (j in fct){
    #each element in fct gets a new dataframe that is then pasted onto df
    newdf <- combo[combo$taxon == j, c('total','increase')]
    for (k in colnames(newdf)){
        df_phylum[,paste(k,j, sep="")]<-newdf[,k]    
    }    
}

 