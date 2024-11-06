library(tidyverse)   
library(shiny)

gpmdata <- read_csv("Gapminder_data.csv")

# user interface
ui2 <- fluidPage(
  
  # application title
  titlePanel("Gapminder Histogram"),
  
  sidebarLayout(
    sidebarPanel(
      
      # input for year
      sliderInput(inputId = "year",
                  label = "Year:",
                  min = 1800,
                  max = 2020,
                  value = 1800),
      
      # input for number of bins
      sliderInput(inputId = "bins",
                  label = "Number of Bins:",
                  min = 1,
                  max = 50,
                  value = 25),
      
      # input for selecting variable
      varSelectInput(inputId = "variable", 
                     label = "Select Variable to Display", 
                     data = gpmdata %>% dplyr::select(lifeExp, pop, gdpPercap))
    ),
    
    # show plot
    mainPanel(
      plotOutput("distPlot")
    )
  )
)


# server logic
server2 <- function(input, output) {
  
  output$distPlot <- renderPlot({
    
    # create plot 
    ggplot(data = gpmdata %>% filter(year == input$year)) + 
      geom_histogram(aes(x = !!input$variable), bins = input$bins, color="white", fill="blue")  + ylab("Frequency")
  })
}


# run the application 
shinyApp(ui = ui2, server = server2)
