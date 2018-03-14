library(rvest)
library(magrittr)
library(XML)
library(ggplot2)


url <- "http://www.espn.com/nba/standings/_/season/2017/group/league"

table <- readHTMLTable(url,header = T,trim = T)

team=table[[2]]
record=table[[4]]

team <- cbind(team, record)



PPG <- as.numeric(levels(team$PPG)[team$PPG])
OOP <- as.numeric(levels(team$`OPP PPG`)[team$`OPP PPG`])
W <- as.numeric(levels(team$W)[team$W])
DIFF <- as.numeric(levels(team$DIFF)[team$DIFF])

ggplot() +
  geom_point(aes(x = PPG, y = OOP),color = 'red')
  
  
ggplot() +  
  geom_point(aes(x = W, y = DIFF), color = 'blue')