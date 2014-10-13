importedData <- read.csv("household_power_consumption.txt", sep=";")
dayOne <- subset(importedData, Date == "1/2/2007")
dayTwo <- subset(importedData, Date == "2/2/2007")
workingData <- rbind(dayOne, dayTwo);

## convert to vector then numeric
workingData[, 3:9] <- sapply(workingData[, 3:9], as.vector)
workingData[, 3:9] <- sapply(workingData[, 3:9], as.numeric)

png(filename="plot1.png")

hist(workingData$Global_active_power,
    main = "Global Active Power",
    xlab = "Global Active Power (kilowatts)",
    col = "red")
    
 dev.off()