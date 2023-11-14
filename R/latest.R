#' latest
#'
#' @param q A string.
#' @param lim An integer to limit number of tweets scrape.
#' @param rDrive An object of RSelenium driver.
#'
#' @return A tibble which is automatically stored in latest_tweet.rda
#' @export
#'

latest <- function(q,lim,rDrive){
  srch <- rDrive$findElement(using = "xpath", value = "//input[@data-testid = 'SearchBox_Search_Input']")
  srch$sendKeysToElement(list(q, key = "enter"))
  Sys.sleep(7)
  snap <- rDrive$findElement(using = "xpath", value = "//span[contains(text(),'Latest')]")
  snap$clickElement()
  Sys.sleep(7)
  df.user <- c()
  df.time <- c()
  df.tweet <- c()
  df.reply <- c()
  df.repost <- c()
  df.like <- c()
  final_height = 0
  while(TRUE){
    articles <- rDrive$findElements(using = "xpath", value = "//article[@data-testid = 'tweet']")
    if(length(articles) == 0){print('No results for query'); break}
    for(article in articles){
      user <- article$findChildElement(using = "xpath", value = ".//div[@data-testid = 'User-Name']")
      df.user <- append(df.user, user$getElementText())
      if(class(suppressWarnings(try(article$findChildElement(using = "xpath", value = ".//time")))) == 'try-error'){
        df.time <- append(df.time, NA)}
      else{
        dtime <- article$findChildElement(using = "xpath", value = ".//time")
        df.time <- append(df.time, dtime$getElementAttribute('datetime'))
      }
      tweet <- article$findChildElement(using = "xpath", value = ".//div[@data-testid = 'tweetText']")
      df.tweet <- append(df.tweet, tweet$getElementText())
      reply <- article$findChildElement(using = "xpath", value = ".//div[@data-testid='reply']")
      df.reply <- append(df.reply, reply$getElementText())
      repost <- article$findChildElement(using = "xpath", value = ".//div[@data-testid='retweet']")
      df.repost <- append(df.repost, repost$getElementText())
      like <- article$findChildElement(using = "xpath", value = ".//div[@data-testid='like']")
      df.like <- append(df.like, like$getElementText())
    }
    if(length(unique(df.tweet)) > lim) break
    rDrive$executeScript("window.scrollTo(0,document.body.scrollHeight);")
    Sys.sleep(7)
    new_height = rDrive$executeScript("return document.body.scrollHeight")
    if(unlist(final_height) == unlist(new_height)) break
    else final_height == new_height
  }
  return(data.table(user=df.user,timestamp=df.time,tweet=df.tweet,
                    reply=df.reply,retweet=df.repost,like=df.like))
}
