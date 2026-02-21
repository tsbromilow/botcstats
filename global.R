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

options(sass.cache=FALSE)

source("scripts/theme.R")
source("scripts/prescript.R")
source("ui.R")
source("server.R")

# Run the application 
shinyApp(ui = ui, server = server)
