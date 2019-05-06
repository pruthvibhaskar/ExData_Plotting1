## Load the Data 
Data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type Date
Data$Date <- as.Date(Data$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
Data <- subset(Data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
data_Complete <- Data[complete.cases(Data),]

## Combine Date and Time column
date_Time <- paste(data_Complete$Date, data_Complete$Time)

## Name the vector
date_Time <- setNames(date_Time, "DateTime")

## Remove Date and Time column
data_Complete <- data_Complete[ ,!(names(data_Complete) %in% c("Date","Time"))]

## Add DateTime column
data_Complete <- cbind(date_Time, data_Complete)

## Format dateTime Column
data_Complete$date_Time <- as.POSIXct(date_Time)

##  Plot 3
with(data_Complete, {
  plot(Sub_metering_1~date_Time, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~date_Time,col='Red')
  lines(Sub_metering_3~date_Time,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, filename = 'plot3.png',  width=480, height=480)
dev.off()