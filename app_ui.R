# Shiny demo 
# May 12, 2021

#install packages
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


selector_rankingx <- selectInput('freq_lvl', 'Select a Frequency Level', choices = c("L500k", "L1k", "L2k", "L3k", "L4k", "L6k", "L8k",
                                                       "R500k", "R1k", "R2k", "R3k", "R4k", "R6k", "R8k"), selected = "L500k")
selector_rankingy <- selectInput(
  inputId = "age_group", 
  label = "Select an age group", 
  choices = unique(hearing_cleaned_2$age_group), 
  selected = "1")
# --------- CREATE PAGES ---------- 
page_zero <- tabPanel(
  "Overview",
  mainPanel(
    h5("Purpose:"),
    p("The purpose of our research project is to inform workers in loud industries on what they can do to prevent hearing loss in life and promote hearing loss 
      prevention initiatives. Hearing is essential for maintaining relationships and connections with friends and family, fully participating 
      in team and community activities, and experiencing life events. Hearing makes it possible to engage, listen, laugh, and enjoy many of 
      the things that help shape your quality of life. Hopefully our resource will bring some light into how these different industries impact their workers
      sense of hearing."),
    h5("Questions to Answer:"),
    p("Which ear is typically more susceptible to higher frequencies of noise at the same frequency? ie: compare left and right ear at 500 hertz."),
    p("Which age group is more susceptible to hearing loss and what industry does that correspond to?"),
    h5("Directions below! Enjoy!"),
    p("By clicking through the tabs, you will have a chance to explore and interact with our visualizations to gain insights into how hearing impacts
      the ear and you will learn about what industries are the worst for their workers. Then on the last tab, all the information you viewed will be summarized.")
  )
)
page_one <- tabPanel(
  "Page 1",                   #title of the page, what will appear as the tab name
  sidebarLayout(             
    sidebarPanel( 
      # left side of the page 
      # insert widgets or text here -- their variable name(s), NOT the raw code
      selector_xwidget,
      selector_ywidget,
      p("Frequency Levels:"),
      p("500K = 500 Hertz"),
      p("1K = 1000 Hertz"),
      p("2K = 2000 Hertz and so on...")
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
      selector_rankingy,
      p("Age Group:"),
      p("1 = 18-25 years"),
      p("2 = 36-35 years"),
      p("3 = 36-45 years"),
      p("4 = 46-55 years"),
      p("5 = 56-65 years")
    ),

    mainPanel(                # typically where you place your plots + texts
      # insert chart and/or text here -- the variable name NOT the code

      plotOutput("ranking")
    )))

page_three <- tabPanel(
  "Overview",
  mainPanel(
    h3("Conclusions and Analysis:"),
    h5("Hearing Analysis"),
    p("If we view the “Hearing Analysis” graph and compare, we can see that it is vital to compare the Left Ear Frequency and Right Ear Frequency at an
      equal margin (i.e. L500k, R500k;  L1K, R1K). If we look at this comparison of Left vs Right Ear, we can see which ear is more susceptible to noise. 
      Susceptible in this case means, which ear is more sensitive. As you can see off of this graph, we can see that the Left Ear is more susceptible, at 500k
      frequency, and this remains consistently through whether we look at 500K to 1K."),
    h5("Age Comparison Analysis"),
    p("However, if we view this in an age comparison lens - we can see that Ambulatory Health Care Services is the Worst job by industry, 
      because hearing loss is by 50 decibels, followed by Building Finish Contractors (40 decibels), Scale and Balance Manufacturing (30 decibels) 
      for age group 1, by age group 4, the order is as follows for worst hearing lost: Musical Groups (35 decibels), Equipment Manufacturing 
      (30 decibels), group 5: Rental Leasing (40 decibels), Motor Vehicle Parts (40 decibels), group 2: utilities (50 decibels), paper and products (40). 
      You can see that the higher the age group the more decibels wise hearing is worsened - particularly in the 2-5 age group.")
  )
)

# --------- DEFINING UI: PUTTING PAGES TOGETHER ---------- 
ui <- navbarPage(
  "Hearing Analysis for workers in different Industries",
  tabPanel("Overview",
           page_zero),
  tabPanel("Left vs Right ear",
           page_one),
  tabPanel("Age comparison",
           page_two),
  tabPanel("Conclusions",
           page_three)
)
