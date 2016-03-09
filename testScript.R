source("auth.R")

library(rlist)
library(pipeR)
library(jsonlite)
repos <- "https://api.github.com/users/jiplaolm/repos?per_page=100&page=%d" %>>%
  sprintf(1:2) %>>%
  list.load("json") %>>%
  list.ungroup

repos


org <- "https://api.github.com/orgs/EHUGasteiz/members" %>>%
  sprintf(1:2) %>>%
  list.load("json") %>>%
  list.ungroup

org

library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("RepositoryInfoAnalysis",
                   key = "c9250479230abb9a683b",
                   secret = "089e1fed7f06fe76eae15bc879b4222eb40fd2d0")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/orgs/EHUGasteiz/members", gtoken)
stop_for_status(req)
content(req)



## Tokenaren bidez informazioa lortu ahal izateko
token <- paste("token", github_app_token)
req <- GET("https://api.github.com/orgs/EHUGasteiz/members", 
           add_headers(Authorization= token))
req
str(req)
stop_for_status(req)
answer <- content(req)
info <- fromJSON(content(req,"text"))
info


