library(bitops)
library(httr)
library(RCurl)
library(XML)
library(NLP)
library(tm)
library(tmcn)
library(jiebaRD)
library(jiebaR)
library(dplyr)
library(knitr)
library(Matrix)
library(ggplot2)


data <- list()
title <- list()

# Crawl PTT tennis board
for( i in c(1570:1597)){
  tmp <- paste(i, '.html', sep='')
  url <- paste('www.ptt.cc/bbs/Tennis/index', tmp, sep='')
  html <- htmlParse(GET(url),encoding = "UTF-8")
  title.list <- xpathSApply(html, "//div[@class='title']/a[@href]", xmlValue)
  url.list <- xpathSApply(html, "//div[@class='title']/a[@href]", xmlAttrs)
  data <- rbind(data, as.matrix(paste('www.ptt.cc', url.list, sep='')))
  title <- rbind(title, as.matrix(title.list))
}

data <- unlist(data)
title <- unlist(title)

# Filter w/ player's name

Federer <- c()
Federer.url <- c()

Federer1 <- grep("Federer", title)
Federer2 <- grep("費德勒", title)
Federer3 <- grep("費爸", title)

for(filter in c(Federer1, Federer2, Federer3)){
  Federer <- c(Federer,title[filter])
  Federer.url <- c(Federer.url, data[filter])
}

Nadal <- c()
Nadal.url <- c()

Nadal1 <- grep("Nadal", title)
Nadal2 <- grep("納達爾", title)
Nadal3 <- grep("蠻牛", title)

for(filter in c(Nadal1, Nadal2, Nadal3)){
  Nadal <- c(Nadal,title[filter])
  Nadal.url <- c(Nadal.url, data[filter])
}


Zverev <- c()
Zverev.url <- c()

Zverev1 <- grep("Zverev", title)
Zverev2 <- grep("Z弟", title)

for(filter in c(Zverev1, Zverev2)){
  Zverev <- c(Zverev,title[filter])
  Zverev.url <- c(Zverev.url, data[filter])
}


Thiem <- c()
Thiem.url <- c()

Thiem1 <- grep("Thiem", title)
Thiem2 <- grep("蒂姆", title)

for(filter in c(Thiem1, Thiem2)){
  Thiem <- c(Thiem,title[filter])
  Thiem.url <- c(Thiem.url, data[filter])
}



message <- list()
cc = worker()
Fed_TDF <- data.frame()
Nad_TDF <- data.frame()
Zve_TDF <- data.frame()
player <- c()
popular <- c()

# Crawl Federer's comments
for(i in c(1:length(Federer))){
  html <- htmlParse(GET(Federer.url[i]),encoding = "UTF-8")
  message.list <- xpathSApply(html, "//div[@class='push']/span[@class='f3 push-content']", xmlValue)
  message <- unlist(message.list)
  
  player <- c(player,"Federer")
  
  if(length(message) > 75){
    popular <- c(popular, "Hot")}
  else if(length(message) > 50){
    popular <- c(popular, "Warm")}
  else if(length(message) > 25){
    popular <- c(popular, "Medium")}
  else{
    popular <- c(popular, "Cold") }
  
  d.corpus <- VCorpus( VectorSource(message) )
  d.corpus <- tm_map(d.corpus, removePunctuation)
  d.corpus <- tm_map(d.corpus, removeNumbers)
  d.corpus <- tm_map(d.corpus, function(word) {
    gsub("[A-Za-z0-9]", "", word)
  })
  
  abc <- data.frame(table(cc[as.character(d.corpus)]))
  colnames(abc) <- c("word", as.character(i))
  
  if(i == 1){
    Fed_TDF <- abc}
  else{
    Fed_TDF <- merge(Fed_TDF, abc, by = "word", all = T)}
}

