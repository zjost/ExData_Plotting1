# Load data
data <- read.table("household_power_consumption.txt", 
                   sep=";", header = T, na.strings = "?",
                   stringsAsFactors = F)
# Convert date column to date data type
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")


# Define min and max dates for filtering
minDate = as.Date("2/1/2007", format = "%m/%d/%Y")
maxDate = as.Date("2/2/2007", format = "%m/%d/%Y")

# Filter data
data <- data[data$Date <= maxDate & data$Date >= minDate,]

# Create combined date/time string
dt <- paste(as.character(data$Date), data$Time, sep= " ")
# Convert to POSIXct data structure
dt <- strptime(dt, format = "%Y-%m-%d %T")

# Bind to original data frame
data <- cbind(data, dt)


# Open png file
png('plot4.png', width = 480, height = 480, units = "px")

# Create plot
par(mfrow = c(2,2))

with(data, {
    plot(data$dt, data$Global_active_power, type = "l", main = "", xlab = "", 
         ylab = "Global Active Power")
    plot(data$dt, data$Voltage, type = "l", main="", xlab = "datetime",
         ylab = "Voltage")
    plot(data$dt, data$Sub_metering_1, main = "", xlab = "", 
         ylab = "Energy sub metering", type = "n")
    lines(data$dt, data$Sub_metering_1, col="black")
    lines(data$dt, data$Sub_metering_2, col="red")
    lines(data$dt, data$Sub_metering_3, col="blue")
    legend("topright", lwd = 1, col=c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")
    plot(data$dt, data$Global_reactive_power, type = "l", main = "", 
         xlab = "datetime", 
         ylab = "Global_reactive_power")
})

# Close png device
dev.off()

