## TweetScrape Package:

This is my attempt to create a tweet scraper using R. RSelenium and Mozilla Firefox browser are used to accomplished the goals to scrape tweet about issues/news in the twitter platform. 

Steps to scrape tweet:
1. Install Mozilla Firefox browser.
2. Run devtools::install_github('FaizAzhar/tweetscrape') or clone this repo into your local machine.
3. Copy & run the 'main.R' document.
4. follow the prompt messages shown in the R console.
5. --top (is used to find the top tweet).
6. --latest (is used to find the latest tweet).
7. --people (is used to find the tweet posts by a tweet account).

EG: --top --50 --palestine 
Above command will scrape 50+ top tweets mentioning palestine.
