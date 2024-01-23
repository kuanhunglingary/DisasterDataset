# Text Mining
library(NLP)
library(tm)
library(SnowballC)

# Read CSV file
myData = read.csv("DisasterEvent_Split.csv",stringsAsFactors = FALSE)
View(myData)
myData$MESSAGE

# Remove Words
myData$MESSAGE <- gsub("\xa1", '', myData$MESSAGE)
myData$MESSAGE <- gsub("\xfd", '', myData$MESSAGE)
myData$MESSAGE <- gsub("\x93", '', myData$MESSAGE)
myData$MESSAGE <- gsub("\x81", '', myData$MESSAGE)
myData$MESSAGE <- gsub("\xf3", '', myData$MESSAGE)
myData$MESSAGE <- gsub("\xfc", '', myData$MESSAGE)
myData$MESSAGE <- gsub("\x9c", '', myData$MESSAGE)

# Remove "¡"
myData$MESSAGE <- gsub("¡", '', myData$MESSAGE)

# Remove URL
myData$MESSAGE <- gsub('http.* *', '', myData$MESSAGE)
myData$MESSAGE <- gsub('http.*\\s*', '', myData$MESSAGE)
myData$MESSAGE <- gsub('http\\S+\\s*', '', myData$MESSAGE)
# View(myData)

# Remove Punctuation
myData$MESSAGE <- removePunctuation(myData$MESSAGE)

# lowercase
myData$MESSAGE <- tolower(myData$MESSAGE)

# Replacing “/”, “@” and “|” with space
myData$MESSAGE <- gsub("<", '', myData$MESSAGE)
myData$MESSAGE <- gsub(">", '', myData$MESSAGE)
myData$MESSAGE <- gsub("/", '', myData$MESSAGE)
myData$MESSAGE <- gsub("@", '', myData$MESSAGE)
myData$MESSAGE <- gsub("\\|", '', myData$MESSAGE)

# Remove Numbers
myData$MESSAGE <- tm::removeNumbers(myData$MESSAGE)

# Remove Stop Words
myData$MESSAGE <- tm_map(myData$MESSAGE, removeWords, stopwords('english'))
View(myData)

# Save as CSV file
write.csv(myData, "DisasterEvent_RemoveWords.csv")
