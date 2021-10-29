#检查文件并给出反馈
source('tabs/app/file.R')
#对数据文件总结
source('tabs/app/summary.R')
#对数据进行计算pvalue
source('tabs/app/analyze.R')

shinyServer(function(input, output,session) {
	output$panel <- renderUI({source('tabs/Run.R',local=T)$value})
	data.pool <- reactiveValues(raw1=NA,raw2=NA)
	observe({
		data.pool$head="T"
    	data.pool$sep='\t'
    	data.pool$rawData<-"no file"
		if(isTruthy(!is.null(input$raw1) || !is.null(input$raw2))){
         	if(isTruthy(!is.null(input$head))){data.pool$head<-input$head}
         	if(isTruthy(!is.null(input$sep))){data.pool$sep<-input$sep}
         	observeEvent(input$file1, {
         		temp<-input$raw1
         		temp<-unlist(strsplit(temp,'\n'))
         		tmp<-unlist(strsplit(temp[1],'\t'))
         		if(length(tmp)==1){
         			tmp<-unlist(strsplit(temp[1],' '))
         			for(i in 2:length(temp)){
         			tmp<-rbind(tmp,unlist(strsplit(temp[i],' ')))
         			}
         		}else{
         			for(i in 2:length(temp)){
         			tmp<-rbind(tmp,unlist(strsplit(temp[i],'\t')))
         			}
         		}
         		colnames(tmp)<-tmp[1,]
         		tmp<-tmp[-1,]
         		data.pool$rawData<-tmp
         		output$example2<-renderTable(head(data.pool$rawData))
         	})
         	observeEvent(input$file2, {
         		if(data.pool$head=="T"){data.pool$rawData <- read.table(input$raw2$datapath,header=T,sep=data.pool$sep,check.names=F)}
         		if(data.pool$head=="F"){data.pool$rawData <- read.table(input$raw2$datapath,header=F,sep=data.pool$sep,check.names=F)}
				output$example<-renderTable(head(data.pool$rawData))
			})
		}
			observeEvent(input$reload,{
					refresh()
				})
         	observeEvent(input$plot,{
         		data.pool$check=file(data.pool$rawData)
				if( data.pool$check==3){
					output$warn<-renderPrint(
						print("Warning: The input include null value, you can impute your data and Click Reload")
					)}
				if( data.pool$check==2){
					output$warn<-renderPrint(
						print("Warning: The input include NA, remove NA value in your data and Click Reload")
					)}
         		if( data.pool$check==1){
					output$panel <- renderUI({
						source('tabs/Run2.R',local=T)$value})}
				if(data.pool$check==4){
					output$warn<-renderPrint(
						print("Warning: Please input file, Click Reload"))
				}
				updateSelectInput(session,'x',choices=c(colnames(data.pool$rawData)))
     			updateSelectInput(session,'y',choices=c(colnames(data.pool$rawData)))
     			updateSelectInput(session,'z',choices=c(colnames(data.pool$rawData)))
     		   	observeEvent(input$sub,{
     		   		data.pool$color1<-c()
     				data.pool$color2<-c()
     				data.pool$x<-which(colnames(data.pool$rawData)==input$x)
     				data.pool$y<-which(colnames(data.pool$rawData)==input$y)
     				data.pool$z<-which(colnames(data.pool$rawData)==input$z)
     				data.pool$rawData[,data.pool$x]<-as.factor(data.pool$rawData[,data.pool$x])
     				data.pool$rawData[,data.pool$z]<-as.factor(data.pool$rawData[,data.pool$z])
     				data.pool$num<-length(levels(as.factor(data.pool$rawData[,data.pool$z])))
     				updateSelectInput(session,'boxorder',choices=c(1:data.pool$num))
     				updateSelectInput(session,'vioorder',choices=c(1:data.pool$num))
     				data.pool$color1<-sample(colors(),data.pool$num)
     				data.pool$color2<-sample(colors(),data.pool$num)
     				output$summary1<-renderTable({	
								summary2(data.pool$rawData,data.pool$x,data.pool$y)
     						})
     				output$summary2<-renderTable({	
								summary2(data.pool$rawData,data.pool$z,data.pool$y)
     						})
     				data.pool$result<-analyze(data.pool$rawData,data.pool$x,data.pool$y,data.pool$z)
     				output$analyze<-renderPrint({
     						print(paste0("method : ",data.pool$result[[2]],"  P-value  for ",input$x,": ",data.pool$result[[1]][1],"  P-value  for ",input$z,": ",data.pool$result[[1]][2]))
     					})

     			})
     			observeEvent(input$subbox,{
     						data.pool$box_xlab<-input$box_xlab
     						data.pool$box_ylab<-input$box_ylab
						 	data.pool$box_zlab<-input$box_zlab
     						data.pool$size<-input$size
     						#print(data.pool$color1[as.numeric(input$boxorder)])
     						data.pool$color1[as.numeric(input$boxorder)]<-input$box_c
     						data.pool$p1<-ggplot(data.pool$rawData,aes(data.pool$rawData[,data.pool$x],data.pool$rawData[,data.pool$y],colour=data.pool$rawData[,data.pool$z]))+
     						geom_boxplot()+geom_jitter(size=data.pool$size)+scale_x_discrete(data.pool$box_xlab)+scale_y_discrete(data.pool$box_ylab)+
     						scale_colour_discrete(data.pool$box_zlab)+scale_color_manual(values=data.pool$color1,name=data.pool$box_zlab)
     						output$box<-renderPlot({
     							data.pool$p1
     						})
     						
     			})
     			observeEvent(input$subvio,{
     					data.pool$width<-input$width
     					data.pool$vio_xlab<-input$vio_xlab
     					data.pool$vio_ylab<-input$vio_ylab
     					data.pool$vio_zlab<-input$vio_zlab
     					data.pool$color2[as.numeric(input$vioorder)]<-input$vio_c
     					data.pool$p2<-ggplot(data.pool$rawData,aes(data.pool$rawData[,data.pool$x],data.pool$rawData[,data.pool$y],colour=data.pool$rawData[,data.pool$z]))+
     					geom_violin(position=position_dodge(width=0.8),scale='area',width=data.pool$width)+geom_boxplot(position=position_dodge(width=0.8),show.legend=FALSE,width=0.1)+ geom_jitter(height = 0, width = 0.1)+
     					scale_x_discrete(data.pool$vio_xlab)+scale_y_discrete(data.pool$vio_ylab)+scale_colour_discrete(data.pool$vio_zlab)+scale_color_manual(values=data.pool$color2,name=data.pool$vio_zlab)
     					output$violin<-renderPlot({
     							data.pool$p2
     					})
     					
     				})
     			output$downloadbox <- downloadHandler(
      				filename = paste("boxplot-",".png",sep=""),
      				content = function(file) {
        			 ggsave(file,plot=data.pool$p1)
      			}) 
      			output$downloadvio <- downloadHandler(
      				filename = paste("violinplot-",".png",sep=""),
      				content = function(file) {
        			 ggsave(file,plot=data.pool$p2)
      			}) 
			})
	})
})