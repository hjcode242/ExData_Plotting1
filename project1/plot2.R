#opening the data library
library("data.table")

#set wd 
setwd("C:/Users/Hannah-Joy Simms/Desktop/coursera/exdata_data_household_power_consumption/")

#read the data from the file
power_data <-  data.table::fread(input = "household_power_consumption.txt"
                                 , na.strings="?")
#formatting numbers
power_data[, Global_active_power := format(Global_active_power, scientific = FALSE)]

#date
if (!requireNamespace("lubridate", quietly = TRUE)) {
  install.packages("lubridate")
}
library(lubridate)

# Create the dateTime column using lubridate
power_data[, dateTime := parse_date_time(paste(Date, Time), orders = c("dmy H:M:S", "mdy H:M:S", "ymd H:M:S"))]

##plot 2 and png
plot(x = power_data$dateTime, y = power_data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

png("plot2.png", width=480, height=480)

