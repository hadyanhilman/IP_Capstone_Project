ui<- dashboardPage(
    dashboardHeader(title = "Video Game Sales Analytics"),
    
    dashboardSidebar(
        sidebarMenu(
            menuItem(text = "Overview", tabName = "overview", icon = icon("video")),
            menuItem(text = "Genre Analysis", tabName = "channel", icon = icon("bullseye")),
            menuItem(text = "Data", tabName = "data", icon = icon("table"))
        )
    ),
    dashboardBody(
        
        tabItems(#berguna untuk mengakses menu per identitas yg dipanggil
            
            tabItem(
                tabName = "overview",
                
                
                box(width = 12,
                        sliderInput(inputId = "num_year", #nama pengisiannya bebas
                                    label = "Number of Year",
                                    min = 5 ,
                                    max = 20,
                                    value = 10   )),
                
                
                box(
                    #title = "Annual Video Games Sales Report",
                    width =  12 , #nilai max adalah 12
                    plotlyOutput(outputId = "year_plot")
                ),
                
                
                box( width = 12,
                     selectInput(inputId = "Genre",
                                 label = "Choose Your Genre",
                                 choices = unique(data$Genre),
                                 selected = "Action")),
                
                
                box(
                   # title = "Top 10 Num of Game Release by Year",
                    width =  12 , #nilai max adalah 12
                    plotlyOutput(outputId = "bar_year")
                )
            ),
            
            tabItem(
                tabName = "channel",
                
                box( width = 12,
                     selectInput(inputId = "Genre1",
                                 label = "Choose Your Genre",
                                 choices = unique(data$Genre),
                                 selected = "Action")
                ),
                
                
                box(width = 12,
                        plotlyOutput(outputId = "plot_name")),
                box(width = 12,
                        plotlyOutput(outputId = "plot_platform"))
                
                
            ),
            
            tabItem(
                tabName = "data",
                
                box( width = 12,
                     h3("Browse All"),
                     tags$br(),
                     dataTableOutput("myTable"),
                     tags$br(),
                     tags$br()
                )
                
                
            )
        )
        
    )
    
)