#read data 
hpc <- read.table("data/household_power_consumption.txt", 
                  sep=";", skip = 66637, nrows = 2880,
                  stringsAsFactors = FALSE, na.strings = "?",
                  col.names = colnames(read.table("data/household_power_consumption.txt", 
                                                  sep=";", header = T,  nrows = 1,)) )

hpc[,1] <- as.Date(hpc[,1], format = "%d/%m/%Y") #convert Date 
x <- paste(hpc[,1], hpc[,2])                     #convert time
x <- strptime(x, "%Y-%m-%d %H:%M:%S")

#add time column and substitute the existing one
hpc <- cbind(hpc, x)  
hpc[,2] <- hpc[,10]
hpc <- hpc[,-10]
rm(x)


#plot1
png(filename = "plot1.png",
    width = 480, height = 480, units = "px", bg = "transparent")
hist(hpc[,3], breaks = 20, col = "red", 
     xlab = "Global Active Power (kilowats)", 
     main = "Global Active Power" )
dev.off()



