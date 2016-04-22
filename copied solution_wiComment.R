library(data.table)


setwd(".../[Case 9] Expedia")
filename1 = "train_small.csv"
filename2 = "test_small.csv"

myTrain <- read.csv(filename1)
myTest  <- read.csv(filename2)

myTrain_datatable <- data.table(myTrain)
dest_id_hotel_cluster <-myTrain_datatable[,length(is_booking),by=list(srch_destination_id, hotel_cluster)]
# This way of writing is very specific for data table format
# the length(is_booking) means under such a list arrangement, how many are booked. Very specific way
# by=... is useful since it will sort out stuff by these variaty
# the result is to count for each pair of destination and hotel_cluster, how many time it has been booked
# by R's defualt, V1 means how many counts


# Now we need to analysize each destination, and found out what is their most popular hotel_cluster
top_five <- function(hc,v1){
  hc_sorted <- hc[order(v1,decreasing=TRUE)]
  # here, it uses 'order' function to ascend sort the array first
  # and then by re-order hc, it sort hc based on v1 and pass t hc_sorted
  
  n <- min(5,length(hc_sorted))
  # only chose the 5 (or less than 5) destination
  
  x<-paste(hc_sorted[1:n],collapse=" ")
  # this part just print sorted array and send to x
  
  return(x)
  # having return is the stand way of writing. But in R, without return sometimes can work 
  # for example, the way the raw post shared solution on the website
}


dest_top_five <- dest_id_hotel_cluster[,top_five(hotel_cluster,V1),by=srch_destination_id]
# This way of writing is also useful.
# as long as 'by' is defined, only the data with the same 'by' value will be input, as array.
# and the written top_five, only take two arrays (hc and v1), and then return the value


result_1 <- merge(myTest,dest_top_five, by="srch_destination_id",all.x=TRUE)
# merge function is very useful, it can merge two data frame by comparing their parameter (by by.x by.y)
# all.x =TRUE means making NA if not found

result_2 <- result_1[,c('id','V1')]             # now we only extract id and V1
result_3 <- result_2[order(result_2$id),]       # now we re-order it by id
setnames(result_3,c("id","hotel_cluster"))      # just to give it header

write.csv(result_3, file='submission.csv', row.names=FALSE)
