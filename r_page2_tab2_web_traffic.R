#Creates Table 2; worldwide and national figures for web traffic

query.list <- Init(start.date = "2014-07-01",
                   end.date = "2015-06-30",                   
                   dimensions = "ga:countryIsoCode",
                   metrics = "ga:sessions, ga:pageviewsPerSession, ga:avgSessionDuration, ga:bounceRate, ga:percentNewSessions",                   
                   max.results = 10000,                   
                   table.id = "ga:73962076")

ga.query <- QueryBuilder(query.list)
ga.data <- GetReportData(ga.query, token)

ga.data[,3:6] <- data.frame(sapply(ga.data[,3:6], FUN=function(x) format(round(as.numeric(x), digits = 2), nsmall = 2)), stringsAsFactors = F)
#Converts char columns to numeric and enforced two digit format

web_traffic <- data.frame(left_join(iso_country, ga.data, by=c('iso_code'='countryIsoCode')))
web_traffic[is.na(web_traffic)] <- "no data"

#For the "Worldwide" column which is static across all reports
query.list <- Init(start.date = "2014-07-01",
                   end.date = "2015-06-30",                                      
                   metrics = "ga:sessions, ga:pageviewsPerSession, ga:avgSessionDuration, ga:bounceRate, ga:percentNewSessions",                   
                   max.results = 10000,                   
                   table.id = "ga:73962076")

ga.query <- QueryBuilder(query.list)
worldwide <- GetReportData(ga.query, token)
worldwide[,2:5] <- data.frame(sapply(worldwide[,2:5], FUN=function(x) format(round(as.numeric(x), digits = 2), nsmall = 2)), stringsAsFactors = F)
