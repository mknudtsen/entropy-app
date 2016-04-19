library(shiny)
library(entropy)

shinyUI(fluidPage(
  # include JavaScript file to build and edit HTML table
  # include custom CSS to style HTML table and cells
  tags$head(
    # HTML("<script type='text/javascript' src='jshtml.js'></script>"),
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
  ),
  

  # Application title
  fluidRow(
    column(8, offset = 2,
      tags$h2("Shannon's Entropy Experiment", align = "center")
    )
  ),
  br(),
  
  
  fluidRow(
    column(8, offset = 2,
      
    fluidRow(
      column(6,
        actionButton("quote", "Generate New Quote")
      ),
      column(6,
        actionButton("entropy", "Calculate Entropy")
      )
    ),
    br(),
    fluidRow(
      column(12,
        tags$h4(textOutput("available"), align = "center"),
        tags$div(id = "flash"),
        tags$table(id = "container")
      )
    )
  )
  ),
  
  # send keypress event to Shiny server for processing
  tags$script('
    $(document).on("keypress", function(e) {
      e.preventDefault();
      var code = e.keyCode;
      var stamp = e.timeStamp;
      Shiny.onInputChange("mydata", [code, stamp]);
    });
  '),

  HTML("<script type='text/javascript' src='jshtml.js'></script>")  
)
)
