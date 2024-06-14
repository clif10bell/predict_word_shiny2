library(shiny)

# Define the server logic
server <- function(input, output, session) {
  output$result <- renderText({
    paste("You entered:", input$userInput)
  })
  
  ## Copy the prediction model
  find_last_word <- function(input_string, dt = combined_dt_reduced) {
    result <- lapply(input_string, function(x) {
      x <- tolower(x)
      x <- gsub("[^[:alnum:]' ]", "", x)  # Remove punctuation except for apostrophes
      words <- unlist(strsplit(x, " "))
      
      # Truncate the string to only the last four words if it has more than 4 words
      if (length(words) > 4) {
        words <- tail(words, 4)
      }
      
      while (length(words) > 0) {
        # Create the current base string from the words
        current_base <- paste(words, collapse = " ")
        
        # Get the number of words in the current base string
        num_words <- length(words)
        
        # Search for the rows in combined_dt
        matching_rows <- dt[order == (num_words + 1) & base == current_base, ]
        
        if (nrow(matching_rows) > 0) {
          # Return a data frame with the top three words and their probabilities
          return(matching_rows[1:3, .(last_word, prob)])
        } else {
          # Remove the first word and continue the search
          words <- words[-1]
        }
      }
      
      return(data.frame())
    })
    
    return(result)
  }
  
  output$output_table <- renderTable({
    result_df <- find_last_word(input$userInput)
    result_df
  })
}