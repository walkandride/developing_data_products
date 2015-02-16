library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("US Crime Rates")
  
  # Sidebar with a droplist selection and footnote text.
  , sidebarLayout(
      sidebarPanel(
        selectizeInput("groups"
                       , label = "Select state grouping:"
                       , choices = NULL)
        
        , helpText("Data for assault, murder, and rape in each of the 50 US states in 1973.")
      )

      # Main panel with tabset.
      , mainPanel(
        tabsetPanel(
          tabPanel("Plot", plotOutput("plot"))
          , tabPanel("Table", tableOutput("table"))
          , tabPanel("Summary", verbatimTextOutput("summary")) 
        )
        , p(textOutput("label"))
      )      
    )
))