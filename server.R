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
function(input, output, session) {
  
  observeEvent(
    input$color, {
      updateTabsetPanel(session, 
                        inputId = "viz", 
                        selected = "Visualisation")
  })
  data <- reactive({
    faithful[,input$VarChoice]
  })
  
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x <- data()
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    #bins <- seq(1,input$BinNB)
    
    # draw the histogram with the specified number of bins
    hist(x, 
         breaks = bins, 
         col = input$color, 
         border = 'white',
         xlab = 'Waiting time to next eruption (in mins)',
         main = input$titleGraphique)  
  })
  
  output$summary <- renderPrint({
    summary(x)
  }) 
  
  output$table <- renderDataTable(faithful)
  
  # boxplot(x, col = input$color, border = 'white',
  #       xlab = 'BoxPlotWaiting time to next eruption (in mins)',
  #      main = input$titleGraphique)
  
  
  output$displot2 <- renderPlot({
    x    <- data()
    
    boxplot(x,col = input$color, border = 'black',
            xlab = 'Distribution',
            main = "Boite à moustache")
    
    output$displot3 <- renderAmCharts({
      x    <- data()
      bins <- round(
        seq(min(x),max(x), length.out=input$bins+1),
            2)
      
      amHist(x,
             col = input$color, 
             control_hist=list(breaks=bins),
             border = 'black',
             xlab = 'Distribution',
             main = input$titleGraphique,
             export = TRUE, 
             zoom=TRUE) })
    
    output$displot4 <- renderAmCharts({
      amPlot(faithful$eruptions, faithful$waiting, 
             bullet = "diamond")
    })
    
    
    
  })
  
  
  
  
}
