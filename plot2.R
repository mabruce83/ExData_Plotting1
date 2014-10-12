## Read power consumption data if it does not exist in memory:
if(!exists("power_consume")) {
  power_consume <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
}

## Format data to set up plotting:
# Trim dates to desired range:
trim_DF <- power_consume[power_consume$Date == "1/2/2007" | power_consume$Date == "2/2/2007",]

# Combine date/time column:
trim_DF$Date <- paste(trim_DF$Date, trim_DF$Time)
trim_DF$Time <- NULL

# Convert factors to date/time:
trim_DF$Date <- strptime(trim_DF$Date, format = "%d/%m/%Y %H:%M:%S")

# Get rid of Sub_metering columns:
trim_DF$Sub_metering_1 <- NULL
trim_DF$Sub_metering_2 <- NULL
trim_DF$Sub_metering_3 <- NULL

# Convert the rest of the data to numeric format:
trim_DF$Global_active_power <- as.numeric(as.character(trim_DF$Global_active_power))
trim_DF$Global_reactive_power <- as.numeric(as.character(trim_DF$Global_reactive_power))
trim_DF$Voltage <- as.numeric(as.character(trim_DF$Voltage))
trim_DF$Global_intensity <- as.numeric(as.character(trim_DF$Global_intensity))

## Plot requested data:
png(file = "plot2.png")
plot(trim_DF$Date,trim_DF$Global_active_power, type="l",main="", 
     xlab="", ylab="Global Active Power (kilowatts)")
dev.off()