library(shiny)
library(bslib)
library(dplyr)
library(tidyr)
library(tibble)
library(purrr)
library(stringr)
library(bsicons)
library(DT)
library(reactable)
library(htmltools)
library(htmlwidgets)

source("scripts/prescript.R")
source("scripts/theme.R")

# Run the application 
shinyApp(ui = ui, server = server)
