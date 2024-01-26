#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tm)
library(wordcloud)

# Define server logic
function(input, output) {
        
        # Reactive function
        process_text <- reactive({
                # Load text file
                #text <- readLines(input$file$datapath)
                if (input$source == "own") {
                        text <- input$text
                } else if (input$source == "file") {
                        text <- readLines(input$file$datapath)
                }
                # Convert text
                text <- tolower(text)
                text <- gsub("[[:punct:]]", "", text)
                
                # Tokenize
                text <- unlist(strsplit(text, "\\s+"))
                
                # Return text
                return(text)
        })
        
        # Generate word cloud
        output$wc <- renderPlot({
                wordcloud(process_text(), max.words = input$num_wds,
                          colors=brewer.pal(8, "Dark2"))
        })
        
}