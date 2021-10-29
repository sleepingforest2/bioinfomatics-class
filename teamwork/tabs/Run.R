tags$div(
  sidebarPanel(
    #paste file
    textAreaInput("raw1", "Paste your file :"),
    actionButton("file1","Submit"),
    #file input
    fileInput("raw2","UPLOAD DATA",accept=c('csv','txt')),
    actionButton("file2","File Upload"),
    radioButtons("head","Choose the first row as header:",c("Yes" = "T","No"= "F")),
    textInput("sep", "Separate:"),
    actionButton("plot","Start Plot"),
    actionButton("reload","Reload")
  ),
  mainPanel(
      tableOutput("example"),
      tableOutput("example2"),
      verbatimTextOutput('warn')
    )
)
