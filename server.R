#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
    cyltypes = c("4", "6", "8")
    for(i in cyltypes) {
        assign(paste0("cyl",i,"_subset"), subset(mtcars, cyl == i))
        
        assign(paste0("model",i), lm(hp ~ mpg + disp + wt, data = get(paste0("cyl",i,"_subset"))))
    }
    
    
    model4pred = reactive ({
        mpgInput = input$sliderMPG #Re-labeling
        dispInput = input$sliderdisp
        wtInput = input$sliderwt
        predict(model4, newdata = data.frame(mpg = mpgInput, disp = dispInput, wt = wtInput, cyl = 4))
    })
    
    model6pred = reactive ({
        mpgInput = input$sliderMPG
        dispInput = input$sliderdisp
        wtInput = input$sliderwt
        predict(model6, newdata = data.frame(mpg = mpgInput, disp = dispInput, wt = wtInput, cyl = 6))
    })
    
    model8pred = reactive ({
        mpgInput = input$sliderMPG
        dispInput = input$sliderdisp
        wtInput = input$sliderwt
        predict(model8, newdata = data.frame(mpg = mpgInput, disp = dispInput, wt = wtInput, cyl = 8))
    })
  
  output$plot1 = renderPlot ({
      mpgInput = input$sliderMPG
      dispInput = input$sliderdisp
      wtInput = input$sliderwt
      
      plot(mtcars$mpg, mtcars$hp, xlab = "Miles Per Gallon (MPG)", 
           ylab = "Horsepower (HP)", bty = "n", pch = 16, 
           xlim = c(10, 35), ylim = c(50, 350))
      
      if(input$showModel4) {
          model4lines = predict(model4, newdata = data.frame(
              mpg = 10:35, disp = dispInput, wt = wtInput))
          lines(10:35, model4lines, col = "red", lwd = 2)
      }
      
      if(input$showModel6) {
          model6lines = predict(model6, newdata = data.frame(
              mpg = 10:35, disp = dispInput, wt = wtInput))
          lines(10:35, model6lines, col = "blue", lwd = 2)
      }
      
      
      if(input$showModel8) {
          model8lines = predict(model8, newdata = data.frame(
              mpg = 10:35, disp = dispInput, wt = wtInput))
          lines(10:35, model8lines, col = "green", lwd = 2)
      }
      
      
      legend(25, 250, c("Prediction for 4-Cylinder Vehicles", "Prediction for 6-Cylinder Vehicles", 
                        "Prediction for 8-Cylinder Vehicles"), pch = 16, 
                        col = c("red", "blue", "green"), bty = "n", cex = 1.2)
             points(mpgInput, model4pred(), col = "red", pch = 16, cex = 2)
             points(mpgInput, model6pred(), col = "blue", pch = 16, cex = 2)
             points(mpgInput, model8pred(), col = "green", pch = 16, cex = 2)
  })
  
  output$pred4 = renderText ({
      model4pred()
  })
  
  output$pred6 = renderText ({
      model6pred()
  })
  
  output$pred8 = renderText ({
      model8pred()
  })

})
