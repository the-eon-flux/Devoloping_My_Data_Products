#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    statInput <- reactive({
        switch (input$stat,
            "Mean" = mean,
            "Median" = median
        )
    })

    statCaption <- reactive({
        paste(input$stat, " eruption time", sep="" )
    })
    
    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'lightgray', border = 'dodgerblue', main = "Histogram of waiting time")

    })
    
    output$EruptionTimePlot <- renderPlot({
        
        fit <- lm(eruptions ~ waiting, faithful)
        
        plot(eruptions ~ waiting,faithful, ylab="Eruption time (mins)", xlab= "Waiting time for next eruption (mins)" , col = faithful$New, type ="p", pch = 16, main = "Eruption Time ~ Waiting Time; Linear model Fit", cex.axis = 1.2)
        abline(fit, lwd = 2, col ="dodgerblue")
        
        stat <- statInput()
        abline(h=stat(faithful$eruptions), col =2 )
        
        Cap <- statCaption()
        text(45,stat(faithful$eruptions)+ 0.15 , Cap, col = 2, adj = c(-.1, -.1), cex = 1.5 )
        })

})
