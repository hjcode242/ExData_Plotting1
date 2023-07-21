#opening the data library
library("data.table")


#set wd 
setwd("C:/Users/Hannah-Joy Simms/Desktop/coursera/exdata_data_household_power_consumption/")

power_data <- data.table::fread("C:/Users/Hannah-Joy Simms/Desktop/coursera/exdata_data_household_power_consumption/household_power_consumption.txt", na.strings = "?")


# Formatting numbers
power_data[, Global_active_power := format(Global_active_power, scientific = FALSE)]

# Create the dateTime column using as.POSIXct with explicit date and time formats
power_data[, Date := as.character(Date)]
power_data[, Time := as.character(Time)]
power_data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S", tz = "UTC")]

# Filter out rows with NA values in the dateTime column
power_data <- power_data[complete.cases(power_data)]

# Filter Dates 
power_data_filtered <- power_data[dateTime >= as.POSIXct("2007-02-01", tz = "UTC") & 
                                    dateTime < as.POSIXct("2007-02-03", tz = "UTC")]

# Save the plots to a file
png("plot4.png", width = 480, height = 480)

# Create a 2x2 layout for the graphs
par(mfrow = c(2, 2))

data_to_plot <- power_data_filtered[, c("Global_active_power", "Voltage", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3", "Global_reactive_power")]

data_to_plot <- power_data_filtered[, c("Global_active_power", "Voltage", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3", "Global_reactive_power")]

par(mfrow = c(2, 2))

plot(power_data_filtered[, dateTime], power_data_filtered[, Global_active_power], type = "l", xlab = "", ylab = "Global Active Power")

plot(power_data_filtered[, dateTime], power_data_filtered[, Voltage], type = "l", xlab = "datetime", ylab = "Voltage")

matplot(power_data_filtered[, dateTime], data_to_plot[, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")], type = "l",
        xlab = "", ylab = "Energy sub metering", col = c("black", "red", "blue"))

legend("topright", col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1), bty = "n", cex = 0.5)

plot(power_data_filtered[, dateTime], power_data_filtered[, Global_reactive_power], type = "l", xlab = "datetime", ylab = "Global Reactive Power")

par(mfrow = c(1, 1)
