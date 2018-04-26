library(httr)
library(rjson)
library(httpuv)
library(Rfacebook)
library(plyr)
library(NLP)
library(tm)
library(xml2)
library(rvest)
library(SnowballC)
library(slam)
library(Matrix)
library(jiebaRD)
library(jiebaR)
library(RColorBrewer)
library(wordcloud)
library(tmcn)

prefex = "https://graph.facebook.com/v2.12/"

token  = "EAACEdEose0cBAOSv0Mbv9KJ8MjaZAMxoZAUlCLJZCOf7ec0mBCUowaIuGUyu1uehpKFuivqycx6qVcklnVxIFyOCpvkvSJwokJEoAJZCc6uZClEiyhZBHgI5YRbAz8ngYZBgqG5KqaZAqHgpoW5ROuP3IzHkSsP9flRT4e1vaoQeWF354KGao1AUYqmWrMmZAysoBOZC6po8xMlAZDZD"

attrs  = paste0("136845026417486/?fields=posts&access_token=")
url    = paste0(prefex, attrs, token)
res    = httr::GET(url)

posts <-  httr::content(res)

groups= matrix(unlist(posts$posts))


filename = paste0(1, ".txt")
write.table(groups,filename)

#未做文字清洗的文字雲
par(family='STKaiti')
filenames <- list.files(getwd(), pattern="*.txt")
files <- lapply(filenames, readLines)
docs <- Corpus(VectorSource(files))

toSpace <- content_transformer(function(x, pattern) {
  return (gsub(pattern, " ", x))
}

)

mixseg = worker()
segment <- c("柯文哲")
new_user_word(mixseg,segment)

jieba_tokenizer=function(d){
  unlist(segment(d[[1]],mixseg))
}
seg = lapply(docs, jieba_tokenizer)
freqFrame = as.data.frame(table(unlist(seg)))

wordcloud(freqFrame$Var1,freqFrame$Freq,
          min.freq=3,
          random.order=TRUE,random.color=TRUE, 
          rot.per=.1, colors=rainbow(length(row.names(freqFrame))),
          ordered.colors=FALSE,use.r.layout=FALSE,
          fixed.asp=TRUE)


#手動做文字清洗的文字雲

par(family='STKaiti')
filenames <- list.files(getwd(), pattern="*.txt")
files <- lapply(filenames, readLines)
docs <- Corpus(VectorSource(files))

toSpace <- content_transformer(function(x, pattern) {
  return (gsub(pattern, " ", x))
}

)

docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs,toSpace, "[A-Za-z0-9]")
docs <- tm_map(docs,toSpace, "的")
docs <- tm_map(docs,toSpace, "及")
docs <- tm_map(docs,toSpace, "為")
docs <- tm_map(docs,toSpace, "是")
docs <- tm_map(docs,toSpace, "在")
docs <- tm_map(docs,toSpace, "也")
docs <- tm_map(docs,toSpace, "要")
docs <- tm_map(docs,toSpace, "就")
docs <- tm_map(docs,toSpace, "有")
docs <- tm_map(docs,toSpace, "更")
docs <- tm_map(docs,toSpace, "讓")
docs <- tm_map(docs,toSpace, "了")
docs <- tm_map(docs,toSpace,"V1")
docs <- tm_map(docs,toSpace,"\n")
docs <- tm_map(docs,toSpace, "1")


mixseg = worker()
segment <- c("柯文哲")
new_user_word(mixseg,segment)

jieba_tokenizer=function(d){
  unlist(segment(d[[1]],mixseg))
}
seg = lapply(docs, jieba_tokenizer)
freqFrame = as.data.frame(table(unlist(seg)))

#畫出文字雲
wordcloud(freqFrame$Var1,freqFrame$Freq,
          min.freq=3,
          random.order=TRUE,random.color=TRUE, 
          rot.per=.1, colors=rainbow(length(row.names(freqFrame))),
          ordered.colors=FALSE,use.r.layout=FALSE,
          fixed.asp=TRUE)

#用 stopwordsCN() 做文字清洗的文字雲

docs <- tm_map(docs, removeWords, stopwordsCN())

mixseg = worker()
segment <- c("柯文哲")
new_user_word(mixseg,segment)

jieba_tokenizer=function(d){
  unlist(segment(d[[1]],mixseg))
}
seg = lapply(docs, jieba_tokenizer)
freqFrame = as.data.frame(table(unlist(seg)))

#畫出文字雲
wordcloud(freqFrame$Var1,freqFrame$Freq,
          min.freq=3,
          random.order=TRUE,random.color=TRUE, 
          rot.per=.1, colors=rainbow(length(row.names(freqFrame))),
          ordered.colors=FALSE,use.r.layout=FALSE,
          fixed.asp=TRUE)


