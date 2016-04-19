library(shiny)
library(entropy)
source("helpers.R")


shinyServer(function(input, output, session) {
  
  active <- reactive({
    invalidateLater(100)
    sapply(v$active, alt_get_letter)
  }) 
   
  output$available <- renderText({
    active()
  })

  v <- reactiveValues(txt = get_quote(1), cnt = 0, idx = 1, active = c(97:122, 32), current_match = character(),
                      sentence_out = character(), counts_out = numeric(), entropy = NULL)
 
  update_all <- reactive({
    key_press <- input$mydata[1]
    valid_keys <- v$active
    current_letter <- get_code(v$txt[v$idx])
    
    if(key_press %in% valid_keys && v$idx <= length(v$txt) + 1) {
      v$cnt <- v$cnt + 1 # increment counter on valid key_press
      if(key_press == current_letter) {
        v$sentence_out[v$idx] <- get_letter(key_press) # populate correct guess in sentence_out
        v$current_match <- get_letter(key_press) # populate curren_match letter
        v$counts_out[v$idx] <- v$cnt # populate total count in counts_out
        v$idx <- v$idx + 1 # increment sentence index
        v$cnt <- 0 # return guess counter to 0
        v$active <- c(97:122, 32)
      } else {
        v$active <- v$active[which(v$active != key_press)] # remove element from active
      }
      if(v$idx == (length(v$txt) + 1)) {
        v$entropy = TRUE
      }
    } else {
      return(NULL)
    }
  })
  
  observeEvent(input$mydata, {
    update_all()
  })

  observeEvent(v$txt, {
    # txt <<- get_quote()
    len <- length(v$txt)
    session$sendCustomMessage(type = "buildTable", len)
    v$cnt <- 0
    v$idx <- 1
    v$active <- c(97:122, 32)
    v$current_match <- character()
    v$sentence_out <- character(length(v$txt))
    v$counts_out <- numeric(length(v$txt))
    v$entropy <- NULL
    message <- list(idx = v$idx, cnt = v$cnt)
    session$sendCustomMessage(type = "editCount", message)
  })
  
  observeEvent(input$quote, {
    # create loop to continue to next quote
    rnum <- sample(1:10, 1)
    v$txt <- get_quote(rnum)
  })
  
  observeEvent(v$cnt, {
    message <- list(idx = v$idx, cnt = v$cnt, len = length(v$txt))
    session$sendCustomMessage(type = "editCount", message)
  })
  
  observeEvent(v$sentence_out, {
    message <- list(letter = v$current_match, idx = v$idx)
    session$sendCustomMessage(type = "editTable", message)
  })
  
  observeEvent(v$idx, {
    message <- list(idx = v$idx, cnts = v$counts_out)
    session$sendCustomMessage(type = "fixCount", message)
  })
  
  observeEvent(v$idx, {
    if(v$idx > 1) {
      message <- list(color = "0, 153, 37")
      session$sendCustomMessage(type = "flash", message)
    }
  })
  
  observeEvent(v$active, {
    if(length(v$active) != 27) {
      message <- list(color = "213, 15, 37")
      session$sendCustomMessage(type = "flash", message)
    }
  })
  
  calc_entropy <- reactive({
    counts <- v$counts_out
    freqs <- table(counts)/length(counts)
    ent_vec <- as.data.frame(freqs)[,2]
    ent_val <- -sum(ent_vec * log2(ent_vec))
  })
  
  observeEvent(input$entropy, {
    entropy <- calc_entropy()
    message <- list(ent = entropy)
    session$sendCustomMessage(type = "showEntropy", message)
  })
  
  observeEvent(v$entropy, {
    entropy <- calc_entropy()
    message <- list(ent = entropy)
    session$sendCustomMessage(type = "showEntropy", message)
  })

})
