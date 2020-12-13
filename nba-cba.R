library(readxl)
library(dplyr)
nba <- read_excel("Sports Analytics/Jeremy Lin.xlsx", 
                  sheet = "NBA")
cba <- read_excel("Sports Analytics/Jeremy Lin.xlsx", 
                  sheet = "CBA")
#calculate a ratio between points, rebs, assits and a few others 
cba <- cba%>%mutate(diff_pts=nba$PTS/cba$PTS)%>%mutate(diff_trb=nba$TRB/cba$TRB)%>%mutate(diff_ast=nba$AST/cba$AST)%>%
  mutate(diff_fg=nba$`FG%` /cba$`FG%`)%>%mutate(diff_fg3=nba$`FG3%` /cba$`FG3%`)%>%mutate(diff_ft=nba$`FT%`/cba$`FT%`)
  

#take an average 
pts_ratio = sum(cba$diff_pts,na.rm=TRUE)/10
reb_ratio = sum(cba$diff_trb,na.rm=TRUE)/10
ast_ratio = sum(cba$diff_ast,na.rm=TRUE)/10
fg_ratio = sum(cba$diff_fg,na.rm = TRUE)/10
fg_fg3 = sum(cba$diff_fg3,na.rm=TRUE)/10
fg_ft = sum(cba$diff_ft,na.rm=TRUE)/10
#based on Jermey Lin's stats last season in CBA
#he can score 22.3pts, get 5.7rebs, get 5.6 assits, get 0.495 fg percentage,get 0.327 fg3% and get 0.827 ft%

Lin_pts <- 22.3*pts_ratio
Lin_reb<- 5.7*reb_ratio
Lin_ast <- 5.6*ast_ratio
Lin_fg <- 0.495* fg_ratio
Lin_fg3 <- 0.327 * fg_fg3
Lin_ft <-  0.827 * fg_ft
