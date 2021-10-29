shinyUI(
fluidPage(
  useShinyjs(),
  style="padding:0",
  navbarPage(
    "BoxPlot & ViolinPlot",
    tabPanel(span(class='glyphicon glyphicon-home'," Home"),source("tabs/Home.R",local=T)$value),
    tabPanel(span(class='glyphicon glyphicon-play'," Run"),uiOutput("panel")),
    tabPanel(span(class='glyphicon glyphicon-tags'," Help"),source("tabs/Help.R",local=T)$value),
    collapsible=T
  )
))