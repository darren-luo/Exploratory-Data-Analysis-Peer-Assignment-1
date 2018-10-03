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

## Convert Necessary columns to numeric
data_filtered$Global_active_power <- as.numeric(as.character(data_filtered$Global_active_power))
data_filtered$Sub_metering_1 <- as.numeric(as.character(data_filtered$Sub_metering_1))
data_filtered$Sub_metering_2 <- as.numeric(as.character(data_filtered$Sub_metering_2))
data_filtered$Sub_metering_3 <- as.numeric(as.character(data_filtered$Sub_metering_3))
data_filtered$Voltage <- as.numeric(as.character(data_filtered$Voltage))
data_filtered$Global_reactive_power <- as.numeric(as.character(data_filtered$Global_reactive_power))

## Open png graphics device, setting file name and required plot size
png(filename = "plot4.png", width = 480, height = 480)

## Setup plot area dimensions and margins
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(2,2,2,2))
        
## Plot Graphs    
with(data_filtered,{
    ## Global active Power
    plot(Date_time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

    ## Voltage
    plot(Date_time, Voltage, type = 'l', xlab = "datetime", col = "black")
    
    ## Energy sub metering
    plot(Date_time, Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
        lines(Date_time, data_filtered$Sub_metering_2, type = "l", col = "red")
        lines(Date_time, data_filtered$Sub_metering_3, type = "l", col = "blue")

        ## Add legend to Energy sub metering plot
        legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), box.lty = 0)
        
    ## Global Reactive Power    
    plot(Date_time, Global_reactive_power, type = 'l', xlab = "datetime", col = "black")    
})

## Close png graphics device
dev.off()
