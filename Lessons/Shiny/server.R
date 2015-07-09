# R Shiny example

# install.packages("shiny")
library(shiny)
library(dataRetrieval)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  dv_avilable <- whatNWISdata(siteNumber, service="dv")
  
  output$ParameterPlot <- renderPlot({
    siteNumber <- input$inputId
    parameterName <- input$inputP
    parameterCd <- dv_avilable[dv_avilable$srsname==parameterName,"parm_cd"][1]
    begin_date <- dv_avilable[dv_avilable$srsname==parameterName,"begin_date"][1]
    end_date <- dv_avilable[dv_avilable$srsname==parameterName,"end_date"][1]
    parameterUnits <- dv_avilable[dv_avilable$srsname==parameterName,"parameter_units"][1]
    siteInfo <- readNWISsite(siteNumber)
    rawDailyData <- readNWISdv(siteNumber,parameterCd, begin_date,end_date)
    
    plot(rawDailyData$Date, rawDailyData[,4], 
         type="l", col="blue",
         ylab=parameterUnits, xlab="")
  })
  
})