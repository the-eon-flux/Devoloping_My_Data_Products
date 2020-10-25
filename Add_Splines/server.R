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
    
    x <- mtcars[order(mtcars$disp),]
    ###############################################
    
    hideFit2 <- reactive({
        a <- input$hideFit2
        a
    })
    
    ###############################################
    
    Make_knots <- reactive({
        brk1 <- input$brk1
        brk2 <- input$brk2

        # Knot terms
        knots <- c(brk1, brk2)

        })

    ###############################################
    
    make_Splines <- reactive({
        
        
        #spline fit line
        splineTerms <- sapply(Make_knots(), function(knot){ifelse(x$disp - knot > 0, (x$disp - knot)^2, 0) })
        
        xMat <- cbind(Intercept = 1, Displacement = x$disp, splineTerms )
        colnames(xMat) <- c( "Intercept", "Displacement", "Knot1", "Knot2")
        xMat
    })
    
    ###############################################
    
    statCaption <- reactive({
        fit1 <- lm(wt ~ disp, x)
        
        Cap <- paste("Residual standard error : ", round(summary(fit1)$sigma,4), "  R-square : ", round(summary(fit1)$r.squared,4), sep="" )
        Cap
    })
    
    ###############################################
    
    statCaption2 <- reactive({
        fit2 <- lm(x$wt ~ make_Splines() -1 )
        
        Cap <- paste("Residual standard error : ", round(summary(fit2)$sigma,4), " Adjusted R-square : ", round(summary(fit2)$r.squared,4), sep="" )
        Cap
    })
    
    
    ###############################################
    
    output$Plot <- renderPlot({
        
        x <- mtcars[order(mtcars$disp),]
        
        # Plot
        par(mfrow=c(1,2))
        fit1 <- lm(wt ~ disp, x)
        P <- plot(x$disp, x$wt, pch = 16, xlab = "Displacement", ylab = "Weight", cex = 1.5, main = statCaption())
        
        # Linear fit
        P <- P + abline(fit1, lwd= 2, col="red")
        # Plot 2
        P <- P + plot(fit1, which = 1, cex = 1.5, pch = 16)
        
        
        ifelse(hideFit2(), {P},
                {
                    
                    fit1 <- lm(wt ~ disp, x)
                    fit2 <- lm(x$wt ~ make_Splines() -1 )
                    yhat <- predict(fit2)
                    
                    par(mfrow=c(1,2))
                    Q <- plot(x$disp, x$wt, pch = 16, xlab = "Displacement", ylab = "Weight", cex = 1.5, main = statCaption2())
                    
                    # Linear fit
                    Q <- Q + abline(fit1, lwd= 2, col="red")  # Fit1 line
                    Q <- Q + lines(x$disp, yhat, lwd = 2, col = "dodgerblue") # Fit2 line
                    Q <- Q + abline(v = Make_knots(), lwd = 2, col="green") # Adding break pts
    
                    # Plot 2
                    Q <- Q + plot(fit2, which = 1, cex = 1.5, pch = 16)
                    Q
            })
        
        

        })
    
    ###############################################
    
    output$summary1 <- renderPrint({
        fit1 <- lm(wt ~ disp, x)
        summary(fit1)
    })
    
    ###############################################
    
    output$summary2 <- renderPrint({
        fit2 <- lm(x$wt ~ make_Splines() -1 )
        summary(fit2)
    })
    
    ###############################################

    
})
