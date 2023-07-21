library("data.table")

#setwd
setwd("C:/Users/Hannah-Joy Simms/Desktop/coursera/exdata_data_household_power_consumption/")


power_data[, Global_active_power := as.numeric(Global_active_power)]

if (!requireNamespace("lubridate", quietly = TRUE)) {
  install.packages("lubridate")
}
library(lubridate)

# Create the dateTime column using lubridate and explicit date format
power_data[, dateTime := parse_date_time(paste(Date, Time), orders = c("dmy H:M:S", "mdy H:M:S", "ymd H:M:S"))]

# Filter Dates for 2007-02-01 and 2007-02-02 using lubridate
power_data <- power_data[dateTime >= ymd("2007-02-01") & dateTime < ymd("2007-02-03")]

# Sort the data by dateTime for correct line connections
power_data <- power_data[order(dateTime)]

#plot3
plot(power_data$dateTime, power_data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(power_data$dateTime, power_data$Sub_metering_2, col = "red")
lines(power_data$dateTime, power_data$Sub_metering_3, col = "blue")

#legend
legend("topright", col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1), lwd = c(1, 1))


png("plot3.png", width = 480, height = 480)
dev.off()


