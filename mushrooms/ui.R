library(shiny)
library(leaflet)

shinyUI(fluidPage(theme = "theme.css",
  
  titlePanel("Is this mushroom poisonous?"),
  
  sidebarLayout(
    sidebarPanel(
       selectInput("cap_shape","Cap Shape",c("Bell","Conical","Convex","Flat","Knobbed","Sunken")),
       selectInput("cap_color","Cap Color",c("Brown","Buff","Cinnamon","Gray","Green","Pink","Purple","Red","White","Yellow")),
       selectInput("gill_color","Gill Color",c("Black","Brown","Buff","Chocolate","Gray","Green","Orange","Pink","Purple","Red","White","Yellow")),
       selectInput("stalk_shape","Stalk Shape",c("Enlarged","Tapering")),
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
        tabPanel("Model Paremeters", 
                 includeHTML("./about.html"),  
                 plotOutput("model")
        ),
        tabPanel("Help", includeHTML("./help.html"))
      )
    )
  )
))
