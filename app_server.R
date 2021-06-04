# Shiny demo 
# May 12, 2021

# load packages 
library(ggplot2)
library(dplyr)
library(plotly)
library(shiny)
library(tidyr)

# Load data
hearing <- read.csv("Paper1_WebData_Final.csv")

# purpose: to determine if greater enrollment size affects immunization rates by
# county 
head(hearing)

# ------- CLEAN DATA --------- 
# 
# 
# 

hearing_cleaned <- hearing %>%
  select(L500k, L1k, L2k, L3k, L4k, L6k, L8k, R500k, R1k, R2k, R3k, R4k, R6k, R8k, age_group, NAICS_descr) %>% 
  drop_na()

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

# pivot graph longer
data_longer <- pivot_longer(hearing_cleaned_2, cols = L500k:R8k, names_to = "frequency")

# ------- INTERACTIVE VISUALIZAION PLOT ------- 
server <- function(input, output) {
  
  # further clean and/or manipulate the data based on the input from the widgets
  # any code that has input$ or output$ (ex. Your chart or a dataframe that 
  # will updated based on user input 
  # insert code for chart here
  
  output$outplot <- renderPlot({     #outplot is the name of the plot 
    # filters the dataset from the widgets

    
    
    # create plot
    ggplot(hearing_cleaned_2, aes_string(x = input$x, y = input$y)) +
      geom_count(col="tomato3", show.legend=F) + geom_smooth(method="lm", se=F) +
      labs(y="Right Ear Frequency (dB)",
           x="Left Ear Frequency (dB)")
      
  })
  

  industry <- data_longer %>% filter(input$age_group) %>% 
  group_by(NAICS_descr) %>% 
  summarise(l2k = mean(input$x)) %>% 
  arrange(desc(l2k)) %>% 
  head(n = 10L)

  output$ranking <- renderPlot({
    ggplot(industry, aes_string(NAICS_descr, input$x)) + geom_col() +
    aes_string(x = reorder(stringr::str_wrap(NAICS_descr, 28), + input$x)) + xlab(NULL) + ylab('decibels') +
    coord_flip()
  })
  
}