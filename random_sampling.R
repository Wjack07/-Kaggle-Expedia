
set.seed(1)
setwd(".../Expedia")
filename1 = "train.csv"

line_number <- 100000   # select how many lines to sample
x <- sample(1:37670294,line_number)
x <- append(x,0)        # put 0 at the begining. It will be used later
x <- sort(x)            # create the random number

header <- read.csv(filename1, nrows = 1, header = FALSE, stringsAsFactors = FALSE)
myData <- read.csv(filename1, skip=1, nrows=1,header = FALSE)               # This one is to set up the format of 'myData'

buffer <- scan(f,what="a",nlines=1,sep=",")                                 # remove the header line
for(i in 1:line_number){
    buffer=scan(filename1,what="a",nlines=x[i]-x[i-1],sep=",",quiet=TRUE)   # read line with flag, which record where has been read
    buffer = t(matrix(buffer,nrow=24))
    buffer = data.frame(buffer)                                             # make it list
    myData <- rbind(myData,buffer)  
}

colnames( myData ) <- unlist(header)  # Add header back

write.csv(myData , file = "train_sampled.csv", row.names = TRUE)             # write the sampled data, optional
