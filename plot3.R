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


#plot3
Sys.setlocale("LC_TIME", "en_GB") #display names of days in English
png(filename = "plot3.png",
    width = 480, height = 480, units = "px", bg = "transparent")
plot(hpc[,2], hpc[,7], xlab = "",
     ylab = "Energy sub metering", type = "l")
lines(hpc[,2],hpc[,8], col = "red")
lines(hpc[,2],hpc[,9], col = "blue")
legend("topright", names(hpc[,c(7:9)]), lty = 1, 
       col = c("black", "red", "blue"))
dev.off()
Sys.setlocale("LC_TIME", "") #reset settings to default system language
