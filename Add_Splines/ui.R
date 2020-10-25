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
shinyUI(fluidPage(

    # Application title
    titlePanel("Linear regression with a spline term"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            
            h4('Move the sliders below to optimize the R squared value. Remember the closer it is to 1, the better it is'),
            br(),
            
            h5("First check the below box to show the added spline terms."),
            checkboxInput("hideFit2", "Hide/Show Spline Term Line", value = TRUE),
            
            h5('Move the slider to change the break point 1'),
            sliderInput("brk1",
                        "Breakpoint 1",
                        min = 150,
                        max = 250,
                        value = 200),
            br(),
            h5('Move the slider to change the break point 2'),
            # Break point 2 setting
            sliderInput("brk2",
                            "Breakpoint 2",
                            min = 300,
                            max = 400,
                            value = 350)
            
        ),
    
        # Show a plot of the generated distribution
        mainPanel(
        
            tabsetPanel(type = "pills",
                        tabPanel("Plot", plotOutput("Plot", width = "100%" )),
                        tabPanel("Summary fit 1", verbatimTextOutput("summary1")),
                        tabPanel("Summary fit 2", verbatimTextOutput("summary2"))
                ), br(),
            div( h4(strong('Guide : ')), br(),
                p(' - Consider the plot in the `Plot` tab, linear models does not actually capture the whole essence of this relationship. Also look at the value of R squared (0.78); which is the percentage variation explained by the model'), br(),
                p(' - We can see that it is low for the linear model (Red fit). Check on the hide/show splineterms to show the spline terms and see how R square changes.'), br(),
               p(' - This is because linear models are the linear combination between the dependent and independent variables, which is almost always an approximation, and sometimes a poor one. '), br(),
               p(' - Polynomial regression extends the linear model by adding extra predictors, obtained by raising each of the original predictors to a power. For example, a cubic regression uses three variables , as predictors. ') , br(),
               p(' - This approach provides a simple way to provide a non-linear fit to data. In the backend 2 more squared terms of x will be added when you change the values of the slider.'), br(),
               p('Play around with the slider values and try to find an optimal spline term for the best fit. Fit is updated each time. Resulting additional parameters can be viewed in the summary tabs'), br(),br()
               )
            
        )
    )
))
