#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#Load Libraries
library(ggplot2)
library(dplyr)
library(tidyr)
library(stringr)
library(shiny)

##Import & Mutate Data##
df <- read.csv("C:/Users/BD029575/Documents/School/DATA824/supermarket_sales.csv")
attach(df)

##Main df for Dist/Stack/Box
df <- df %>% 
    mutate(Branch = as.factor(Branch),
           City = as.factor(City),
           Customer.type = as.factor(Customer.type),
           Gender= as.factor(Gender),
           Product.line = as.factor(Product.line),
           Payment = as.factor(Payment),
           Date = as.Date(Date, format = "%m/%d/%y"))

df$weeks <- cut(df[,"Date"], breaks="week")


# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- df[, 10]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
       # hist(x, breaks = bins, col = 'darkgray', border = 'white')
       
       dfDist <- df %>%
           filter(Product.line %in% input$prod,
                  City %in% input$city,
                  Gender %in% input$gender,
                  Payment %in% input$pay)%>%
           ggplot(aes(x=Total,fill = Gender,color = Gender)) + 
           ggtitle("Total Purchase Frequency by Gender") +
           geom_histogram(alpha = 0.5, breaks = bins)
       
       dfDist

    })

    output$stackPlot <- renderPlot({
        
        # generate bins based on input$bins from ui.R
       # x    <- df[, 10]
        #bins <- seq(min(x), max(x), length.out = input$bins + 1)
        
        df %>%
            filter(Product.line %in% input$prod,
                   City %in% input$city,
                   Gender %in% input$gender,
                   Payment %in% input$pay)%>%
            ggplot(aes(fill=Product.line, y=Total, x=weeks)) + 
            ggtitle("Total Purchase by Product Type") +
            geom_bar(position="stack", stat="identity")
        
    })
    
    output$boxPlot <- renderPlot({
        
        df %>%
            filter(Product.line %in% input$prod,
                   City %in% input$city,
                   Gender %in% input$gender,
                   Payment %in% input$pay)%>%
            ggplot(aes(x = City , y = Total )) +
            geom_boxplot(outlier.colour = "red",
                         color = "lightblue",
                         fill = "seagreen")+
            coord_flip()+
            ylab("Total") +
            xlab("")+
            ggtitle("Total By City") +
            theme(axis.text = element_text(size = 14),
                  axis.title = element_text(size = 16),
                  plot.title = element_text(size = 20, face = "bold"))
        
    })
    
    output$piePlot <- renderPlot({
       
        #Secondary DF for Pie Chart
        df2 <- df %>% 
            filter(Product.line %in% input$prod,
                   City %in% input$city,
                   Gender %in% input$gender,
                   Payment %in% input$pay)%>%
            group_by(Payment) %>% 
            count() %>% 
            ungroup() %>% 
            mutate(per=`n`/sum(`n`)) %>% 
            arrange(desc(Payment))
        df2$label <- scales::percent(df2$per)
        
         
        ggplot(data=df2)+
            geom_bar(aes(x="", y=per, fill=Payment), stat="identity", width = 1)+
            coord_polar("y", start=0)+
            theme_void()+
            ggtitle("Purchase by Payment Type") +
            geom_text(aes(x=1, y = cumsum(per) - per/2, label=label))
        
    })

})
