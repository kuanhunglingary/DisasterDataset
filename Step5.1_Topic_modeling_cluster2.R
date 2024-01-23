# Topic modeling
library(NLP)  
library(tm) 
library(RColorBrewer) 
library(wordcloud) 
library(topicmodels) 
library(SnowballC)

# cluster2
cluster2 <- read.csv("Cluster2.csv")
# dataframe to string
cluster2 <- toString(cluster2$MESSAGE)
cluster2

# Load Cluster2 as a Corpus
cluster2Corpus <- Corpus(VectorSource(cluster2))
cluster2Corpus

# Remove Stopwords
cluster2Corpus <- tm_map(cluster2Corpus, removeWords, stopwords('english'))

# Rmove Words
cluster2Corpus <- tm_map(cluster2Corpus, removeWords, c("hurricane","sandy","will"))

# Remove punctuations
cluster2Corpus <- tm_map(cluster2Corpus, removePunctuation)
cluster2Corpus

# Word Cloud
pal <- brewer.pal(8, "Dark2")
wordcloud(cluster2Corpus, min.freq=15, max.words = 150, random.order = TRUE, col = pal)

# cluster2 Topic modeling
doc.lengths <- rowSums(as.matrix(DocumentTermMatrix(cluster2Corpus)))
dtm <- DocumentTermMatrix(cluster2Corpus[doc.lengths > 0])
model <- LDA(dtm, 4) 
SEED = sample(1:1000000, 1) 
k = 4

models <- list(
  CTM       = CTM(dtm, k = k, control = list(seed = SEED, var = list(tol = 10^-4), em = list(tol = 10^-3))),
  VEM       = LDA(dtm, k = k, control = list(seed = SEED)),
  VEM_Fixed = LDA(dtm, k = k, control = list(estimate.alpha = FALSE, seed = SEED)),
  Gibbs     = LDA(dtm, k = k, method = "Gibbs", control = list(seed = SEED, burnin = 1000,
                                                               thin = 100,    iter = 1000))
)

lapply(models, terms, 4)

assignments <- sapply(models, topics) 
assignments
