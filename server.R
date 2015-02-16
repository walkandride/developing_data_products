library(shiny)
library(datasets)

# Define server logic for USArrests data exploration.
shinyServer(function(input, output, session) {
  
  # This data set contains statistics, in arrests per 100,000 residents 
  # for assault, murder, and rape in each of the 50 US states in 1973. 
  # Also given is the percent of the population living in urban areas.
  dataset <- USArrests

  # Segregate the US states into regions and divisions based upon
  # http://en.wikipedia.org/wiki/List_of_regions_of_the_United_States#Official_regions_of_the_United_States

  #Region 1: Northeast
  new_england <- c('Connecticut'
                   , 'Maine'
                   , 'Massachusetts'
                   , 'New Hampshire'
                   , 'Rhode Island'
                   , 'Vermont')
  mid_atlantic <- c('New Jersey'
                    , 'New York'
                    , 'Pennsylvania')
  #Region 2: Midwest
  east_north_central <- c('Illinois'
                          , 'Indiana'
                          , 'Michigan'
                          , 'Ohio'
                          , 'Wisconsin')
  west_north_central <- c('Iowa'
                          , 'Kansas'
                          , 'Minnesota'
                          , 'Missouri'
                          , 'Nebraska'
                          , 'North Dakota'
                          , 'South Dakota')
  #Region 3: South
  south_atlantic <-  c('Delaware'
                       , 'Florida'
                       , 'Georgia'
                       , 'Maryland'
                       , 'North Carolina'
                       , 'South Carolina'
                       , 'Virginia'
                       , 'West Virginia')
  east_south_central <- c('Alabama'
                          , 'Kentucky'
                          , 'Mississippi'
                          , 'Tennessee')
  west_south_central <- c('Arkansas'
                          , 'Louisiana'
                          , 'Oklahoma'
                          , 'Texas')
  #Region 4: West
  mountain <- c('Arizona'
                , 'Colorado'
                , 'Idaho'
                , 'Montana'
                , 'Nevada'
                , 'New Mexico'
                , 'Utah'
                , 'Wyoming')
  pacific <- c('Alaska'
               , 'California'
               , 'Hawaii'
               , 'Oregon'
               , 'Washington')
  
  
  ## ------------------------------------------------------------------------
  # Define renderers to update UI..
  ## ------------------------------------------------------------------------
  
  # Define a droplist with various categories/regions of states.
  updateSelectizeInput(session
                       , "groups"
                       , choices = list(
                         All_States = c('All 50 States')
                         , Region = c('Northeast'
                                    , 'Midwest'
                                    , 'South'
                                    , 'West')
                         , Division = c('New England'
                                        , 'Mid-Atlantic'
                                        , 'East North Central'
                                        , 'West North Central'
                                        , 'South Atlantic'
                                        , 'East South Central'
                                        , 'West South Central'
                                        , 'Mountain'
                                        , 'Pacific')
                       )
  )
  
  
  # Generate a plot of the data. Also uses the inputs to build the 
  # plot label.
  output$plot <- renderPlot({
    pairs(filtered_data()
          , panel = panel.smooth
          , cex=1.5
          , pch=23
          , bg="light blue"
          , cex.labels = 2
          , font.labels = 2
          , main = plot_label())
  })
  
  
  # Generate datatable view of the data
  output$table <- renderTable({
    filtered_data()
  })
  
  
  # Generate a summary of the data
  output$summary <- renderPrint({
    summary(filtered_data())
  })

  # listing of states based upon selection to be displayed
  output$label <- renderPrint({
    states_list()
  })
  
    

  ## ------------------------------------------------------------------------
  # Define reactive expressions to be used in multiple outputs.
  ## ------------------------------------------------------------------------
  
  # Create a vector of states based upon selection.  This
  # will be used as the filter to the plot, summary data,
  # data table listing, as well as identify the states
  # included (output$label).
  states_vec <- reactive({
    if (input$groups == 'Northeast')
      c(new_england, mid_atlantic)
    else if (input$groups == 'Midwest')
      c(east_north_central, west_north_central)
    else if (input$groups == 'South')
      c(south_atlantic, east_south_central, west_south_central)
    else if (input$groups == 'West')
      c(mountain, pacific)
    else if (input$groups == 'New England')
      new_england
    else if (input$groups == 'Mid-Atlantic')
      mid_atlantic
    else if (input$groups == 'East North Central')
     east_north_central
    else if (input$groups == 'West North Central')
      west_north_central
    else if (input$groups == 'South Atlantic')
      south_atlantic
    else if (input$groups == 'East South Central')
      east_south_central
    else if (input$groups == 'West South Central')
      west_south_central
    else if (input$groups == 'Mountain')
      mountain
    else if (input$groups == 'Pacific')
      pacific
    else # all 50 states
      sort(c(new_england
        , mid_atlantic
        , east_north_central
        , west_north_central
        , south_atlantic
        , east_south_central
        , west_south_central
        , mountain
        , pacific))
  })

  # identify list of states based upon selection
  states_list <- reactive({
    cat(sort(states_vec()), sep=", ")  
  })

  # define plot label based upon selection
  plot_label <- reactive({
    paste(input$groups, 'Arrest Data')
  })
  
  # filter dataset based upon selection
  filtered_data <- reactive({
    dataset[c(states_vec()),]
  })
  
})
