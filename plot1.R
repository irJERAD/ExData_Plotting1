plot1 ()
        
        library(sqldf)
        
        fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        temp <- tempfile()
        download.file(fileUrl, temp)
        raw <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep=";", colClasses = "character")
        unlink(temp)
        powerdata <- read.csv.sql(sql = "SELECT * from raw WHERE Date in ('1/2/2007','2/2/2007')", sep = ";", header = TRUE)
        
        # Generate plot1 histograph of Global Active Power
        with(powerdata, hist(as.numeric(Global_active_power), xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red"))
