workvar <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

##   Format date 
workvar$Date <- as.Date(workvar$Date, "%d/%m/%Y")
  
## 	data set from Feb. 1, 2007 to Feb. 2, 2007
workvar<- subset(workvar,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
  
## Remove incomplete observation
workvar<- workvar[complete.cases(workvar),]

## Combine Date and Time column
dateTime <- paste(workvar$Date, workvar$Time)
  
## Name the vector
dateTime <- setNames(dateTime, "DateTime")
  
## Remove Date and Time column
workvar <- workvar[ ,!(names(workvar) %in% c("Date","Time"))]
  
## Add DateTime column
workvar <- cbind(dateTime, workvar)
  
## Format dateTime Column
workvar$dateTime <- as.POSIXct(dateTime)

 ## Create Plot 3
  with(t, {
    plot(Sub_metering_1~dateTime, type="l",
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~dateTime,col='Red')
    lines(Sub_metering_3~dateTime,col='Blue')
  })
  legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving to file PNG
  dev.copy(png, file="plot3.png", height=480, width=480)
  dev.off()