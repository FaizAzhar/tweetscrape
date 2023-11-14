setwd("C:/Users/farea/Documents/RWorkspace/tweetscrape")
devtools::load_all('.')
pkgs <- c("RSelenium","httr","rvest","dplyr","data.table")
suppressWarnings(lapply(pkgs, require, character.only = TRUE))

# call runDriver
rDrive <- runDriver()
cat("Press [enter] after complete login procedure: ");
readLines("stdin",n=1);
Sys.sleep(3)
# rDrive$open()
# start while loop
continue <- 'y'
while(continue == 'y'){
  cat("Enter search keyword: ");
  input <- tolower(unlist(strsplit(gsub(' ','',readLines("stdin",n=1)), split = "--"))[-1]);
  cat("Start scraping \n");
  twt_lim <- case_when(
    (length(input) == 2 & !is.na(suppressWarnings(as.numeric(input[1])))) ~ suppressWarnings(as.numeric(input[1])),
    (length(input) == 3 & !is.na(suppressWarnings(as.numeric(input[1])))) ~ suppressWarnings(as.numeric(input[1])),
    (length(input) == 3 & !is.na(suppressWarnings(as.numeric(input[2])))) ~ suppressWarnings(as.numeric(input[2])),
    .default = 5
  )
  query <- input[length(input)]
  if(input[1] == "top"){
    res <- top(query, twt_lim, rDrive)
    if(class(try(load(paste0(getwd(),"/top_tweet.Rda")))) == "try-error"){
      top_tweet <- res
      save(top_tweet, file=paste0(getwd(),"/top_tweet.Rda"))
    }else{
      load(file=paste0(getwd(),"/top_tweet.Rda"))
      top_tweet <- rbind(top_tweet, res)
      save(top_tweet, file=paste0(getwd(),"/top_tweet.Rda"))
    }}
  else if(input[1] == "latest"){
    res <- latest(query, twt_lim, rDrive)
    if(class(try(load(paste0(getwd(),"/latest_tweet.Rda")))) == "try-error"){
      latest_tweet <- res
      save(latest_tweet, file=paste0(getwd(),"/latest_tweet.Rda"))
    }else{
      load(file=paste0(getwd(),"/latest_tweet.Rda"))
      latest_tweet <- rbind(latest_tweet, res)
      save(latest_tweet, file=paste0(getwd(),"/latest_tweet.Rda"))
    }}
  else if(input[1] == "people"){
    res <- people(query, twt_lim, rDrive)
    if(class(try(load(paste0(getwd(),"/people_tweet.Rda")))) == "try-error"){
      people_tweet <- res
      save(people_tweet, file=paste0(getwd(),"/people_tweet.Rda"))
    }else{
      load(file=paste0(getwd(),"/people_tweet.Rda"))
      people_tweet <- rbind(people_tweet, res)
      save(people_tweet, file=paste0(getwd(),"/people_tweet.Rda"))
    }}
  else{
    res <- top(query, twt_lim, rDrive)
    res <- res$tab
    if(class(try(load(paste0(getwd(),"/top_tweet.Rda")))) == "try-error"){
      top_tweet <- res
      save(top_tweet, file=paste0(getwd(),"/top_tweet.Rda"))
    }else{
      load(file=paste0(getwd(),"/top_tweet.Rda"))
      top_tweet <- rbind(top_tweet, res)
      save(top_tweet, file=paste0(getwd(),"/top_tweet.Rda"))
  }}
  cat("Continue? [y/n] ");
  continue <- readLines("stdin",n=1);
  rDrive$goBack()
  Sys.sleep(7)
}

# close browser
rDrive$close()
cat('session ended..')
