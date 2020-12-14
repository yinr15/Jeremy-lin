
#twitter api 
appname <- "CBA1"

## api key (example below is not a real key)
key <- "udUQijFz92nLzadZ4LOAim9Zx"

## api secret (example below is not a real key)
secret <- "mTZyoDUGzaHMSqMtd63455B5LgA3d4xKEowXU2M7ZOIPCxKkKR"


twitter_token <- create_token(
  app = appname,
  consumer_key = key,
  consumer_secret = secret,
  access_token = access_token,
  access_secret = access_secret)



J<- search_tweets(q="Jeremy Lin", n=1000,lang = "en",include_rts = FALSE)
J %>%
  count(location, sort = TRUE) %>%
  mutate(location = reorder(location,n)) %>%
  na.omit() %>%
  top_n(10) %>%
  ggplot(aes(x = location,y = n,fill=location)) +
  geom_col() +
  coord_flip() +
  labs(x = "Location",
       y = "Count",
       title = "Twitter users - unique locations ")
J$
  J$text <- gsub("http.*","",  J$text)
J$text <- gsub("https.*","", J$text)

J <- J %>%
  dplyr::select(text) %>%
  unnest_tokens(word, text)

J%>%
  count(word, sort = TRUE) %>%
  top_n(20) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(x = word, y = n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip() +
  labs(x = "Count",
       y = "Unique words",
       title = "Count of unique words found in #YouthSDGs tweets")


data("stop_words")

head(stop_words)# A tibble: 6 x 2


J<- J %>%
  anti_join(stop_words)# there should be fewer words now


J %>%
  count(word, sort = TRUE) %>%
  top_n(10) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(x = word, y = n,fill=word)) +
  geom_col() +
  xlab(NULL) +
  coord_flip() +
  labs(y = "Count",
       x = "Unique words",
       title = "Count of top 10 unique words found in Jeremy Lin tweets")


library(wordcloud) 
library(reshape2)
J%>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment,sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("blue","purple"),
                   max.words = 150)