shinyUI(fluidPage(
  
  # Application title
  titlePanel("USGS Daily Values"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      a(href="http://maps.waterdata.usgs.gov/mapper/index.html", "Find site codes with NWIS Mapper"),
      
      textInput("inputId", label = "Input Site Code", value = "01491000"),
      radioButtons("inputP", label = "Chose parameter", choices = unique(dv_avilable$srsname))
    ),
    
        # Show a plot of the generated distribution
    mainPanel(
      plotOutput("ParameterPlot"),
      leafletOutput("mymap")
    )
  )
))