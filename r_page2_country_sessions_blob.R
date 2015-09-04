query.list <- Init(start.date = "2014-07-01",
                   end.date = "2015-06-30",
                   #dimensions = "ga:continent, ga:subContinent, ga:country, ga:countryIsoCode",
                   dimensions = "ga:country, ga:countryIsoCode",
                   metrics = "ga:sessions, ga:users, ga:pageviews",
                   #segment="users::condition::perSession::ga:timeOnPage>10",
                   max.results = 10000,
                   #sort = "-ga:subContinent",
                   table.id = "ga:73962076")
ga.query <- QueryBuilder(query.list)
ga.data <- GetReportData(ga.query, token, split_daywise = TRUE)
#ga.data_test <- GetReportData(ga.query, token)

#aggregate() function needs this format to display the groups: the cbind is the columns to sum and the ~ country is 
#the group by.
ga_prom <- aggregate(cbind(sessions, users, pageviews) ~ country + countryIsoCode, data=ga.data, sum)

worldwide[,2:5] <- data.frame(sapply(worldwide[,2:5], FUN=function(x) format(round(as.numeric(x), digits = 2), nsmall = 2)), stringsAsFactors = F)