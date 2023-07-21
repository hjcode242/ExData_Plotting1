#open datatable
library("data.table")

#set wd
setwd("~/Desktop/coursera/exdata_data_household_power_comsumption")

#read the data from the file
power_data <-  data.table::fread(input = "household_power_consumption.txt"
                                 , na.strings="?")

#formatting numbers
power_data[, Global_active_power := format(Global_active_power, scientific = FALSE)]

#combine Date and Time
power_data[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

power_data <- power_data[parse_date_time(Date, orders = c("ymd", "dmy", "mdy")) >= ymd("2007-02-01") &
                     parse_date_time(Date, orders = c("ymd", "dmy", "mdy")) <= ymd("2007-02-02")]


#histogram for plot 1 and png
if (!is.numeric(power_data$Global_active_power)) {
  power_data$Global_active_power <- as.numeric(power_data$Global_active_power)
}
hist(power_data$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "Red")
png("plot1.png", width = 480, height = 480)
dev.off()
