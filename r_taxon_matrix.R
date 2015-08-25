library(dplyr)
mycsv<-read.csv("kingdom_matrix.csv", na.strings="NAN")
enfor<-read.csv("kingdom_matrix_group_enforce.csv", na.strings="NAN")
combo<-left_join(enfor,mycsv,by=c('t2.kingdom'='t1.kingdom', 't1.iso_code'='t1.country'),type="left")

combo<- data.frame(lapply(combo, as.character), stringsAsFactors = FALSE)
combo[is.na(combo)]<-0

fct<-as.character(unique(combo[,2]))
countries<-as.character(unique(combo[,1]))

df<-data.frame(countries)

for (j in fct){
    newdf<-combo[combo$t2.kingdom==j,c('X_c2','X_c3')]
    for (k in colnames(newdf)){
        #print(k)
        #print(head(newdf[,k]))
        df[,paste(k,j, sep="")]<-newdf[,k]    
    }    
}

#combo[combo$t2.kingdom=="Animalia",c('X_c2','X_c3')]