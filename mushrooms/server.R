library(shiny)
library(leaflet)
library(data.table)
library(caret)
library(randomForest)

shinyServer(function(input, output) {

  model <- readRDS("./model.rds")  
  
  cap_shape_lookup = data.frame(
    key  = c("Bell","Conical","Convex","Flat","Knobbed","Sunken"),
    value = c("b","c","x","f","k","s")
  )
  
  cap_color_lookup = data.frame(
    key  = c("Brown","Buff","Cinnamon","Gray","Green","Pink","Purple","Red","White","Yellow"),
    value = c("n","b","c","g","r","p","u","e","w","y")
  )

  gill_color_lookup = data.frame(
    key  = c("Black","Brown","Buff","Chocolate","Gray","Green","Orange","Pink","Purple","Red","White","Yellow"),
    value = c("k","n","b","h","g","r","o","p","u","r","w","y")
  )
  
  stalk_shape_lookup = data.frame(
    key  = c("Enlarged","Tapering"),
    value = c("e","t")
  )
  
  stalk_root_lookup = data.frame(
    key  = c("Bulbous","Club","Cup","Equal","Rhizomorphs","Rooted","Missing"),
    value = c("b","c","?","e","?","r","?")
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
    
    cap_shape = as.character(cap_shape_lookup[cap_shape_lookup$key == input$cap_shape,]$value)
    cap_color = as.character(cap_color_lookup[cap_color_lookup$key == input$cap_color,]$value)
    gill_color = as.character(gill_color_lookup[gill_color_lookup$key == input$gill_color,]$value)
    stalk_shape = as.character(stalk_shape_lookup[stalk_shape_lookup$key == input$stalk_shape,]$value)
    stalk_root = as.character(stalk_root_lookup[stalk_root_lookup$key == input$stalk_root,]$value)
    population = as.character(population_lookup[population_lookup$key == input$population,]$value)
    habitat = as.character(habitat_lookup[habitat_lookup$key == input$habitat,]$value)
    
    d <- data.frame(
      cap_shape = cap_shape,
      cap_color = cap_color,
      gill_color = gill_color,
      stalk_shape = stalk_shape,
      stalk_root = stalk_root,
      population = population,
      habitat = habitat
    );
    prediction = predict(model,d)
    
    signature <- paste0(cap_shape,cap_color,gill_color,stalk_shape,stalk_root,population,habitat,prediction)
    if(prediction == "p") {
      return("<div class='prediction poisonous'>Poisonous</div>")
    } else {
      return("<div class='prediction edible'>Edible</div>")
    }
  })
  
  output$model <- renderPlot({
    plot(model)
  })
  
})
