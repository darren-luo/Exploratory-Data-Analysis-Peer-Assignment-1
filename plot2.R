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

## Open png graphics device, setting file name and required plot size
png(filename = "plot2.png", width = 480, height = 480)

## Plot 2: Line Graph of Global Active Power vs Day of Week
data_filtered$Global_active_power <- as.numeric(as.character(data_filtered$Global_active_power))

with(data_filtered, plot(Date_time, Global_active_power, 
                         type = "l",
                         xlab = "",
                         ylab = "Global Active Power (kilowatts)"))

## Close png graphics device
dev.off()







