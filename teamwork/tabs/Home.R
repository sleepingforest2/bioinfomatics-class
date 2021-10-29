tags$div(
    fluidRow(column(12,div(
    class='jumbotron',display='grid',
    style='background-color:#9DC3E6;color:#FFF',
    h1('Plot- ',tags$small('two way analysis',style='color:#FFF;text-align:left;margin-top:-15px;font-weight:normal;font-size:40px'),
       style='color:#FFF;text-align:left;margin-top:-15px;font-weight:bold;font-size:80px'
	   )
  ))),
    fluidRow(
	 column(12,tags$hr(),style="margin-top:-20px")
	),

    fluidRow(
	   column(6,div(
                    img(src='boxplot.png',width=500),
					style="margin-top:-5px"
               )),
	   column(6,div(
                   img(src='violinplot.png',width=500),  
				   style='margin-top:-5px'
        ))
	)

)