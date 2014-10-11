importedData <- read.csv("household_power_consumption.txt", sep=";")
dayOne <- subset(importedData, Date == "2/1/2007")
dayTwo <- subset(importedData, Date == "2/2/2007")
workingData <- rbind(dayOne, dayTwo);

## convert to numeric
workingData[, 2:9] <- sapply(workingData[, 2:9], as.numeric)

png(filename="plot1.png")

hist(workingData$Global_active_power,
    main = "Global Active Power",
    xlab = "Global Active Power (kilowatts)",
    col = "red")
    
 dev.off()