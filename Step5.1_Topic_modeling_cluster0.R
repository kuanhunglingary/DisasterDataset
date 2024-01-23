# Topic modeling
library(NLP)  
library(tm) 
library(RColorBrewer) 
library(wordcloud) 
library(topicmodels) 
library(SnowballC)

# cluster0
cluster0 <- read.csv("Cluster0.csv")
# dataframe to string
cluster0 <- toString(cluster0$MESSAGE)
cluster0

# Load Cluster0 as a Corpus
cluster0Corpus <- Corpus(VectorSource(cluster0))
cluster0Corpus

# Remove Stopwords
cluster0Corpus <- tm_map(cluster0Corpus, removeWords, stopwords('english'))

# Rmove Words
cluster0Corpus <- tm_map(cluster0Corpus, removeWords, c("can","hurricane","sandy","sandyhelp"))

# Remove punctuations
cluster0Corpus <- tm_map(cluster0Corpus, removePunctuation)
cluster0Corpus

# Word Cloud
pal <- brewer.pal(8, "Dark2")
wordcloud(cluster0Corpus, min.freq=15, max.words = 150, random.order = TRUE, col = pal)

# cluster0 Topic modeling
doc.lengths <- rowSums(as.matrix(DocumentTermMatrix(cluster0Corpus)))
dtm <- DocumentTermMatrix(cluster0Corpus[doc.lengths > 0])
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


