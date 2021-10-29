file<-function(data){
	flag=1
	if(sum(is.na(data))>=1) {
		flag=2}
	else if(sum(is.null(data))>=1){
		flag=3}
	else if(data=="no file"){
		flag=4
	}
	return(flag)
}