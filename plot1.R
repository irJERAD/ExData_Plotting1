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
        raw <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep=";", colClasses = "character")
        
        # The temp folder containing the zip is now released
        unlink(temp)

        # create data frame powerdata to hold data on desired dates
        powerdata <- read.csv.sql(sql = "SELECT * from raw WHERE Date in ('1/2/2007','2/2/2007')", sep = ";", header = TRUE)
        
        # Generate plot1 histograph of Global Active Power
        with(powerdata, hist(as.numeric(Global_active_power), xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red"))
        dev.copy(png, file = "plot1.png", width = 480, height = 480)
        dev.off()
        ## TODO
        ## rewatch video on how to export to PNG file (as well as correct size)
        ## push png file to github repo