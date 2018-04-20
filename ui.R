
fluidPage(
  # Copy the line below to make a date range selector
  dateRangeInput("dates", label = h3("Date range")),
  mainPanel(uiOutput('table')),
  hr(),
  # fluidRow(column(4, verbatimTextOutput("final"))),
  fluidRow(column(5, renderDataTable("final"))),
  actionButton("goButton", "Go!"),
  downloadButton("downloadData", "Download")
)

