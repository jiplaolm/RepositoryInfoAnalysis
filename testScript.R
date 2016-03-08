library(rlist)
library(pipeR)
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
                   secret = "989e783ac469c5703dafe3db35c9fbe780ef1e86")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jiplaolm", gtoken)
stop_for_status(req)
content(req)

# OR using Token:

req <- GET("https://api.github.com/orgs/EHUGasteiz/members",
           add_headers(Authorization="token 6b23a812a26088dfc79a586bc9a4842d13269abc"))
stop_for_status(req)
content(req)