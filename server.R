library(shiny)
library(shinythemes)
library(data.table)

shinyServer(
        function(input, output, session) {
                
                suggest <- reactive({
                        words <- gsub("[^[:alnum:][:space:]'-]", "", input$text1, perl = TRUE)
                        words <- gsub("\\s+", " ", words, perl = TRUE)
                        words <- gsub("^\\s+|\\s+$", "", words, perl = TRUE)
                        words <- tolower(words)
                        words <- unlist(strsplit(words, " "))
                        lw <- length(words)
                        if(lw == 0) {
                                # top three unigrams in order
                                p <- c("the", "to", "and")
                                return(p)
                        } else {
                                if(lw < 4) {
                                        s <- lw - 1 
                                } else {
                                        s <- 3
                                }
                        }
                        p <- list()
                        cnt <- 0
                        for(i in s:0) {
                                cnt <- cnt + 1
                                ngram <- paste(words[(lw-i):lw], collapse = " ")
                                p[[cnt]] <- query_table[ngram, pred]
                                if(sum(!is.na(unique(unlist(p)))) >= 3) {
                                        break
                                }
                        }
                        p <- unlist(p)
                        # add top three unigrams to end 
                        # if at least three words have already been found,
                        # these unigram predictions will get cut off
                        p <- c(p, "the", "to", "and")
                        p <- p[!is.na(p)]
                        p <- unique(p)
                        return(p[1:3])
                })
                
                observe({
                        updateActionButton(session, "button1",
                                           label = suggest()[1])
                        updateActionButton(session, "button2",
                                           label = suggest()[2])
                        updateActionButton(session, "button3",
                                           label = suggest()[3])
                })
                
                
                
                observeEvent(input$button1, {
                        updateTextInput(session, "text1", 
                                        value = paste(gsub("\\s*$", "", input$text1), suggest()[1]))
                })
                
                observeEvent(input$button2, {
                        updateTextInput(session, "text1", 
                                        value = paste(gsub("\\s*$", "", input$text1), suggest()[2]))
                })
                
                observeEvent(input$button3, {
                        updateTextInput(session, "text1", 
                                        value = paste(gsub("\\s*$", "", input$text1), suggest()[3]))
                })
                
                
                
        }
)