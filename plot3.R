## Read all lines from the data file
f <- readLines("../household_power_consumption.txt")
## Get first row -> used for data-frame
firstRow <- f[1]
## Only load rows from 1st and 2nd February 2007
rowsToEvaluate <- c(firstRow,grep("^2/[1,2]/2007;+",f,value=TRUE))
## Load rows to evaluate into a data-frame
powerData <- read.table(textConnection(rowsToEvaluate),sep=";",header=TRUE)
## Create a new DateTime column from the date and time columns
powerData <- transform(powerData, DateTime = as.POSIXct(strptime(paste(Date,Time,sep=" "), "%m/%d/%Y %H:%M:%S")))
## Create the plot
## Define the plot details
y1 <- powerData$Sub_metering_1
y2 <- powerData$Sub_metering_2
y3 <- powerData$Sub_metering_3
x <- powerData$DateTime
## Calculate total y range
yrange <- c(0,max(y1,y2,y3)+10)
## Define the base plot, add
plot(x,y1,xlab="",ylab="Energy sub metering",type="l",ylim = yrange)
## Add the points to plot
points(x,y1,col="black",type="l")
points(x,y2,col="red",type="l")
points(x,y3,col="blue",type="l")
# Create the legend
legend("topright",  
       # labels for legend
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       # legend  symbols (lines)
       xjust = 0.5,
       lty=c(1,1,1), 
       # legend lines color and width
       lwd=c(1,1),col=c("black","red","blue")) 
## Copy the plot to PNG of size 480 by 480
dev.copy(png, file = "plot3.png",width=480,height=480) 
## close the PNG device
dev.off() 