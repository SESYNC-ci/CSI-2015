# R Shiny example

install.packages("shiny")
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$Plot <- renderPlot({  
    hist(log(surveys[surveys$year==input$varchoice,"wgt"]),main="")
    
   
  })

  
})

