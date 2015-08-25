query.list <- Init(start.date = "2014-07-01",
                   end.date = "2015-06-30",
                   #dimensions = "ga:continent, ga:subContinent, ga:country, ga:countryIsoCode",
                   dimensions = "ga:countryIsoCode, ga:city",
                   metrics = "ga:sessions",
                   #segment="users::condition::perSession::ga:timeOnPage>10",
                   max.results = 10000,
                   sort = "ga:countryIsoCode, -ga:sessions",
                   table.id = "ga:73962076")
ga.query <- QueryBuilder(query.list)
ga.data <- GetReportData(ga.query, token, paginate_query = T)

top5 <- group_by(ga.data, countryIsoCode)
top5 <- top_n(top5, 5)

fr <- data.frame(iso=character(), rank=integer(), stringsAsFactors = F)

for(k in iso_country[,1]){
    #print(k)
    for(j in 1:5){
        fr[nrow(fr)+1,] <- c(k, j)
        
    }
}
fr[,2] <- as.integer(fr[,2])

top5$ranking <- ave(top5$sessions, top5$countryIsoCode, FUN=function(x) order(-x) )
top5 <- left_join(fr, top5, by=c('iso' = 'countryIsoCode','rank' = 'ranking'))
tail(top5, 20)
