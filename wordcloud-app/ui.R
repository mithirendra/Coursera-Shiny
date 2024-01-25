#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
# Application title
fluidPage(
        
        # App title
        titlePanel("Generating a Word Cloud from a text input or text file"),
        
        # Sidebar
        sidebarLayout(
                sidebarPanel(
                        radioButtons(
                                inputId = "source",
                                label = "Choose your Word Source",
                                choices = c(
                                        "Type in your own words" = "own",
                                        "Upload your own text file" = "file"
                                )
                        ),
                        conditionalPanel(
                                condition = "input.source == 'own'",
                                textAreaInput("text", "Enter and type in your own text", value = "This is default text.", rows = 7)
                        ),
                        # Wrap the file input in a conditional panel
                        conditionalPanel(
                                # The condition should be that the user selects
                                # "file" from the radio buttons
                                condition = "input.source == 'file'",
                                fileInput("file", "Upload a text file")
                        ),
                        # fileInput("file", "Upload a text file", accept = c("text/plain", ".txt")),
                        sliderInput("num_wds", "Number of words to be included:",
                                    min = 10, max = 1000, value = 50)
                ),
                
                # Show word cloud
                mainPanel(
                        h4("Word Cloud Output:"),
                        h5("**Upload file to see output or input your own text to see output"),
                        h6("**Ignore any initial error message (due to no files or text being uploaded)"),
                        plotOutput("wc", width = "600px", height = "600px")
                )
        )
)