# Load data
data <- read.table("household_power_consumption.txt", 
                   sep=";", header = T, na.strings = "?",
                   stringsAsFactors = F)
# Convert date column to date data type
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
# Convert time column to date data type with time format
#data$Time <- format(strptime(data$Time, format="%T"), format="%T")
#data$Time <- strptime(data$Time, format="%T")

# Define min and max dates for filtering
minDate = as.Date("2/1/2007", format = "%m/%d/%Y")
maxDate = as.Date("2/2/2007", format = "%m/%d/%Y")

# Filter data
data <- data[data$Date <= maxDate & data$Date >= minDate,]

# Convert units from watts to kilowatts
kilo <- data$Global_active_power

# Open png file
png('plot1.png', width = 480, height = 480, units = "px")

# Plot labeled histogram
hist(kilo, breaks=12, col="red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

# Close png device
dev.off()




