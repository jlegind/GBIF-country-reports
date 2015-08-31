#Aquires the numbers for Sessions by week originating in in country

require(ggplot2)
require(plyr)

query.list <- Init(start.date = "2014-07-01",
                   end.date = "2015-06-30",                   
                   dimensions = "ga:countryIsoCode, ga:yearWeek, ga:yearMonth",
                   metrics = "ga:sessions",
                   #segment="users::condition::perSession::ga:timeOnPage>10",
                   max.results = 10000,
                   #sort = "ga:countryIsoCode, -ga:sessions",
                   table.id = "ga:73962076")
ga.query <- QueryBuilder(query.list)
ga.data <- GetReportData(ga.query, token, paginate_query = T)

#For every country; create a data frame and a plot based on that, then save .png
for (j in unique(ga.data$countryIsoCode)){
    #print(j)
    byweek <- ga.data[ga.data[,1]==j, ]
    plt <- ggplot(byweek, aes(x = `yearWeek`, y = sessions, group = countryIsoCode)) + 
        geom_area(position = "identity", colour="black", fill="blue", alpha=0.2) + 
        geom_line(size = 1.5, colour="blue", alpha=0.6) + geom_point(size = 4, colour="blue", alpha=0.6)
    #The code below generates a custom x axis tick mark label based on Year/Week
    plt <- plt + scale_x_discrete(breaks = c("201440", "201503", "201516"), labels=c("September 2014", "Januar 2015", "April 2015")) +
        theme(axis.title.x = element_blank(), axis.title.y = element_text(face="bold", size = 16)) 
    
    ggsave(plt, file=paste("session_by_week_for_", j, ".png", sep=""), path="g:/Country reports aux/test_ggsave")
}


