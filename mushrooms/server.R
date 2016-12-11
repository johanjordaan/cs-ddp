library(shiny)
library(leaflet)
library(data.table)
library(caret)

shinyServer(function(input, output) {

  model <- readRDS("./model.rds")  
  
  output$model <- renderPlot({
    plot(model)
  })
    
  output$prediction <- renderText({
    input$spore_print_color;
    input$gill_color;
    input$gill_size;
    input$stalk_root;
    input$population;
    input$habitat;
    if(input$spore_print_color == "Black") {
      return("<div class='prediction poisonous'>Poisonous</div>")
    } else {
      return("<div class='prediction edible'>Edible</div>")
    }
  }) 
})
