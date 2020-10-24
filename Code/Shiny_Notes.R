install.packages("shiny")
library(shiny)

# Create a new Shiny Project by copying and modifying existing Shiny apps

runExample("01_hello")      # a histogram
runExample("02_text")       # tables and data frames
runExample("03_reactivity") # a reactive expression
runExample("04_mpg")        # global variables
runExample("05_sliders")    # slider bars
runExample("06_tabsets")    # tabbed panels
runExample("07_widgets")    # help text and submit buttons
runExample("08_html")       # Shiny app built from HTML
runExample("09_upload")     # file upload wizard
runExample("10_download")   # file download wizard
runExample("11_timer")      # an automated timer

' Basic strucure of shiny application. Has major 2 functions.
            1.) UI.R &
                  # UI.r has 1 major function shinyUI()
                  # Above function takes a fluidpage argument which is a layout for html page. All the code goes inside it.
                  
                  # Eg.
                    shinyUI(fluidPage(
                              titlepanel("Title for the page"),
                              sidebarLayout(
                                    sidebarPanel(), # Add contents to be added to sidebar
                                    mainPanel() # Add contents to be added to main section
                              )
                  ))

            2.) server.R
                  # server.R has 1 major functuion shinyServer( function(input, output){ .. ..})
                  # inside the function(...){..here..})
                        2 major things are added :
                              1.) Functions to take & manipulate input from input$x variable
                              2.) output <- Functions (renderPrint, renderText, renderPlot) that return outputs (strings, plots, tables etc) for the main page 
                  
                  # Eg. shinyServer( function(input, output){
                        
                        Title <- reactive({
                              paste(input$title, " - ", " summary")
                        })
                        
                        Output$Title <- renderText({
                              Title()
                        })
                  
                  
                  })
                  
                  # Note all the functions have a "({ .. })" 2 brackets.
                  # Remember the output variable is a list & needs a name for each output, Here it is "Title".
                  
                  
                              
'