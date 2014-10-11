## This script requires you have sqldf library installed
# to install this please ren > install.packages("sqldf")
# before running the program

library(sqldf)

fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# creating temp folder to hold zip file
temp <- tempfile()

# downloading zip file into temp folder
download.file(fileUrl, temp)

# unzip file, read table and save results as variable raw
raw <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep=";", colClasses = "character", na.strings = "?")

# The temp folder containing the zip is now released
unlink(temp)

# create data frame powerdata to hold data on desired dates
powerdata <- read.csv.sql(sql = "SELECT * from raw WHERE Date in ('1/2/2007','2/2/2007')", sep = ";", header = TRUE)
# create vector datetime of POSIXlt class
datetime <- strptime(paste(powerdata$Date, powerdata$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")
# add POSIX column
powerdata$datetime <- datetime

# Create plot
with(powerdata, plot(datetime,Sub_metering_1, col = "black", ylab = "Enery sub metering", xlab = "", type = "n"))
with(powerdata, lines(datetime,Sub_metering_1, col = "black"))
with(powerdata, lines(datetime,Sub_metering_2, col = "red"))
with(powerdata, lines(datetime,Sub_metering_3, col = "blue"))

# create legend
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# create PNG of graph
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()