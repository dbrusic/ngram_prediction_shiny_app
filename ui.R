library(shiny)
library(shinythemes)
library(data.table)

shinyUI(fluidPage(theme = shinytheme("darkly"),
        br(),
        br(),
        br(),
        br(),
        fluidRow(
                column(8, align = 'center', offset = 2,
                       textInput(inputId="text1", label = "", width = '90%')
                )
        ),
        fluidRow(
                column(2, align = 'center', offset = 3,
                       actionButton("button1", "", width = "100%",
                                    style = "background-color:mediumseagreen")
                ),
                column(2, align = 'center', offset = 0,
                       actionButton("button2", "", width = "100%",
                                    style = "background-color:mediumseagreen")
                ),
                column(2, align = 'center', offset = 0,
                       actionButton("button3", "", width = "100%",
                                    style = "background-color:mediumseagreen")
                )
        ),
        br(),
        br(),
        br(),
        fluidRow(
                column(8, align = 'center', offset = 2,
                       p(
                               "Type a phrase in the text box above and three next word predictions will be provided in the buttons 
                               below it. Pressing one of the buttons will insert the word at the end of your phrase. The algorithm 
                               that predicts the next word only uses, at most, the previous four words that have been typed."
                       ),
                       p(
                               "More specifically, this application uses an n-gram language model that has been trained on sentences 
                               from a news source, blogs source, and twitter source. Frequencies of five-grams, four-grams, tri-grams, 
                               and bi-grams were used to estimate probabilities for individual n-grams (as maximum likelihood estimates). 
                               These probability estimates are then used to select the most probable words to complete the input text. "
                       ),
                       p(
                               "More information on how this application works can be found in this RStudio Presentation: ",
                               a("Presentation", href="http://rpubs.com/dbrusic/ngram_prediction_presentation")
                       ),
                       p(
                               "The code for the full project can be found at this GitHub Repo: ", 
                               a("GitHub Repo", href="https://github.com/dbrusic/ngram_prediction_project")
                       ))
        )
))


