library(dplyr)
mycsv<-read.csv("../class_matrix.csv", na.strings="NAN")

enforcer <- data.frame(country=character(), taxon=character(),stringsAsFactors = FALSE)

for (j in iso_country[,1]){
    for (k in unique(mycsv[,2])){        
        enforcer[nrow(enforcer)+1, ] <- c(j, k)
    }
}

combo <- left_join(enforcer, mycsv, by=c('taxon'='class', 'country'='country'),type="left")
combo <- data.frame(lapply(combo, as.character), stringsAsFactors = FALSE)
combo[is.na(combo)] <- 0

fct <- as.character(unique(combo[,2]))
df_class <- data.frame(iso_country$iso_code)

for (j in fct){
    newdf <- combo[combo$taxon == j, c('total','increase')]
    for (k in colnames(newdf)){        
        df_class[,paste(k,j, sep="")] <- newdf[,k]    
    }    
}

