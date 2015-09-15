#Makes the file for the kingdom ranks in the taxon matrix

library(dplyr)
mycsv <- read.csv("../kingdom_matrix.csv")

#The enforcer data frame is there to ensure consistent group size, i.e there will always be the same number of ranks per country
enforcer <- data.frame(country=character(), taxon=character(),stringsAsFactors = FALSE)

#Fills the enforcer with countries and taxon ranks
for (j in iso_country[,1]){
    for (k in unique(mycsv[,2])){        
        enforcer[nrow(enforcer)+1, ] <- c(j, k)
    }
}

newnames <- vector()

#Strips out all the col name prefixes so it reads cleaner
for (j in colnames(mycsv)){ newnames <- c(newnames, strsplit(j, "\\.")[[1]][2]) }
names(mycsv) <- newnames

#left_join from the dplyr package is used to join enforcer and mycsv. lapply and the as.character function coerces factors to char
combo <- data.frame(lapply(left_join(enforcer, mycsv, by=c('taxon'='kingdom', 'country'='country')), as.character), stringsAsFactors = F)
#converts NAs to 0
combo[is.na(combo)] <- 0

#Vectors for creating taxon columns in new data frame
fct <- as.character(unique(combo[,2]))

df_kingdom <- data.frame(iso_country$iso_code)

for (j in fct){
    #each element in fct gets a new dataframe that is then pasted onto df
    newdf <- combo[combo$taxon == j, c('total','increase')]
    for (k in colnames(newdf)){
        df_kingdom[,paste(k,j, sep="")]<-newdf[,k]    
    }    
}

