runDriver <- function(){
  rd <- rsDriver(browser = "firefox",
                 chromever = NULL,
                 verbose = FALSE)
  remdr <- rd$client
  url <- "https://twitter.com/home"
  remdr$navigate(url)
  return(remdr)
}
