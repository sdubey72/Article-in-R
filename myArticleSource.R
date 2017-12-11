gutenberg_works(title=='A Tale of Two Cities')

tale<-gutenberg_download(98)

tale_1<-tale%>%
  unnest_tokens(word,text)

sent<-get_sentiments('nrc')


#sent[!duplicated(sent$sentiment),]

new_tale<-inner_join(tale_1,sent)

new_tale$gutenberg_id<-NULL

new_tale<-new_tale%>%
  group_by(word)%>%
  summarize(freq=n(),sentiment=first(sentiment))

ggplot()+
  geom_bar(data=new_tale,aes(x=sentiment,y=freq),stat = 'identity',fill='#D35400')


wordcloud(new_tale$word,new_tale$freq,min.freq =50,ordered.colors = TRUE)

wordcloud2(new_tale,fontFamily = 'Ariel',fontWeight ='bold',minSize = 5 )

wordcloud2(new_tale, color = "random-light", backgroundColor = "grey")


## Warning in if (class(data) == "table") {: the condition has length 1 and only the first element will be used
## Error in loadNamespace(name): there is no package called 'webshot