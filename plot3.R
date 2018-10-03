## Initialise packages
library(dplyr)
library(lubridate)

## Download files and read data
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "data.zip")

if(!file.exists("household_power_consumption")){
    unzip("data.zip")
}

rawdata <- tbl_df(read.table("household_power_consumption.txt", header = T, stringsAsFactors = T, sep =";"))

## Convert dates and time into Date/Time format and filter required dates for analysis
rawdata <- mutate(rawdata, Date_time = paste(Date, Time, sep = " "))
rawdata$Date_time <- dmy_hms(rawdata$Date_time)

rawdata$Date <- dmy(rawdata$Date)
data_filtered <- filter(rawdata, Date >= "2007-02-1" & Date <= "2007-02-02")

## Convert Column formats
data_filtered$Sub_metering_1 <- as.numeric(as.character(data_filtered$Sub_metering_1))
data_filtered$Sub_metering_2 <- as.numeric(as.character(data_filtered$Sub_metering_2))
data_filtered$Sub_metering_3 <- as.numeric(as.character(data_filtered$Sub_metering_3))

## Open png graphics device, setting file name and required plot size
png(filename = "plot3.png", width = 480, height = 480)

## Plot 3: Graph of Energy  sub metering vs Day of Week
with(data_filtered, plot(Date_time, Sub_metering_1, 
                         type = "l", 
                         col = "black", 
                         xlab = "", 
                         ylab = "Energy sub metering"))

with(data_filtered, lines(Date_time, data_filtered$Sub_metering_2, type = "l", col = "red"))
with(data_filtered, lines(Date_time, data_filtered$Sub_metering_3, type = "l", col = "blue"))

## Add legend to plot
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Close png graphics device
dev.off()







