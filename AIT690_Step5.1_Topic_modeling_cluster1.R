# Topic modeling
library(NLP)  
library(tm) 
library(RColorBrewer) 
library(wordcloud) 
library(topicmodels) 
library(SnowballC)

# cluster1
cluster1 <- read.csv("Cluster1.csv")
# dataframe to string
cluster1 <- toString(cluster1$MESSAGE)
cluster1

# Load Cluster1 as a Corpus
cluster1Corpus <- Corpus(VectorSource(cluster1))
cluster1Corpus

# Remove Stopwords
cluster1Corpus <- tm_map(cluster1Corpus, removeWords, stopwords('english'))

# Rmove Words
cluster1Corpus <- tm_map(cluster1Corpus, removeWords, c("can","will","hurricane","sandy"))

# Remove punctuations
cluster1Corpus <- tm_map(cluster1Corpus, removePunctuation)
cluster1Corpus

# Word Cloud
pal <- brewer.pal(8, "Dark2")
wordcloud(cluster1Corpus, min.freq=15, max.words = 150, random.order = TRUE, col = pal)

# cluster1 Topic modeling
doc.lengths <- rowSums(as.matrix(DocumentTermMatrix(cluster1Corpus)))
dtm <- DocumentTermMatrix(cluster1Corpus[doc.lengths > 0])
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