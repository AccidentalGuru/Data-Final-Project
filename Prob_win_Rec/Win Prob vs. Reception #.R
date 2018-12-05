#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(tidyverse)
library(dplyr)
library(readr)
library(janitor)
library(fs)
library(knitr)
library(formattable)
library(lubridate)
library(date)
library(foreign)
library(kableExtra)
library(scales)
library(shiny)


Jules <- read_csv("Untitled/game_player_stats/game_receiving_df.csv") %>%
  filter(Team == "NE") %>%
  filter(Player_Name == "J.Edelman") %>%
  mutate(Season = str_sub(GameID, 1, 4))


# Define UI for application that draws a histogram
ui <- fluidPage(
  
  
  
  # Application title
  titlePanel("Julian Edelman's Performance based on likelihood of a Patriots Win"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("Season",
                  
                  
                  
                  "Select Season",
                  choices = c("2009", "2010", "2012", "2013", "2014", "2015", "2016"
                  ))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    
    
    
    Jules %>%
      filter(Season == input$Season) %>%
      ggplot(aes(x = Win_Success_Rate, y = Receptions, color = Opponent)) + 
      geom_point() +
      xlab("Win Probability Before the Game") +
      ylab("Receptions") +
      ggtitle("The Number of Catches Julian Edelman's had depending on the Win Probability for the Patriots")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
