library(rvest)
library(magrittr)

url <- "https://www.flyingv.cc/projects?sort=hot"

page.source <- read_html(url)

titles <- page.source %>% html_nodes('.pcontent .title') %>% html_text(trim=TRUE)

team <- page.source %>% html_nodes('.pcontent a') %>% html_text(trim=TRUE)

content <- page.source %>% html_nodes('.pcontent .excerpt') %>% html_text(trim=TRUE)

amount <- page.source %>% html_nodes('.downMeta .goalMoney.osmfont') %>% html_text(trim=TRUE)

percent <- page.source %>% html_nodes('.downMeta .hidden-md.goalpercent') %>% html_text(trim=TRUE)

day_left <- page.source %>% html_nodes('.downMeta .date.pull-right.small') %>% html_text(trim=TRUE)

flyingV.df <- data.frame(titles, team,content,amount,percent,day_left)