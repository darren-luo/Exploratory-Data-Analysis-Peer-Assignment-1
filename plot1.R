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

## Convert dates into Date format and filter required dates for analysis
rawdata$Date <- dmy(rawdata$Date)
data_filtered <- filter(rawdata, Date >= "2007-02-1" & Date <= "2007-02-02")

## Open png graphics device, setting file name and required plot size
png(filename = "plot1.png", width = 480, height = 480)

## Plot 1: Frequency Distribution Histogram of Global Active Power
data_filtered$Global_active_power <- as.numeric(as.character(data_filtered$Global_active_power))

hist(data_filtered$Global_active_power, 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power", 
     col = "red")

## Close png graphics device
dev.off()







