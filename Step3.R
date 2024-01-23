# Step 3.1 csv to ARFF
library(foreign)

# READ CSV file
myData <- read.csv("DisasterEvent_RemoveWords.csv")

write.arff(myData,"DisasterEvent.arff")

