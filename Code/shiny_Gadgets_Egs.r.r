library(shiny)
library(miniUI)

'
At it"s core shiny gadget is Fn launches a small single page shiny app.
miniUI library comes in handy for the graphical elements.
'

myfirstGadget <- function(){
        ui <- miniPage(
                gadgetTitleBar("My first gadget !!")
        )
                
        server <- function(input, output, session){
                # Done button
                observeEvent(input$done, { stopApp()})
        }
        runGadget(ui, server)
}

myfirstGadget()


'-------------------------------------------------------------------------------'

multiplyNumbers <- function(numbers1, numbers2){
        
        ui <- miniPage(
                gadgetTitleBar("Multiply 2 numbers"),
                miniContentPanel(
                        selectInput("Num1", "First Number", choices = numbers1),
                        selectInput("Num2", "Second Number", choices = numbers2)
                )
                
        )
        
        server <- function(input, output, session){
                observeEvent(input$done, {
                        n1 <- as.numeric(input$Num1)
                        n2 <- as.numeric(input$Num2)
                        stopApp(n1*n2) # Display the result and stop
                })
        }
        runGadget(ui, server)
}

N1 <- c(2,5,7)
N2 <- c(45,34,23)
multiplyNumbers(N1, N2)

"-------------------------------------------------------------------------------"

Data_from_Plot <- function(){
        
                ui <- miniPage(
                        gadgetTitleBar("Select points"),
                        plotOutput("plot", height = "100%", brush = "brush")
                )
                
                server <- function(input, output, session){
                        
                        # plot output
                        output$plot<- renderPlot({
                                plot(trees$Girth, trees$Height, col = "dodgerblue", pch = 16)
                        })
                        
                        # Reactivity
                        
                        observeEvent(input$done, {
                                stopApp( brushedPoints(trees, input$brush, xvar = "Girth", yvar = "Height"))
                        })
                        
                        
                }

                runGadget(ui, server)
        }

Data_from_Plot()














