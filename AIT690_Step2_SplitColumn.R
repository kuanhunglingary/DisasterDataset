# Split a column from csv file
# Install tidyr package
library(tidyr)

# Read Dataset
myData = read.csv("DisasterEvent.csv")
 View(myData)

# Duplicate the column"DATETIME"
DATETIME2 <- myData$DATETIME
# ?cbind
myData1 <- cbind(myData, DATETIME2)
 View(myData1)
# ?separate()
myData2 <- separate(myData1, DATETIME2, c("Date","Time"), sep = " ")
View(myData2)

# Save as CSV file
write.csv(myData2, "DisasterEvent_Split.csv")
