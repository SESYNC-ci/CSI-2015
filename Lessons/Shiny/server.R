# R Shiny example

# install.packages("shiny")
# install.packages("dataRetrieval",repos="http://owi.usgs.gov/R")
# devtools::install_github("rstudio/leaflet")
library(leaflet)
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
  siteNumber <- input$inputId
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
  
  output$mymap <- renderLeaflet({
    m <- leaflet() %>%
      # addTiles() %>%  # Add default OpenStreetMap map tiles
      # addProviderTiles("MapBox") %>%
      # addProviderTiles("Esri.WorldImagery") %>%
      addProviderTiles("Esri.WorldTopoMap") %>%
      setView(lng=SiteInfo$dec_long_va, lat=SiteInfo$dec_lat_va, zoom = 12) %>%
      addMarkers(lng=SiteInfo$dec_long_va, lat=SiteInfo$dec_lat_va, popup=SiteInfo$station_nm)
    m  # Print the map
    
  })
  
})