#Please install all related package if you don't have

library(readr)
library(ggplot2)
library(forecast)
library(fpp2)
library(TTR)
library(dplyr)
ibrary(tidyverse)   # metapackage of all tidyverse packages
library(tidyr) 
library(tidyselect)
library(plotly)
library(wordcloud2)
library(reactable)
library(htmlwidgets)
library(IRdisplay)
#Loading the dataset
data<-read.csv("unemployment analysis.csv")
View(data)
str(data)
countries_uemply_rate<-aggregate(X2021~Country.Name + X2020, data, max)

reactable(countries_uemply_rate)

plot_ly(countries_uemply_rate, x=~X2020, y=~Country.Name, type='scatter', mode='markers', color = ~X2020, colors ='Reds')

plot_ly(countries_uemply_rate, x=~X2021, y=~Country.Name, type='scatter', mode='markers', color= ~X2021, colors='Blues')

#Unemployment rete in 1991 vs 2021
unemployment_1991_2021<-data%>%group_by(Country.Name)%>%summarise(max_1991=max(X1991), max_2021=max(X2021))%>%top_n(10)

head(unemployment_1991_2021)

M1<-plot_ly(unemployment_1991_2021, x=~Country.Name, y=~max_1991, type='bar')%>%layout(yaxis=list(categoryorder = "total ascending"))%>%layout(yaxis=list(title='Rate'), title='Country by Year Unemployment Rate (max) - 1991')

M2<-plot_ly(unemployment_1991_2021, x=~Country.Name, y=~max_2021, type='bar')%>%layout(yaxis=list(categoryorder = "total ascending"))%>%layout(yaxis=list(title='Rate'), title='Country by Year Unemployment Rate (max) - 2021')

saveWidget(v3, "v3.html")
display_html('<iframe src="v3.html" width=100% height=400></iframe>')

saveWidget(v4, "v4.html")



subplot(M1, M2, titleX = TRUE, titleY = TRUE)%>%layout(title='Country by Year Uemployment Rate - 1991 & 2021')

saveWidget(sub_plot1, "sub_plot1.html")
display_html('<iframe src="sub_plot1.html" width=100% height=400></iframe>')
display_html('<iframe src="v4.html" width=100% height=400></iframe>')




unemployment_1993_1994<-data%>%group_by(Country.Name)%>%summarise(max_2000=max(X2021), max_2001=max(X2021))%>%top_n(20)

head(unemployment_1993_1994)

plot_ly(unemployment_1993_1994, labels=~Country.Name, values=~max_2000, type='pie')%>%layout(title='Percentage of Umployment Rate by Country - 2021')

plot_ly(unemployment_1993_1994, labels=~Country.Name, values=~max_2001, type='pie')%>%layout(title='Percentage of Umployment Rate by Country - 2001')

saveWidget(v5, "v5.html")
display_html('<iframe src="v5.html" width=100% height=400></iframe>')

saveWidget(v6, "v6.html")
display_html('<iframe src="v6.html" width=100% height=400></iframe>')
