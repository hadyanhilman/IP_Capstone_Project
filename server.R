
server <- function(input,output){
    
    output$year_plot <- renderPlotly({
        freq_year1 <- data %>% 
            group_by(Year) %>% 
            summarise(Total_sales = sum(Global_Sales)) %>% 
            ungroup()
        
        freq_year1_2 <- tail(freq_year1, input$num_year) %>% 
            mutate(label = glue("Publish Year: {Year}
                      Total Sales: {comma(Total_sales)}"))
        
        plot3 <- ggplot(freq_year1_2, aes(x= Year, y= Total_sales)) +
            geom_line(group = 1,col ="seagreen") +
            geom_point(aes(text = label), 
                       col = "navy") +
            labs(title = "Video Game Sales",
                 x = "Publish Year",
                 y = "Total Sales , in million") +
            theme_minimal()+
            theme(legend.position = "none",
                  plot.title = element_text(face = "bold",hjust = 0.5),
                  plot.subtitle = element_text(hjust = 0.5)) 
        
        ggplotly(plot3, tooltip = "text")
    })
    
    output$bar_year <- renderPlotly({
        freq_year <- data %>% filter(Genre == input$Genre) %>% 
            group_by(Year) %>% 
            summarise(Freq = n()) %>% 
            ungroup() %>% 
            arrange(desc(Freq)) %>% 
            mutate(label = glue("Publish Year: {Year}
                      Freq: {comma(Freq)}")) %>% head(10)
        
        plot1 <- ggplot(freq_year, aes(x = Freq, y = reorder(Year, Freq), text = label)) +
            geom_col(aes(fill = Freq)) +
            labs(title =  paste("Top 10 Number of Video Game Release for", input$Genre , 'Genre By Year'),
                 x = "Year",
                 y = NULL) +
            scale_fill_gradient(low = "aquamarine", high= "orange") +
            scale_x_continuous(labels = comma) +
            theme_minimal() +
            theme(legend.position = "none",
                  plot.title = element_text(face = "bold",hjust = 0.5),
                  plot.subtitle = element_text(hjust = 0.5)) 
        
        ggplotly(plot1, tooltip = "text")
    })
    
    output$plot_platform <- renderPlotly({
        
        top_10_2 <-   data %>% filter(Genre == input$Genre1) %>% group_by(Platform)%>% 
            summarise(Total_sales = sum(Global_Sales)) %>% 
            arrange(desc(Total_sales)) %>% 
            mutate(label = glue("Platform Name: {Platform}
                      Total Sales: {comma(Total_sales)}")) %>% head(10)
        
        plot2 <- ggplot(top_10_2, aes(x = Total_sales, y =  reorder(Platform, Total_sales), text = label)) +
            geom_col(aes(fill = Total_sales)) +
            labs(title =  paste("Top 10 Best Selling Platform Performance for", input$Genre1,"Genre"),
                 x = "Total Sales , in million",
                 y = NULL) +
            scale_fill_gradient(low = "aquamarine", high= "orange") +
            scale_x_continuous(labels = comma) +
            theme_minimal() +
            theme(legend.position = "none",
                  plot.title = element_text(face = "bold",hjust = 0.5),
                  plot.subtitle = element_text(hjust = 0.5)) 
        
        ggplotly(plot2, tooltip = "text")
    })
    
    output$plot_name <- renderPlotly({
        top_10 <-   data %>% filter(Genre == input$Genre1) %>% group_by(Name)%>% 
            summarise(Total_sales = sum(Global_Sales)) %>% 
            arrange(desc(Total_sales)) %>% 
            mutate(label = glue("Game Name: {Name}
                      Total Sales: {comma(Total_sales)}")) %>% head(10) 
        
        plot2 <- ggplot(top_10, aes(x = Total_sales, y =  reorder(Name, Total_sales), text = label)) +
            geom_col() +
            labs(title =  paste("Top 10 Best Selling Game For", input$Genre1,"Genre"),
                 x = "Total Sales , in million",
                 y = NULL) +
            scale_fill_gradient(low = "aquamarine", high= "orange") +
            scale_x_continuous(labels = comma) +
            theme_minimal() +
            theme(legend.position = "none",
                  plot.title = element_text(face = "bold",hjust = 0.5),
                  plot.subtitle = element_text(hjust = 0.5))  
        
        ggplotly(plot2, tooltip = "text")
    })
    
    output$myTable <- renderDataTable({
        data %>%
            datatable(
                .,
                rownames = FALSE,
                class = "table",
                options = list(pageLength = 10, scrollX = T),
            )
        
    })
    
}