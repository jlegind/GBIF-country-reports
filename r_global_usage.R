query.list <- Init(start.date = "2014-07-01",
                   end.date = "2015-06-30",
                   #dimensions = "ga:continent, ga:subContinent, ga:country, ga:countryIsoCode",
                   #dimensions = "ga:sessionDurationBucket",
                   metrics = "ga:sessions, ga:users, ga:pageviews",
                   #segment="users::condition::perSession::ga:timeOnPage>10",
                   max.results = 10000,
                   #sort = "-ga:subContinent",
                   table.id = "ga:73962076")
ga.query <- QueryBuilder(query.list)
ga.data <- GetReportData(ga.query, token)


#users::condition::perSession::ga:timeOnPage>10