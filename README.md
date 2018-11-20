# twitter-wordcloud
generates a wordcloud by scraping tweets from twitter


=========================================
(1) Get your own Twitter API by creating a developer account.
(2) Find:

    consumerAPI <- consumerAPI
    consumerSecretAPI <- consumerSecretAPI
    accessAPI <- accessAPI
    accessSecretAPI <- accessSecretAPI

  inside wordcloud_generator.R and replace the rightside with your API keys.
  
  WARNING: DO NOT SHARE YOUR API KEYS WITH ANYONE.
  
(3) Replace mask.png with an image mask of your choice.
    The mask must be a black-and-white image.
    
(4) Run the script on your RStudio, and there you have it.

(5) If you want, you can change your N value to scrape more tweets.

(6) After you run once, try to filter out nonsense words by adding them into the filter.
    You can find the filter inside word_generator.R:
	
	#Remove other nonsense words
	result <-result %>%
	filter(!word %in% c('t.co', 'https', 'handmaidstale', "handmaid's", 'season', 'episode', 'de', 'handmaidsonhulu',
						'tvtime', 'watched', 'watching', 'watch', 'la', "it's", 'el', 'en', 'tv', 'je', 'ep', 'week',
						'amp', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'amp', 'http', 'wgng3spngl'))

(7)	Simply add the nonsense words you do not want inside the bracket.
	Do not forget to put them inside quotation marks.
