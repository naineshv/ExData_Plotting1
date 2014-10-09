# plot1.R - the script constructs the first plot that is a histogram of Global Active Power in kilowatts
# in a file called plot1.png
# Usage: #source("plot1.R")

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

# conversion to date is not required for this plot but still ..
data <- mutate(data, DateTime=as.POSIXct(strptime(paste(Date, Time),format="%d/%m/%Y %T")), Date = as.Date(Date, "%d/%m/%Y"))

# open png file device, height and width are default = 480 px
png("plot1.png")

# make the plot with the required color and labels
with(data, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))

# close the graphics device
dev.off()
