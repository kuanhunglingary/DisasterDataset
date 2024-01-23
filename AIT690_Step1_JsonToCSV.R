library(RJSONIO)
# From the website
DisasterEventRaw<-fromJSON("http://ist.gmu.edu/~hpurohit/courses/ait690-proj-data-spring17.json")

# Read CSV file
#DisasterEventRaw<-fromJSON("ait690＿proj＿data＿spring17.json")

length(DisasterEventRaw)

# We can coerce this to a data.frame
final_data <- do.call(rbind, DisasterEventRaw)

# Then write it to a flat csv file
final_data <- final_data[,c("LATITUDE","MESSAGE","LONGITUDE","DOCUMENT_ID","DATETIME")]
final_data <- final_data[,c("DOCUMENT_ID","MESSAGE","DATETIME","LATITUDE","LONGITUDE")]
write.csv(final_data, "DisasterEvent.csv")
