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

hearing_cleaned <- hearing %>% select(L500k, L1k, L2k, L3k, L4k, L6k, L8k, R500k, R1k, R2k, R3k, R4k, R6k, R8k, age_group, NAICS_descr) %>% drop_na()

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
#                                 label = "Left Ear Frequency",
#                                label = "Right Ear Frequency",
#                                 label = "Select a Frequency Level",
selector_xwidget <- selectInput('x', 'Left Ear Frequency', choices = c("L500k", "L1k", "L2k", "L3k", "L4k", "L6k", "L8k"), selected = "L500k")

selector_ywidget <- selectInput('y', 'Right Ear Frequency', choices = c("R500k", "R1k", "R2k", "R3k", "R4k", "R6k", "R8k"), selected = "R500k")

selector_rankingx <- selectInput('x', 'Select a Frequency Level', choices = c("L500k", "L1k", "L2k", "L3k", "L4k", "L6k", "L8k",
                                                       "R500k", "R1k", "R2k", "R3k", "R4k", "R6k", "R8k"), selected = "L500k")
selector_rankingy <- selectInput(
  inputId = "age_group", 
  label = "Select an age group", 
  choices = unique(hearing_cleaned_2$age_group), 
  selected = "1")
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

page_two <- tabPanel(
  "Page 2",                   #title of the page, what will appear as the tab name
  sidebarLayout(             
    sidebarPanel( 
      # left side of the page 
      # insert widgets or text here -- their variable name(s), NOT the raw code
      selector_rankingx,
      selector_rankingy
    ),           
    mainPanel(                # typically where you place your plots + texts
      # insert chart and/or text here -- the variable name NOT the code
      plotOutput("ranking")
    )))

# --------- DEFINING UI: PUTTING PAGES TOGETHER ---------- 
ui <- navbarPage(
  "Hearing Analysis",
  tabPanel("Left vs Right ear",
           page_one),
                                  #insert other pages here
  tabPanel("Age comparison",
  page_two)
)
