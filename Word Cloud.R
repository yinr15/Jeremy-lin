
library(twitteR)
library(ROAuth)
library(NLP)
library(syuzhet)
library(tm)
library(SnowballC)
library(topicmodels)
library(base64enc)
library(wordcloud)
#twitter api 
consumer_key <- 'udUQijFz92nLzadZ4LOAim9Zx'
consumer_secret <- 'mTZyoDUGzaHMSqMtd63455B5LgA3d4xKEowXU2M7ZOIPCxKkKR'
access_token <- '908086217421373440-dadgxMHTIZnXAavk6xoXYff5eANJPU3'
access_secret <- 'MOhIRuMKsvJ5tqnfy0yWQPCU0hbzBuZPt0j4qpngMWhqO'
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

#search
tweets_lin <- searchTwitter("jeremy lin", n=1000,lang = "en")

#save to df 
Lin_df <-  twListToDF(tweets_lin)


#data cleaning 
Lin_text <- Lin_df$text
Lin_text <- tolower(Lin_text)
Lin_text <- gsub("rt","",Lin_text)
Lin_text <- gsub("@\\w+", "", Lin_text)
Lin_text <- gsub("[[:punct:]]", "", Lin_text)
Lin_text <- gsub("http\\w+", "", Lin_text)
Lin_text <- gsub("[ |\t]{2,}", "", Lin_text)
Lin_text <- gsub("^ ", "", Lin_text)
Lin_text <- gsub(" $", "", Lin_text)

test <- Lin_text%>%VectorSource()%>%Corpus()

test <- test%>%tm_map(test,removeWords,stopwords("english"))
Lin_shorter_text <- tm_map(test, function(x)removeWords(x,stopwords()))



#generate wordcloud
wordcloud(Lin_shorter_text,min.freq = 10,colors=brewer.pal(8, "Dark2"),random.color = TRUE,max.words = 500)
