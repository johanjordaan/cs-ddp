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
      return("Poisonous")
    } else {
      return("Edible")
    }
  }) 
  
  output$map <- renderLeaflet({
    myMap <- leaflet() %>% addTiles()
    myMap
  })
    
})
