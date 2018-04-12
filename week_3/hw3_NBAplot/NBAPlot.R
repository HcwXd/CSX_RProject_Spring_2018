library(rvest)
library(magrittr)
library(XML)
library(ggplot2)
#install.packages('SportsAnalytics')

library(SportsAnalytics)

NBA1516<-fetch_NBAPlayerStatistics("15-16") 


url <- "http://www.espn.com/nba/standings/_/season/2017/group/league"

table <- readHTMLTable(url,header = T,trim = T)

team=table[[2]]
record=table[[4]]

team <- cbind(team, record)

PPG <- as.numeric(levels(team$PPG)[team$PPG])
OOP <- as.numeric(levels(team$`OPP PPG`)[team$`OPP PPG`])
W <- as.numeric(levels(team$W)[team$W])
DIFF <- as.numeric(levels(team$DIFF)[team$DIFF])

#Correlation between Team's and Opponents's points
ggplot() +
  geom_point(aes(x = PPG, y = OOP),color = 'red')
  
#Correlation between Team's wins and Score difference
ggplot() +  
  geom_point(aes(x = W, y = DIFF), color = 'blue')

#Correlation between player's FGM and Points
qplot(FieldGoalsAttempted, TotalPoints, data = NBA1516)

#Correlation between players's average points and average FGM, divided by positions and teams
qplot(TotalPoints/GamesPlayed, FieldGoalsMade/GamesPlayed, data = NBA1516, facets = . ~ Position, color = Team)
