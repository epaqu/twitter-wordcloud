consumerAPI <- consumerAPI
consumerSecretAPI <- consumerSecretAPI
accessAPI <- accessAPI
accessSecretAPI <- accessSecretAPI
N <- 2000

run <-  function(term, conAPI, conSecret, accAPI, accSecret) {
  require(devtools)
  library(tidytext)
  library(dplyr)
  library(stringr)
  library(rtweet)
  library(wordcloud2)
  library(webshot)
  library(htmlwidgets)

  create_token(
    app = "트위터 워드클라우드",
    consumer_key = conAPI,
    consumer_secret = conSecret,
    access_token = accAPI,
    access_secret = accSecret
  )

  searchTerm <- paste("#", term, sep="")
  #Grab tweets - note: reduce to 1000 if it's slow
  tweets <- search_tweets(
    searchTerm, n = N, include_rts = FALSE
  )

  #Unnest the words - code via Tidy Text
  result <- tweets %>% 
    unnest_tokens(word, text)

  #remove stop words - aka typically very common words such as "the", "of" etc
  data(stop_words)
  result <- result %>%
    anti_join(stop_words)

  #do a word count
  result <- result %>%
    count(word, sort = TRUE) 
  result 

  #Remove other nonsense words
  result <-result %>%
    filter(!word %in% c('t.co', 'https', 'handmaidstale', "handmaid's", 'season', 'episode', 'de', 'handmaidsonhulu',
                        'tvtime', 'watched', 'watching', 'watch', 'la', "it's", 'el', 'en', 'tv', 'je', 'ep', 'week',
                        'amp', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'amp', 'http', 'wgng3spngl'))
  result

  myPalette <- c("#F47722", "#ED1A77", "#CB519D", "#F7B7D1")

  #plots
  wordcloud2(result, size=10, figPath = "C:/Users/Jaewoo/desktop/mask.png", color = "#EB0510", fontFamily="Times New Roman")
  #letterCloud(result, word="NETFLIX", size=5, wordSize=2, fontFamily="Knights Quest", color="white", backgroundColor="pink")
}

run("netflix", consumerAPI, consumerSecretAPI, accessAPI, accessSecretAPI, N)