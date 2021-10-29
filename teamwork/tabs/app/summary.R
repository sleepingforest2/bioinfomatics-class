summary2<-function(data,x,y){
  tmp <- levels(as.factor(data[,x]))
  tmp1 <- as.character(c(1:length(tmp)))
  tmp2 <- matrix(nrow = length(tmp), ncol = 8)    
  for (i in 1:length(tmp))
  {
    temp <- data[data[,x]==tmp[i],y]
    tmp2[i, 1]<-tmp[i]
    tmp2[i, 2] <- mean(temp)
    tmp2[i, 3] <- sd(temp) / sqrt(length(temp))
    tmp2[i, 4] <- sd(temp)
    tmp2[i, 5] <- min(temp)
    tmp2[i, 6] <- max(temp)
    tmp2[i, 7] <- median(temp)
    tmp2[i, 8] <- length(temp)
  }
  tmp2 <- as.data.frame(tmp2)
  row.names(tmp2) <- tmp
  colnames(tmp2) <- c(colnames(data)[x] ,"mean", "se", "sd", "min", "max", "median", "n")
  return(tmp2)
}
