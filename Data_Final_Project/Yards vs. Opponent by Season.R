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
  titlePanel("Julian Edelman Total Yards depending on Opponent"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("Opponent",
                  
                  
                  
                  
                  "Select Opposing Team",
                  choices = c("NYJ", "ATL", "BAL", "DEN",	"TEN", "IND", "CAR", "JAC",	"HOU", "BUF", "GB", "MIA",
                              "OAK", "NYG", "ARI", "STL", "TB", "CIN", "NO", "PIT", "CLE", "MIN", "KC", "CHI",
                              "DET", "SD", "DAL", "WAS", "SEA",	"SF", "LA"
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
      filter(Opponent == input$Opponent) %>%
      ggplot(aes(x = Season, y = Total_Yards)) + 
      geom_point() +
      xlab("Season") +
      ylab("Total Yards") +
      ggtitle("Yards based on Season, Grouped by Opponent")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
