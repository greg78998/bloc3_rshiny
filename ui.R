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
shinyUI(
  fluidPage( 
    HTML("<h3>Premier pas avec Shiny<h3>"),
    
    column(width=6), 
    column(width=6),
    checkboxInput("checkbox", "Voir le reste de la page", 
                  value = FALSE),
    wellPanel(
      
      conditionalPanel(
        condition = "input.checkbox == true",
        
        sliderInput("bins",
                    "Number of bins:",
                    min = 1,
                    max = 50,
                    value = 30),
        
        
        
        #selectInput(inputId = "color",
        #            label="couleur :",
        #            choices = c("Rouge"="red", "Vert"="green", "Bleu" = "blue")),
        colourInput(inputId = "color",
                    value = "red",
                    label="choix des couleurs :", 
                    showColour = "text"),
        
        textInput(inputId = "titleGraphique",
                  label="Intégrer le nom du graphique :"),
        
        radioButtons(inputId="VarChoice",
                     label = "Choisir la variable à modéliser", 
                     choices=colnames(faithful)),
        
        #textInput(inputId="BinNB", 
        #           label = "Nombre de catégories")
      )), 
    
    # Show a plot of the generated distribution
    
    navlistPanel("Une vision globale",
                 tabsetPanel(id = "viz",
                             tabPanel('Visualisation', 
                                      conditionalPanel(
                                        condition = "input.checkbox == true",
                                        br(), br(),br(),br(),br(),
                                        plotOutput("distPlot"),
                                        plotOutput("displot2"),
                                        verbatimTextOutput("summary"))),
                             tabPanel('Données ',
                                      dataTableOutput("table")),
                             tabPanel('Graphiques interactifs',
                                      amChartsOutput(outputId = "displot3"), 
                                      amChartsOutput(outputId = "displot4"))
                             )
                 )
    )
  )
  
  
  