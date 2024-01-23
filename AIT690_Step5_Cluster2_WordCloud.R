# Milestone 5 - Cluster2
library(NLP)
library(tm)
library(SnowballC)
library(RColorBrewer)
library(wordcloud)
# Read Cluster2
myCluster2 <- read.csv("Cluster2.csv")
View(myCluster2)

# dataframe to string
myData <- toString(myCluster2$MESSAGE)
myData

# Load Cluster2 as a Corpus
myCluster2Corpus <- Corpus(VectorSource(myData))

# Remove Stopwords
myCluster2Corpus <- tm_map(myCluster2Corpus, removeWords, stopwords('english'))

# Remove Words
myCluster2Corpus <- tm_map(myCluster2Corpus, removeWords, c("hurricane","sandy","will"))

# Remove punctuations
myCluster2Corpus <- tm_map(myCluster2Corpus, removePunctuation)
myCluster2Corpus

# Word cloud # Build a term-document matrix
dtm <- TermDocumentMatrix(myCluster2Corpus)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)

# Generate the Word cloud
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 10,
          max.words=450, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

# TOP 10
# Plot word frequencies
barplot(d[1:10,]$freq, las = 2, names.arg = d[1:10,]$word,
        col ="lightblue", main ="Most frequent words",
        ylab = "Word frequencies")
?barplot
# Generate the Word cloud (TOP 10)
set.seed(1234)
wordcloud(words = d[1:10,]$word, freq = d[1:10,]$freq, min.freq = 15,
          max.words=450, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

