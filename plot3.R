# plot3.R - the script constructs the third plot which is Energy sub metering v/s Week Day
# in a file called plot3.png
# Usage: #source("plot3.R")

library(dplyr)
library(sqldf)

# download the file if it does not exist in the working directory
if (!file.exists("household_power_consumption.txt")) {
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(url, "household_power_consumption.zip")
        unzip("household_power_consumption.zip", "household_power_consumption.txt")
}

# read data for two days only, i have used the sqldf package for the same
data <- tbl_df(read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date in ('1/2/2007','2/2/2007')", header=T, sep=";"))

# converting date to Date class and adding a new column DateTime which is a combination of Date and Time 
# and is of class Date
data <- mutate(data, DateTime=as.POSIXct(strptime(paste(Date, Time),format="%d/%m/%Y %T")), Date = as.Date(Date, "%d/%m/%Y"))

# open png file device, height and width are default = 480 px
png("plot3.png")

# make the plot with the required color and labels and legend
with(data, {
        plot(x = DateTime, y = Sub_metering_1, type = "l", col = "black", xlab="", ylab="")
        lines(x = DateTime, y = Sub_metering_2, type = "l", col = "red", xlab="", ylab="")
        lines(x = DateTime, y = Sub_metering_3, type = "l", col = "blue", xlab="", ylab="")
        title(ylab = "Energy sub metering", xlab="")
        legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

# close the graphics device
dev.off()