# Crawl Nadal's comments
for(i in c(1:length(Nadal))){
  html <- htmlParse(GET(Nadal.url[i]),encoding = "UTF-8")
  message.list <- xpathSApply(html, "//div[@class='push']/span[@class='f3 push-content']", xmlValue)
  message <- unlist(message.list)
  
  
  player <- c(player,"Nadal")
  
  if(length(message) > 75){
    popular <- c(popular, "Hot")}
  else if(length(message) > 50){
    popular <- c(popular, "Warm")}
  else if(length(message) > 25){
    popular <- c(popular, "Medium")}
  else{
    popular <- c(popular, "Cold") }
  
  d.corpus <- VCorpus( VectorSource(message) )
  d.corpus <- tm_map(d.corpus, removePunctuation)
  d.corpus <- tm_map(d.corpus, removeNumbers)
  d.corpus <- tm_map(d.corpus, function(word) {
    gsub("[A-Za-z0-9]", "", word)
  })
  
  abc <- data.frame(table(cc[as.character(d.corpus)]))
  colnames(abc) <- c("word", as.character(i))
  
  if(i == 1){
    Nad_TDF <- abc}
  else{
    Nad_TDF <- merge(Nad_TDF, abc, by = "word", all = T)}
}

# Crawl Zverev's comments
for(i in c(1:length(Zverev))){
  html <- htmlParse(GET(Zverev.url[i]),encoding = "UTF-8")
  message.list <- xpathSApply(html, "//div[@class='push']/span[@class='f3 push-content']", xmlValue)
  message <- unlist(message.list)
  
  player <- c(player,"Zverev")
  
  if(length(message) > 75){
    popular <- c(popular, "Hot")}
  else if(length(message) > 50){
    popular <- c(popular, "Warm")}
  else if(length(message) > 25){
    popular <- c(popular, "Medium")}
  else{
    popular <- c(popular, "Cold") }
  
  d.corpus <- VCorpus( VectorSource(message) )
  d.corpus <- tm_map(d.corpus, removePunctuation)
  d.corpus <- tm_map(d.corpus, removeNumbers)
  d.corpus <- tm_map(d.corpus, function(word) {
    gsub("[A-Za-z0-9]", "", word)
  })
  
  abc <- data.frame(table(cc[as.character(d.corpus)]))
  colnames(abc) <- c("word", as.character(i))
  
  if(i == 1){
    Zve_TDF <- abc}
  else{
    Zve_TDF <- merge(Zve_TDF, abc, by = "word", all = T)}
}


# Crawl Thiem's comments
for(i in c(1:length(Thiem))){
  html <- htmlParse(GET(Thiem.url[i]),encoding = "UTF-8")
  message.list <- xpathSApply(html, "//div[@class='push']/span[@class='f3 push-content']", xmlValue)
  message <- unlist(message.list)
  
  player <- c(player,"Thiem")
  
  if(length(message) > 75){
    popular <- c(popular, "Hot")}
  else if(length(message) > 50){
    popular <- c(popular, "Warm")}
  else if(length(message) > 25){
    popular <- c(popular, "Medium")}
  else{
    popular <- c(popular, "Cold") }
  
  d.corpus <- VCorpus( VectorSource(message) )
  d.corpus <- tm_map(d.corpus, removePunctuation)
  d.corpus <- tm_map(d.corpus, removeNumbers)
  d.corpus <- tm_map(d.corpus, function(word) {
    gsub("[A-Za-z0-9]", "", word)
  })
  
  abc <- data.frame(table(cc[as.character(d.corpus)]))
  colnames(abc) <- c("word", as.character(i))
  
  if(i == 1){
    Thi_TDF <- abc}
  else{
    Thi_TDF <- merge(Thi_TDF, abc, by = "word", all = T)}
}


Fed_TDF[is.na(Fed_TDF)] <- 0
Nad_TDF[is.na(Nad_TDF)] <- 0
Zve_TDF[is.na(Zve_TDF)] <- 0
Thi_TDF[is.na(Thi_TDF)] <- 0

kable(head(Fed_TDF))
kable(head(Nad_TDF))
kable(head(Zve_TDF))
kable(head(Thi_TDF))




# Turn TDM to TF-IDF
n <- length(Federer)
tf1 <- apply(as.matrix(Fed_TDF[,2:(n+1)]), 2, sum)
idfCal1 <- function(word_doc)
{ 
  log2( n / nnzero(word_doc) ) 
}
idf1 <- apply(as.matrix(Fed_TDF[,2:(n+1)]), 1, idfCal1)

doc1.tfidf <- Fed_TDF

for(x in 1:nrow(Fed_TDF))
{
  for(y in 2:ncol(Fed_TDF))
  {
    doc1.tfidf[x,y] <- (doc1.tfidf[x,y] / tf1[y-1]) * idf1[x]
  }
}

