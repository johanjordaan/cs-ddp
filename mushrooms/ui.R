library(shiny)
library(leaflet)

shinyUI(fluidPage(theme = "theme.css",
  
  titlePanel("Is this mushroom poisonous?"),
  
  sidebarLayout(
    sidebarPanel(
       #spore-print-color:black=k,brown=n,buff=b,chocolate=h,green=r,orange=o,purple=u,white=w,yellow=y
       selectInput("spore_print_color","Spore Print Color",c("Black","Brown","Chocolate","Green","Orange","Purple","White","Yellow")),

       #gill-color       : black=k,brown=n,buff=b,chocolate=h,gray=g, green=r,orange=o,pink=p,purple=u,red=e,white=w,yellow=y
       selectInput("gill_color","Gill Color",c("Black","Brown","Buff","Chocolate","Gray","Green","Orange","Pink","Purple","Red","White","Yellow")),
       
       #gill-size: broad=b,narrow=n
       selectInput("gill_size","Gill Size",c("Broad","Narrow")),
       
       #stalk-root: bulbous=b,club=c,cup=u,equal=e,rhizomorphs=z,rooted=r,missing=?
       selectInput("stalk_root","Stalk Root",c("Bulbous","Club","Cup","Equal","Rhizomorphs","Rooted","Missing")),
       
       #population: abundant=a,clustered=c,numerous=n,scattered=s,several=v,solitary=y
       selectInput("population","Populationt",c("Abundant","Clustered","Numerous","Scattered","Several","Solitary")),
      
       #habitat: grasses=g,leaves=l,meadows=m,paths=p,urban=u,waste=w,woods=d
       selectInput("habitat","Habitat",c("Grasses","Leaves","Meadows","Paths","Urban","Waste","Woods"))
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Prediction", 
                 htmlOutput("prediction"),  
                 helpText(class="warning",
                          "*** Note: This prediction does not constiture advice on wheter you should eat mushroom or not. It is done as part of an assignment and is for illustrative purposes ONLY. ***")
        ),
        tabPanel("Model Paremeters", htmlOutput("Model")),
        tabPanel("Help", includeHTML("./help.html"))
      )
    )
  )
))
