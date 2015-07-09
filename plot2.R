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


kilo <- data$Global_active_power

# Open png file
png('plot2.png', width = 480, height = 480, units = "px")

# Create plot
plot(dt, kilo, type = "l", main = "", xlab = "", 
     ylab = "Global Active Power (kilowatts)")

# Close png device
dev.off()

