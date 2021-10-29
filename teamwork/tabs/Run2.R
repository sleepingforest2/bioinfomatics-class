div(
	sidebarPanel(
		selectInput("x","X Variable :",c('option')),
        selectInput("y","Y Variable :",c('option')),
        selectInput("z","Z Variable :",c('option')),
        actionButton("sub","Submit"),
		selectInput("plotType", "Plot Type",c(BoxPlot = "bplot", ViolinPlot = "vplot")),
		conditionalPanel(
        	condition = "input.plotType == 'bplot'",
        	sliderInput("size", "BoxPlot Point Size:",min = 1, max = 8, value = 1),
        	textInput('box_xlab',"Xlab name:"),
        	textInput('box_ylab',"Ylab name:"),
        	textInput('box_zlab',"Zlab name:"),
        	colourInput("box_c","Select Color:","blue",allowTransparent = TRUE),
        	selectInput("boxorder","Color Order",c(1)),
        	actionButton("subbox","Plot")
        	),
      	conditionalPanel(
          	condition = "input.plotType == 'vplot'",
          	sliderInput("width", "ViolinPlot width", min = 0.1, max = 1, value =0.1,step=0.1 ),
          	textInput('vio_xlab',"Xlab name:"),
        	textInput('vio_ylab',"Ylab name:"),
        	textInput('vio_zlab',"Zlab name:"),
         	colourInput("vio_c","Select Color1:","green",allowTransparent = TRUE),
         	selectInput("vioorder","Color Order",c(1)),
          	actionButton('subvio',"Plot")
          	)
	),
	mainPanel(
	tabsetPanel(
			tabPanel('DataSummary',icon=icon("list-alt"),tableOutput('summary1'),tableOutput('summary2'),verbatimTextOutput('analyze')),
			tabPanel('BoxPlot',icon=icon("smile-wink"),plotOutput('box'),downloadButton("downloadbox", "Download plot")),
			tabPanel('ViolinPlot',icon=icon("smile-wink"),plotOutput('violin'),downloadButton("downloadvio", "Download plot"))
		)
	)
)