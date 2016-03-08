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