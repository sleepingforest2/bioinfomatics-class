setwd("../Desktop")
#题目一
load("diabets.RData")
#1
dim(diabets[diabets$GLU>=3.9 & diabets$GLU<=6.1 & diabets$Sex=="Female",])[1]
nrow(diabets[diabets$GLU>=3.9 & diabets$GLU<=6.1 & diabets$Sex=="Female",])
#2
count=0
for(i in 1:dim(diabets)[1]){
	temp<-diabets[i,]
	if(temp[1]=="Female" & temp[2]>=3.9 & temp[2]<=6.1){
		count=count+1
	}
}
#3
count=0
i=1
while(i<=dim(diabets)[1]){
	temp<-diabets[i,]
	if(temp[1]=="Female" & temp[2]>=3.9 & temp[2]<=6.1){
		count=count+1
	}
	i<-i+1
}
#4
count<-apply(diabets,1,function(x){count=0;if(x[1]=="Female" & x[2]>=3.9 & x[2]<=6.1){count=count+1};return(count)})
length(count[count>0])
#5
#label可有可无
length(na.omit(cut(diabets[diabets$Sex=="Female",2],c(3.9,6.1),"yes",right=TRUE,include.lowest=TRUE)))
#6
length(tapply(diabets$GLU,diabets$Sex,function(x){x>3.9 & x<6.1})$Female[tapply(diabets$GLU,diabets$Sex,function(x){x>3.9 & x<6.1})$Female])

#题目二
setwd("./GSE67835/")
list.files()[grep('csv',list.files())]->tmp
first<-read.table(tmp[1],sep='\t',header=F)
for(i in tmp[-1]){
	file<-read.table(i,sep='\t',header=F)
	first<-cbind(first,file[,2])
}
tmp<-as.matrix(tmp)
colnames(first)[2:dim(first)[2]]<-apply(tmp,1,function(x){unlist(strsplit(x,"_"))[1]})