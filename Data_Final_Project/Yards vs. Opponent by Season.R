#Load Libraries


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

#Data Manipulation
Jules <- read_csv("Untitled/game_player_stats/game_receiving_df.csv") %>%
  filter(Team == "NE") %>%
  filter(Player_Name == "J.Edelman") %>%
  mutate(Season = str_sub(GameID, 1, 4))


#App UI
ui <- fluidPage(
  
  
  
#App Title
  titlePanel("Julian Edelman Total Yards depending on Opponent"),
  
#Sidebar Layout - picking teams from dropdown menu
  sidebarLayout(
    sidebarPanel(
      selectInput("Opponent",
                  
                  
                  
                  
                  "Select Opposing Team",
                  choices = c("NYJ", "ATL", "BAL", "DEN",	"TEN", "IND", "CAR", "JAC",	"HOU", "BUF", "GB", "MIA",
                              "OAK", "NYG", "ARI", "STL", "TB", "CIN", "NO", "PIT", "CLE", "MIN", "KC", "CHI",
                              "DET", "SD", "DAL", "WAS", "SEA",	"SF", "LA"
                          ))
    ),
    
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

#Interactive Plot
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

#Run the app
shinyApp(ui = ui, server = server)
