library(shiny)
library(leaflet)
library(data.table)
library(caret)

shinyServer(function(input, output) {

  model <- readRDS("./model.rds")  
  
  spore_print_color_lookup = data.frame(
    key  = c("Black","Brown","Buff","Chocolate","Green","Orange","Purple","White","Yellow"),
    value = c("k","n","b","h","r","o","u","w","y")
  )

  gill_color_lookup = data.frame(
    key  = c("Black","Brown","Buff","Chocolate","Gray","Green","Orange","Pink","Purple","Red","White","Yellow"),
    value = c("k","n","b","h","g","r","o","p","u","r","w","y")
  )
  
  gill_size_lookup = data.frame(
    key  = c("Broad","Narrow"),
    value = c("b","n")
  )
  
  stalk_root_lookup = data.frame(
    key  = c("Bulbous","Club","Cup","Equal","Rhizomorphs","Rooted","Missing"),
    value = c("b","c","u","e","z","r","?")
  )

  population_lookup = data.frame(
    key  = c("Abundant","Clustered","Numerous","Scattered","Several","Solitary"),
    value = c("a","c","n","s","v","y")
  )
  
  habitat_lookup = data.frame(
    key  = c("Grasses","Leaves","Meadows","Paths","Urban","Waste","Woods"),
    value = c("g","l","m","p","u","w","d")
  )

  output$prediction <- renderText({
    spore_print_color = spore_print_color_lookup[spore_print_color_lookup$key == input$spore_print_color,]$value
    gill_color = gill_color_lookup[gill_color_lookup$key == input$gill_color,]$value
    gill_size = gill_size_lookup[gill_size_lookup$key == input$gill_size,]$value
    stalk_root = stalk_root_lookup[stalk_root_lookup$key == input$stalk_root,]$value
    population = population_lookup[population_lookup$key == input$population,]$value
    habitat = habitat_lookup[habitat_lookup$key == input$habitat,]$value
    
    d <- data.frame(
      spore_print_color = as.factor(c(spore_print_color,spore_print_color)),
      gill_color = as.factor(c(gill_color,gill_color)),
      gill_size = as.factor(c(gill_size,gill_size)),
      stalk_root = as.factor(c(stalk_root,stalk_root)),
      population = as.factor(c(population,population)),
      habitat = as.factor(c(habitat,habitat))
    );
    
    prediction = predict(model,d)[0];
    
    signature <- paste0(spore_print_color,gill_color,gill_size,stalk_root,population,habitat,prediction)
    if(input$spore_print_color == "Black") {
      return(paste0("<div class='prediction poisonous'>Poisonous</div>",signature))
    } else {
      return(paste0("<div class='prediction edible'>Edible</div>",signature))
    }
  })
  
  output$model <- renderPlot({
    plot(model)
  })
  
})
