# load libraries
library("shiny")
# library("shinythemes")
library("tidyverse")
library("dplyr")
# library("ggplot2")
library("plotly")

source("app_ui.R")

# read and store the dataset
co2_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")
View(co2_data)

# What is the average value of CO2 emissions across all countries in 2021?
avg_co2_emissions <- co2_data %>%
  filter(year == 2021) %>%
  summarize(avg_co2 = mean(co2, na.rm=TRUE))
View(avg_co2_emissions)

# Where are CO2 emissions the lowest?
highest_co2_emissions <- co2_data %>%
  group_by(country) %>%
  summarize(avg_co2 = mean(co2, na.rm=TRUE)) %>%
  filter(avg_co2 == max(avg_co2, na.rm=TRUE)) %>%
  pull(country)

# How much has the average value of CO2 emissions across all countries changed in the last 100 years?
diff_avg_co2 <- co2_data %>%
  filter(year == 1921 | year == 2021) %>%
  group_by(year) %>%
  summarize(avg_co2 = mean(co2, na.rm=TRUE)) %>%
  summarize(diff = max(avg_co2) - min(avg_co2)) %>%
  pull(diff)
  
server <- function(input, output) {
  output$plot <- renderPlotly({
    
    title <- paste0(input$country_var, " GDP v.s. CO2 Emissions")
    
    plotData <- co2_data %>%
      filter(country %in% input$country_var)
    
    scatterPlot <- ggplot(co2_data, aes(x=gdp, y=co2), color=input$color) + 
      labs(x="GDP", y="CO2 emissions", title = title)
    scatterPlot
  })
}
