#load library
library(ggplot2)
library(scales)
library(glue)
library(plotly)
library(dplyr)
library(lubridate)
library(shiny)
library(shinydashboard)
library(DT)


data <- read.csv("datainput/vgsales.csv", stringsAsFactors = T,encoding = 'latin1')
# Removing the Rank column
data$Rank <- NULL

# Filtering only the records of interest for this study, removing the records with Year = NaN and records with the year above 2016
data <- data[data$Year != "N/A" & data$Year != "2017" & data$Year != "2020", ]