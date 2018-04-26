library(httr)
library(rjson)
library(httpuv)
library(Rfacebook)

token <- "EAACEdEose0cBAHziQpPVisBOYzeRcTaH93RcZAD9p45CCL1Y5Xd101g5SoZBiuVHUZBQ0pBmnusk6WR7h8ZCrmEXzF8SCKXiCl7V33Da0hskhWiEqB42FYa9bz4WrN0ZBFfBhmFBNZB4psojhRzCOknaRYAUyOHQNVCN1viCZAD1m1sUxBy6JS9t13SvCFhrsQeXg5yqWHHBgZDZD"
prefex_post <- "https://graph.facebook.com/v2.12/me/?fields=posts&access_token="
url <- paste0(prefex_post, token)
# Get the response of the url (ex. posts)
res <- httr::GET(url)
# Get the content of the url
posts <- content(res)
res

for( x in 1:25){
  print(posts$posts$data[[x]]$message)
}

