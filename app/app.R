# load libraries
library("shiny")
# library("shinythemes")
library("tidyverse")
library("dplyr")
# library("ggplot2")
library("plotly")

# use source() to execute the `app_ui.R` and `app_server.R` files, which will
# define the UI value and server function respectively
source("app_ui.R")
source("app_server.R")

# create a new `shinyApp()` using the loaded `ui` and `server` variables
shinyApp(ui = ui, server = server)