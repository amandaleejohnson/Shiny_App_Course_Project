# Course project for Developing Data Products Course - 9/22/19
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(datasets)


# Define UI for application that draws a histogram
shinyUI(fluidPage(
    # define the theme used for the app
    theme = shinythemes::shinytheme("slate"),
    # The title
    titlePanel("Predicted Horsepower By Miles Per Gallon, Accounting for Vehicle Characteristics"),
  
  sidebarLayout(
    sidebarPanel(
       sliderInput("sliderMPG", "What is the number of miles per gallon?", 10, 35, value = 20), 
       sliderInput("sliderdisp", "What is the approximate displacement of the car (in cu. in.)?", 70, 500, value = 50), 
       sliderInput("sliderwt", "What is the approximate weight of the car (in 1,000 lbs)?", 1, 6, value = 1), 
       checkboxInput("showModel4", "Show/Hide Model for 4-Cylinder Vehicles", value = TRUE), 
       checkboxInput("showModel6", "show/Hide Model for 6-Cylinder Vehicles", value = TRUE),
       checkboxInput("showModel8", "Show/Hide Model for 8-Cylinder Vehicles", value = TRUE), 
       submitButton("Submit") #Delays reaction until the user presses this button
    ),
    
    mainPanel(
       plotOutput("plot1"), 
       h3("Predicted Horsepower for 4-cylinder vehicles, accounting for miles per gallon, displacement, and weight of vehicle:"), 
       textOutput("pred4"), 
       h3("Predicted Horsepower for 4-cylinder vehicles, accounting for miles per gallon, displacement, and weight of vehicle:"), 
       textOutput("pred6"),
       h3("Predicted Horsepower for 4-cylinder vehicles, accounting for miles per gallon, displacement, and weight of vehicle:"), 
       textOutput("pred8")
    )
  )
))
