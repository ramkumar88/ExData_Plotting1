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
y <- powerData$Global_active_power
x <- powerData$DateTime
plot(x,y,xlab="",ylab="Global Active Power (kilowatts)",type="l",ylim=c(0,max(y)))
## Copy the plot to PNG of size 480 by 480
dev.copy(png, file = "plot2.png",width=480,height=480) 
## close the PNG device
dev.off() 