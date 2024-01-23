# Milestone 5 - Cluster0
library(NLP)
library(tm)
library(SnowballC)
library(RColorBrewer)
library(wordcloud)
# Read Cluster0
myCluster0 <- read.csv("Cluster0.csv")
View(myCluster0)
# dataframe to string
myData <- toString(myCluster0$MESSAGE)
myData

# Load Cluster0 as a Corpus
myCluster0Corpus <- Corpus(VectorSource(myData))
# myCluster0Corpus

# Remove Stopwords
myCluster0Corpus <- tm_map(myCluster0Corpus, removeWords, stopwords('english'))

# Rmove Words
myCluster0Corpus <- tm_map(myCluster0Corpus, removeWords, c("can","hurricane","sandy","sandyhelp"))

# Remove punctuations
myCluster0Corpus <- tm_map(myCluster0Corpus, removePunctuation)
myCluster0Corpus

# Word cloud
# Build a term-document matrix
dtm <- TermDocumentMatrix(myCluster0Corpus)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)

# Generate the Word cloud
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 15,
          max.words=450, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

# TOP 10
# Plot word frequencies
barplot(d[1:30,]$freq, las = 2, names.arg = d[1:30,]$word,
        col ="lightblue", main ="Most frequent words",
        ylab = "Word frequencies")

# Generate the Word cloud (TOP 10)
set.seed(1234)
wordcloud(words = d[1:10,]$word, freq = d[1:10,]$freq, min.freq = 15,
          max.words=450, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
