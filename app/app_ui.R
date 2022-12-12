# load libraries
library("shiny")
library("dplyr")
library("plotly")

source("app_server.R")

# read and store the dataset
co2_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")
View(co2_data)

intro_panel <- tabPanel(
  "Introduction",
  titlePanel("Analysis of CO2 Emissions in the U.S."),
  br(),
  p("Climate change has recently become a pressing issue worldwide, with CO2 emissions drastically increasing
    within the past century. This project analyzes this change in CO2 emissions, with a focus on particular
    factors that contribute to the overall value. By presenting this data through an interactive visualization,
    I hope this project imparts upon viewers the importance of preventing further damage to the Earth's environment."),
  h3("Variables to Consider:"),
  p("In this project, I have chosen to focus on the amount of CO2 emitted across all countries. Most recently in the year 2021",
    round(avg_co2_emissions, digits=2), "was the average amount of CO2 emissions across all countries. The country with the highest
    level of CO2 emissions was ", highest_co2_emissions, ". As mentioned before, the amount of CO2 emitted across all countries has increased
    drastically, with an increase of ", diff_avg_co2, "over the past 100 years. The information provided here serves as good background for
    the interactive visualization presented, where we will further analyze the increase of CO2 emissions each year.")
)

country_input <- selectInput(
  inputId = "country_var",
  label = "Select a country: ",
  choices = unique(co2_data$country)
)

color_input <- selectInput(
  "inputId" = "color",
  label = "Choose a color",
  choices = list("Black" = "black", "Red" = "red", "Blue" = "blue", "Green" = "green")
)

#interactive visualization
inter_vis <- tabPanel(
  "Interactive Visualization",
  titlePanel("CO2 Emissions by Year"),
  sidebarLayout(
    sidebarPanel(
      country_input,
      color_input
    ),
    mainPanel(
      plotlyOutput("plot"),
      p("This interactive visualization displays the correlation between a selected country's GDP and its CO2 emissions.
        This information is valuable because it can help us identify trends between a country and its level of carbon emissions.
        The general trend from this visualization is the higher a country's gdp, the higher its carbon emissions. As producing
        goods requires resources, such as coal, oil, gas, etc., an increase in carbon emissions is expected the more goods a country
        produces.")
    )
  )
)

# define a ui variable
ui <- navbarPage(
  "Analysis of CO2 Emissions",
  intro_panel,
  inter_vis
)
    
