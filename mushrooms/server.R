library(shiny)
library(leaflet)
library(data.table)

shinyServer(function(input, output) {

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
