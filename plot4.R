importedData <- read.csv("household_power_consumption.txt", sep=";")
dayOne <- subset(importedData, Date == "1/2/2007")
dayTwo <- subset(importedData, Date == "2/2/2007")
workingData <- rbind(dayOne, dayTwo);

## convert to vector then numeric
workingData[, 3:9] <- sapply(workingData[, 3:9], as.vector)
workingData[, 3:9] <- sapply(workingData[, 3:9], as.numeric)

## parsing date components into new columns for accurate date conversion
workingData$Year <- lapply(strsplit(as.character(workingData$Date), "/"), "[", 3)
workingData$Month <- lapply(strsplit(as.character(workingData$Date), "/"), "[", 2)
workingData$Day <- lapply(strsplit(as.character(workingData$Date), "/"), "[", 1)

## create proper DateTime column
workingData$DateTime <- as.POSIXct(paste(
    workingData$Year, "-",
    workingData$Month, "-",
    workingData$Day, " ",
    workingData$Time, 
    sep=""),
format="%Y-%m-%d %H:%M:%S") 

png(filename="plot4.png")

par(mfcol = c(2, 2))

## topleft
plot(workingData$DateTime, workingData$Global_active_power,
    type="l",
    xlab="",
    ylab="Global Active Power"
)

## bottomleft
plot(workingData$DateTime, workingData$Sub_metering_1,
    type = "n",
    xlab = "",
    ylab = "Energy sub metering"
)
lines(workingData$DateTime, workingData$Sub_metering_1, col="black")
lines(workingData$DateTime, workingData$Sub_metering_2, col="red")
lines(workingData$DateTime, workingData$Sub_metering_3, col="blue")

legend(
    "topright",
    ,
    c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
    lty=c(1,1,1),
    col=c("black", "red", "blue"),
    bty="n"
)

##topright
plot(workingData$DateTime, workingData$Voltage,
    type="l",
    xlab="datetime",
    ylab="Voltage"
)

##bottomright
plot(workingData$DateTime, workingData$Global_reactive_power,
    type="l",
    xlab="datetime",
    ylab="Global_reactive_power"
)

dev.off()