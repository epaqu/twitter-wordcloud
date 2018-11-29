consumerAPI <- consumerAPI
consumerSecretAPI <- consumerSecretAPI
accessAPI <- accessAPI
accessSecretAPI <- accessSecretAPI
N <- 2000

require(devtools)
library(tidytext)
library(dplyr)
library(stringr)
library(rtweet)
library(wordcloud2)
library(webshot)
library(htmlwidgets)

generateCloud <-  function(term, conAPI, conSecret, accAPI, accSecret) {

  create_token(
    app = "트위터 워드클라우드",
    consumer_key = conAPI,
    consumer_secret = conSecret,
    access_token = accAPI,
    access_secret = accSecret
  )

  searchTerm <- paste("#", term, sep="")
  
  #Grab N tweets from twitter.
  tweets <- search_tweets(
    searchTerm, n = N, include_rts = FALSE
  )

  #Use Tidytext to unnest the scraped tweets.
  result <- tweets %>% 
    unnest_tokens(word, text)

  #Remove stop words from the unnested words.
  data(stop_words)
  result <- result %>%
    anti_join(stop_words)

  #Remove other words of your choice.
  result <-result %>%
    filter(!word %in% c('t.co', 'https', 'handmaidstale', "handmaid's", 'season', 'episode', 'de', 'handmaidsonhulu',
                        'tvtime', 'watched', 'watching', 'watch', 'la', "it's", 'el', 'en', 'tv', 'je', 'ep', 'week',
                        'amp', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'amp', 'http', 'wgng3spngl'))
  
  #plots
  wordcloud2(result, size=10, figPath = "mask.png", color = "#EB0510", fontFamily="Times New Roman")
  
  #you can also create a letter cloud:
  #letterCloud(result, word="NETFLIX", size=5, wordSize=2, fontFamily="Knights Quest", color="white", backgroundColor="pink")
}

generateCloud("netflix", consumerAPI, consumerSecretAPI, accessAPI, accessSecretAPI, N)
