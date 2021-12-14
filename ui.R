#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(shinyWidgets)

# Define UI for application that draws a histogram
shinyUI(dashboardPage(

    # Application title
    dashboardHeader(title = "Store Sales Data"),

    # Sidebar with a slider input for number of bins
    dashboardSidebar(
            pickerInput("prod", 
                        label = "Choose a Product Line",
                        choices = c("Health and beauty",
                                    "Electronic accessories",
                                    "Home and lifestyle",
                                    "Sports and travel",
                                    "Food and beverages",
                                    "Fashion accessories"),
                        selected = c("Health and beauty",
                                     "Electronic accessories",
                                     "Home and lifestyle",
                                     "Sports and travel",
                                     "Food and beverages",
                                     "Fashion accessories"),
                        options = list(`actions-box` = TRUE),
                        multiple = T),
            pickerInput("city", 
                        label = "Choose a City",
                        choices = c("Yangon","Naypyitaw","Mandalay"),
                        selected = c("Yangon","Naypyitaw","Mandalay"),
                        options = list(`actions-box` = TRUE),
                        multiple = T),
            pickerInput("pay", 
                        label = "Choose a Payment Type",
                        choices = c("Ewallet","Cash","Credit card"),
                        selected = c("Ewallet","Cash","Credit card"),
                        options = list(`actions-box` = TRUE),
                        multiple = T),
            pickerInput("gender", 
                        label = "Choose a Gender",
                        choices = c("Male","Female"),
                        selected = c("Male","Female"),
                        options = list(`actions-box` = TRUE),
                        multiple = T),
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        
                    ),
       
        # Show a plot of the generated distribution
        dashboardBody(
            wellPanel(fluidRow(
                column(6,
                       plotOutput("distPlot")
                       ),
                column(6,
                       plotOutput("stackPlot")
                       ))),
            wellPanel(fluidRow(
                column(6,
                       plotOutput("boxPlot")
                       ),
                column(6,
                       plotOutput("piePlot")
                       )
        )))
        
    )
    
)
