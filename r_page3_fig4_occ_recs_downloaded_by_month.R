#Fig4 downloaded records by country by month

require(ggplot2)
require(plyr)
require(scales)

mycsv <- read.csv("../fig4_records_by_month_downloaded_from_country.csv")
mycsv <- left_join(iso_country, mycsv, c('iso_code'='country'))
mycsv <- data.frame(lapply(mycsv, as.character), stringsAsFactors = FALSE)
mycsv[is.na(mycsv)] <- 0

#For every country; create a data frame and a plot based on that, then save .png
for (j in unique(mycsv$iso_code)){    
    bymonth <- mycsv[mycsv[,1]==j, ]
    plt <- ggplot(bymonth, aes(x = `year_month`, y = as.integer(sum)/1000, group = iso_code)) + 
        geom_area(position = "identity", colour="black", fill="blue", alpha=0.2) + 
        geom_line(size = 1.5, colour="blue", alpha=0.6) +
        theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
    
    ggsave(plt, file=paste("downloaded_records_by_month_for_", j, ".png", sep=""), path="g:/Country reports aux/test_ggsave2")
}

