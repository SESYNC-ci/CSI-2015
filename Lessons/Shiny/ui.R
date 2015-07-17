shinyUI(fluidPage(
  titlePanel("title panel"),
  
  sidebarLayout(
    sidebarPanel(selectInput("varchoice", 
                             label = "Choose a year to display",
                             choices = c("1990", "1996"),
                             selected = "1990")
    ),
    mainPanel(plotOutput("Plot"))
  )
))
