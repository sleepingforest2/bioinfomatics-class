run_twoway<-function(sourcepath){
	#输入文件夹路径
	if (!requireNamespace("shiny", quietly = TRUE)) install.packages("shiny")
	library(shiny)
	runApp(sourcepath)
}

