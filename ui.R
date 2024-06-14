library(shiny)
library(here)

combined_dt_reduced <- readRDS(file = here("RDS_Files", "combined_dt_reduced.rds"))

# Define the UI
ui <- fluidPage(
  # App title
  titlePanel("The Fabulous Predict-A-Word"),
  
  # Sidebar panel for user input
  sidebarLayout(
    sidebarPanel(
      textInput("userInput", "Enter a text string:")
    ),
    
    # Main panel
    mainPanel(
      # Introduction
      h3("Instructions"),
      p("Enter a text string in the side panel. The table below shows up to three possible
               words to complete the string, and their estimated probabilities."),
      
      # Display the result from server.R
      verbatimTextOutput("result"),
      tableOutput("output_table")
    )
  )
)