# Milestone 5   Cluster1
library(NLP)
library(tm)
library(SnowballC)
library(RColorBrewer)
library(wordcloud)
# Read Cluster1
myCluster1 <- read.csv("Cluster1.csv")
View(myCluster1)

# dataframe to string
myData <- toString(myCluster1$MESSAGE)
myData

# Load Cluster1 as a Corpus
myCluster1Corpus <- Corpus(VectorSource(myData))

# Remove Stopwords
myCluster1Corpus <- tm_map(myCluster1Corpus, removeWords, stopwords('english'))

# Remove Words
myCluster1Corpus <- tm_map(myCluster1Corpus, removeWords, c("can","will","hurricane","sandy"))

# Remove punctuations
myCluster1Corpus <- tm_map(myCluster1Corpus, removePunctuation)
myCluster1Corpus

# Word cloud # Build a term-document matrix
dtm <- TermDocumentMatrix(myCluster1Corpus)
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
barplot(d[1:10,]$freq, las = 2, names.arg = d[1:10,]$word,
        col ="lightblue", main ="Most frequent words",
        ylab = "Word frequencies")

# Generate the Word cloud (TOP 10)
set.seed(1234)
wordcloud(words = d[1:10,]$word, freq = d[1:10,]$freq, min.freq = 1,
          max.words=470, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))


