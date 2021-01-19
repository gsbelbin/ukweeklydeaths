setwd("~/UKWeeklyDeaths")
library(ggplot2)
library(tidyr)

deaths <- read.csv('weeklydeaths.csv', stringsAsFactors = FALSE, colClasses='integer')
names(deaths) <- c('Year', 1:52)  #  paste('Week', 1:52))
newdata <- gather(deaths, 'WeekNo', 'Deaths', -Year)

newdata$WeekNo <- as.integer(newdata$WeekNo)

ggplot(newdata) + geom_boxplot(data=newdata[newdata$Year < 2020,], mapping=aes(x=WeekNo, y=Deaths, group=WeekNo)) +
  geom_point(data=newdata[newdata$Year == 2020 & newdata$Deaths != 0,], mapping=aes(x=WeekNo, y=Deaths), colour='red') +
  geom_point(data=newdata[newdata$Year == 2021 & newdata$Deaths != 0,], mapping=aes(x=WeekNo, y=Deaths), colour='orange') +
  scale_x_continuous(breaks=1:52, minor_breaks=NULL) +
  scale_y_continuous(limits=c(0, 25000)) +
  labs(title='Total Deaths in England and Wales per Week from All Causes (ONS Data)',
       subtitle='Boxplots (including black dots) indicate the spread of weekly deaths for 2010-2019\nRed dots indicate the total weekly deaths so far in 2020 and 2021',
       x='Week Number', y='Total Deaths from All Causes in England and Wales')

ggsave("weeklydeaths.png")

ggplot() + geom_boxplot(data=newdata[newdata$Year < 2018,], mapping=aes(x=WeekNo, y=Deaths, group=WeekNo)) +
  geom_point(data=newdata[newdata$Year == 2020 & newdata$Deaths != 0,], mapping=aes(x=WeekNo, y=Deaths), colour='red') +
  geom_point(data=newdata[newdata$Year == 2019 & newdata$Deaths != 0,], mapping=aes(x=WeekNo, y=Deaths), colour='blue') +
  geom_point(data=newdata[newdata$Year == 2018 & newdata$Deaths != 0,], mapping=aes(x=WeekNo, y=Deaths), colour='green') +
  scale_x_continuous(breaks=1:52, minor_breaks=NULL) +
  scale_y_continuous(limits=c(0, 25000)) +
  labs(title='Total Deaths in England and Wales per Week from All Causes (ONS Data)',
       subtitle='Boxplots (including black dots) indicate the spread of weekly deaths for 2010-2018\nRed dots indicate the total weekly deaths so far in 2020',
       x='Week Number', y='Total Deaths from All Causes in England and Wales')




ggplot() +
  geom_line(data=newdata, mapping=aes(x=WeekNo, y=Deaths, colour=factor(Year))) +
  scale_x_continuous(breaks=1:52, minor_breaks=NULL) +
  scale_y_continuous(limits=c(0, 25000)) +
  labs(title='Total Deaths in England and Wales per Week from All Causes (ONS Data)',
              x='Week Number', y='Total Deaths from All Causes in England and Wales')