n <- length(Nadal)
tf2 <- apply(as.matrix(Nad_TDF[,2:(n+1)]), 2, sum)

idfCal2 <- function(word_doc)
{ 
  log2( n / nnzero(word_doc) ) 
}
idf2 <- apply(as.matrix(Nad_TDF[,2:(n+1)]), 1, idfCal2)

doc2.tfidf <- Nad_TDF

for(x in 1:nrow(Nad_TDF))
{
  for(y in 2:ncol(Nad_TDF))
  {
    doc2.tfidf[x,y] <- (doc2.tfidf[x,y] / tf2[y-1]) * idf2[x]
  }
}

n <- length(Zverev)
tf3 <- apply(as.matrix(Zve_TDF[,2:(n+1)]), 2, sum)
idfCal3 <- function(word_doc)
{ 
  log2( n / nnzero(word_doc) ) 
}
idf3 <- apply(as.matrix(Zve_TDF[,2:(n+1)]), 1, idfCal3)

doc3.tfidf <- Zve_TDF

for(x in 1:nrow(Zve_TDF))
{
  for(y in 2:ncol(Zve_TDF))
  {
    doc3.tfidf[x,y] <- (doc3.tfidf[x,y] / tf3[y-1]) * idf3[x]
  }
}

n <- length(Thiem)
tf4 <- apply(as.matrix(Thi_TDF[,2:(n+1)]), 2, sum)
idfCal3 <- function(word_doc)
{ 
  log2( n / nnzero(word_doc) ) 
}
idf4 <- apply(as.matrix(Thi_TDF[,2:(n+1)]), 1, idfCal3)

doc4.tfidf <- Thi_TDF

for(x in 1:nrow(Thi_TDF))
{
  for(y in 2:ncol(Thi_TDF))
  {
    doc4.tfidf[x,y] <- (doc4.tfidf[x,y] / tf3[y-1]) * idf4[x]
  }
}



# Display topwords

topwords <- subset(head(doc1.tfidf[order(doc1.tfidf[2], decreasing = TRUE), ]), select = c(word))
for (i in c(3:ncol(doc1.tfidf))){
  topwords <- cbind(topwords, head(doc1.tfidf[order(doc1.tfidf[i], decreasing = TRUE),])[1])
}


AllTop = as.data.frame( table(as.matrix(topwords)) )
AllTop = AllTop[order(AllTop$Freq, decreasing = TRUE),]

kable(head(AllTop))

topwords <- subset(head(doc2.tfidf[order(doc2.tfidf[2], decreasing = TRUE), ]), select = c(word))
for (i in c(3:ncol(doc2.tfidf))){
  topwords <- cbind(topwords, head(doc2.tfidf[order(doc2.tfidf[i], decreasing = TRUE),])[1])
}

AllTop = as.data.frame( table(as.matrix(topwords)) )
AllTop = AllTop[order(AllTop$Freq, decreasing = TRUE),]

kable(head(AllTop))


topwords <- subset(head(doc3.tfidf[order(doc3.tfidf[2], decreasing = TRUE), ]), select = c(word))
for (i in c(3:ncol(doc3.tfidf))){
  topwords <- cbind(topwords, head(doc3.tfidf[order(doc3.tfidf[i], decreasing = TRUE),])[1])
}

AllTop = as.data.frame( table(as.matrix(topwords)) )
AllTop = AllTop[order(AllTop$Freq, decreasing = TRUE),]

kable(head(AllTop))


topwords <- subset(head(doc4.tfidf[order(doc4.tfidf[2], decreasing = TRUE), ]), select = c(word))
for (i in c(3:ncol(doc4.tfidf))){
  topwords <- cbind(topwords, head(doc4.tfidf[order(doc4.tfidf[i], decreasing = TRUE),])[1])
}

AllTop = as.data.frame( table(as.matrix(topwords)) )
AllTop = AllTop[order(AllTop$Freq, decreasing = TRUE),]

kable(head(AllTop))




# Display Popularity


df1 <- data.frame(player,popular)

names(df1) <- c("Player", "Popularity")

ggplot(df1, aes(Player,fill = Popularity)) + geom_bar(position="dodge") 