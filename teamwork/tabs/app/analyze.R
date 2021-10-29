analyze<-function(data,x,y,z){
	if(shapiro.test(data[,y])[2]>0.05){
		method="Anova"
		aov1=aov(data[,y]~data[,x]+data[,z])
		pvalue=anova(aov1)$Pr
	}
	else{
		method="Kruskal-Wallis Htest"
		pvalue1<-kruskal.test(data[,y]~data[,x])[3]
		pvalue2<-kruskal.test(data[,y]~data[,z])[3]
		pvalue<-c(pvalue1,pvalue2)
	}
	return(list(pvalue,method))
}