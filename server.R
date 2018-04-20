require(httr)
require(shiny)
options(shiny.fullstacktrace = TRUE)
function(input, output) {
  # makeReactiveBinding("new_df")
  # You can access the values of the widget (as a vector of Dates)
  # with input$dates, e.g.
  final <- reactive({
    xy = c(input$dates)
    if (!is.null(xy)) {
      payload = paste0("{\"query\":
                       {\"app_id\":\"ru.zero.dobriy_book\",
                       \"start_date\":\"", input$dates[1],"\",
                       \"end_date\":\"", input$dates[2],"\",
                       \"alt_timezone\":false,
                       \"alt_currency\":false,
                       \"tz_switch_date\":\"\",
                       \"topics\":[\"installs\",
                       \"clicks\",
                       \"impressions\",
                       \"fb_clicks\",
                       \"fb_impressions\"],
                       \"groupings\":[\"media_source\"],
                       \"ms_timeout\":54000,
                       \"sort_by\":[[\"installs\",\"desc\"],[\"clicks\",
                       \"desc\"],[\"impressions\",\"desc\"]],\"limit\":2000}}")
      
      
      req=POST("https://hq1.appsflyer.com/connectivity/vishnu/getAgg/id1136165372",
               body=payload ,add_headers("accept"= "application/json",
                                         "origin"= "https://hq1.appsflyer.com",
                                         "user-agent"= "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36",
                                         "content-type"= "application/json",
                                         "referer"= "https://hq1.appsflyer.com/dashboard/overview/ru.zero.dobriy_book",
                                         "accept-encoding"= "gzip, deflate, br",
                                         "accept-language"= "ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7",
                                         "cookie"= "",
                                         "cache-control"= "no-cache",
                                         "postman-token"= "4fbf18f7-9255-53f5-07c8-25fde786a7e7"),
               user_agent("Mozilla/5.0")) 
      json <- content(req, "text")
      #option 1 for super_uly
      library("jsonlite")
      new_df = fromJSON(json)
      print(new_df)
      return(new_df)
                       }
    })
  
  output$table <- renderTable({ 
    if (input$goButton == 0){
      return()
    }
    isolate(final())
  })
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(final(), ".csv", sep = "")
    },
    content = function(file) {
      write.csv(final(), file, row.names = FALSE)
    }
  )
  
  
}


