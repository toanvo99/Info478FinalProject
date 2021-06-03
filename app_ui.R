# Shiny demo 
# May 12, 2021

#install packages
library(shiny)
library(ggplot2)
library(plotly)
library(tidyr)

# read dataset 
# Load data
hearing <- read.csv("Paper1_WebData_Final.csv")

hearing_cleaned <- hearing %>% select(L500k, L1k, L2k, L3k, L4k, L6k, L8k, R500k, R1k, R2k, R3k, R4k, R6k, R8k) %>% drop_na()

hearing_cleaned_2 <- hearing_cleaned %>% 
  filter(hearing_cleaned$L500k %in% (0:996) & hearing_cleaned$L500k > '0' &
           hearing_cleaned$L1k %in% (0:996) & hearing_cleaned$L1k > '0' &
           hearing_cleaned$L2k %in% (0:996) & hearing_cleaned$L2k > '0' &
           hearing_cleaned$L4k %in% (0:996) & hearing_cleaned$L4k > '0' & 
           hearing_cleaned$L6k %in% (0:996) & hearing_cleaned$L6k > '0' & 
           hearing_cleaned$L8k %in% (0:996) & hearing_cleaned$L8k > '0' &
           hearing_cleaned$R500k %in% (0:996) & hearing_cleaned$R500k > '0' &
           hearing_cleaned$R1k %in% (0:996) & hearing_cleaned$R1k > '0' &
           hearing_cleaned$R2k %in% (0:996) & hearing_cleaned$R2k > '0' &
           hearing_cleaned$R3k %in% (0:996) & hearing_cleaned$R3k > '0' &
           hearing_cleaned$R4k %in% (0:996) & hearing_cleaned$R4k > '0' &
           hearing_cleaned$R6k %in% (0:996) & hearing_cleaned$R6k > '0' &
           hearing_cleaned$R8k %in% (0:996) & hearing_cleaned$R8k > '0')
# --------- CREATE WIDGETS ---------- 

# choose county widget (this widget allows you to 
# choose which county you want to have the plot focus on)

#select_values <- unique(immunizations$County)
#
#choose_county_widget <- selectInput(
#  inputId = "choose_county", 
#  label = "Select a county to observe", 
#  choices = select_values, 
#  selected = "KING")





# enrollment size widget (this widget allows you to choose the
# range of enrollment size)
#immunizations <- immunizations %>%
#  filter(K_12_enrollment != "NA")
#
#enrollment <- c(min(immunizations$K_12_enrollment), 
#                max(immunizations$K_12_enrollment))
#
#enrollment_size_widget <- sliderInput(inputId = "enrollment_size", 
#                                      label = "Choose enrollment size", 
#                                      min = enrollment[1], 
#                                      max = enrollment[2], 
#                                      value = enrollment)

selector_xwidget <- selectInput('x', 'X', choices = c("L500k", "L1k", "L2k", "L3k", "L4k", "L6k", "L8k"), selected = "L500k")
selector_ywidget <- selectInput('y', 'Y', choices = c("R500k", "R1k", "R2k", "R3k", "R4k", "R6k", "R8k"), selected = "R500k")
# --------- CREATE PAGES ---------- 
page_one <- tabPanel(
  "Page 1",                   #title of the page, what will appear as the tab name
  sidebarLayout(             
    sidebarPanel( 
      # left side of the page 
      # insert widgets or text here -- their variable name(s), NOT the raw code
      selector_xwidget,
      selector_ywidget
    ),           
    mainPanel(                # typically where you place your plots + texts
      # insert chart and/or text here -- the variable name NOT the code
      plotOutput("outplot")
    )))


# --------- DEFINING UI: PUTTING PAGES TOGETHER ---------- 
ui <- navbarPage(
  "Title",
  page_one
  #insert other pages here
)
