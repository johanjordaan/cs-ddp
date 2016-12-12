library(shiny)
library(leaflet)

shinyUI(fluidPage(theme = "theme.css",
  
  titlePanel("Is this mushroom poisonous?"),
  
  sidebarLayout(
    sidebarPanel(
       selectInput("spore_print_color","Spore Print Color",c("Black","Brown","Chocolate","Green","Orange","Purple","White","Yellow")),
       selectInput("gill_color","Gill Color",c("Black","Brown","Buff","Chocolate","Gray","Green","Orange","Pink","Purple","Red","White","Yellow")),
       selectInput("gill_size","Gill Size",c("Broad","Narrow")),
       selectInput("stalk_root","Stalk Root",c("Bulbous","Club","Cup","Equal","Rhizomorphs","Rooted","Missing")),
       selectInput("population","Populationt",c("Abundant","Clustered","Numerous","Scattered","Several","Solitary")),
       selectInput("habitat","Habitat",c("Grasses","Leaves","Meadows","Paths","Urban","Waste","Woods"))
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Prediction", 
                 htmlOutput("prediction"),  
                 helpText(class="warning",
                          "*** Note: This prediction does not constiture advice on wheter you should eat mushroom or not. It is done as part of an assignment and is for illustrative purposes ONLY. ***")
        ),
        tabPanel("Model Paremeters", plotOutput("model")),
        tabPanel("Help", includeHTML("./help.html"))
      )
    )
  )
))
