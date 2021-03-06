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

png(filename="plot2.png")

plot(workingData$DateTime, workingData$Global_active_power,
    type="l",
    xlab="",
    ylab="Global Active Power (kilowatts)"
)

dev.off()