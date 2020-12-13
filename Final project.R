library(readr)
library(dplyr)
nba <- read.csv("Sports Analytics/Seasons_Stats.csv")

#limit the time to post 2010 
nba <- subset(nba,Year >=2010)

#limit the position to PG only 

nba <- subset(nba, Pos =="PG")

#PTS =pts/total game
nba <- nba%>%mutate(PTS = PTS /G)%>%mutate(AST = AST/G)%>% mutate(FG = FG/G)%>%
  mutate(FGA=FGA/G)%>%mutate(X3P=X3P/G)%>%mutate(X3PA=X3PA/G)%>%mutate(FT=FT/G)%>%
    mutate(FTA=FTA/G)%>%mutate(STL=STL/G)%>%mutate(TOV=TOV/G)%>%mutate(BLK=BLK/G)%>%mutate(TRB=TRB/G)


#we want to subset only a key columns 
columns = c("Year","Player","Tm","G","PTS","TRB","AST","FG","FGA","X3P","X3PA","FT","FTA","STL","TOV","BLK")
nba1 <- nba%>%select(columns) 


#making some fancy group by code to combine players 
nba2 <- nba1%>% group_by(Player)%>%summarise(across(PTS:BLK,mean,na.rm=TRUE))
write.csv(nba2,"C:\\Users\\yinr1\\Desktop\\Sports Analytics\\Final_nba.csv", row.names = FALSE)
