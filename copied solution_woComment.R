library(data.table)


setwd(".../[Case 9] Expedia")
filename1 = "train_small.csv"
filename2 = "test_small.csv"

myTrain <- read.csv(filename1)
myTest  <- read.csv(filename2)

myTrain_datatable <- data.table(myTrain)
dest_id_hotel_cluster <-myTrain_datatable[,length(is_booking),by=list(srch_destination_id, hotel_cluster)]


top_five <- function(hc,v1){
  hc_sorted <- hc[order(v1,decreasing=TRUE)]
  n <- min(5,length(hc_sorted))
  x<-paste(hc_sorted[1:n],collapse=" ")
  return(x)
}

dest_top_five <- dest_id_hotel_cluster[,top_five(hotel_cluster,V1),by=srch_destination_id]
result_1 <- merge(myTest,dest_top_five, by="srch_destination_id",all.x=TRUE)
result_2 <- result_1[,c('id','V1')]             
result_3 <- result_2[order(result_2$id),]       
setnames(result_3,c("id","hotel_cluster"))      
write.csv(result_3, file='submission.csv', row.names=FALSE)
