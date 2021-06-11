library(shiny)
library(conflicted)
library(tidyr)
library(ggplot2)
library(plotly)
library(dplyr)


last_plot <- plotly::last_plot
filter <- dplyr::filter
layout <- plotly::layout
lag <- dplyr::lag
intersect <- dplyr::intersect
setdiff <- dplyr::setdiff
setequal <- dplyr::setequal 
union <- dplyr::union

source("app_ui.R")
source("app_server.R")

shinyApp(ui = ui, server = server)