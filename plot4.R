## Loading the data

if (!file.exists("./data/household_power_consumption.txt")) {{dir.create("./data")}
                                                             download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="./data/power_data.zip")
                                                             unzip("./data/power_data.zip", overwrite = T, exdir = "./data")
}

entire_data <- read.table ("./data/household_power_consumption.txt", header=TRUE, sep=';', na.strings="?")
entire_data$Date <- as.Date(entire_data$Date, format="%d/%m/%Y")

## The dataset has 2,075,259 rows and 9 columns
## Estimated memory: 2,075,259 * 9 * 8 bytes/numeric ≈ 149mb
## Instead of reading the entire dataset, we will only be using data from the dates 2007-02-01 and 2007-02-02.
## Subsetting dataset:

subset_data <- subset (entire_data,subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(entire_data)

## Converting Dates:
datetime <- paste(as.Date(subset_data$Date), subset_data$Time)
subset_data$Datetime <- as.POSIXct(datetime)

## Making Plots
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(subset_data, {
        plot(Global_active_power~Datetime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        plot(Voltage~Datetime, type="l", 
             ylab="Voltage (volt)", xlab="")
        plot(Sub_metering_1~Datetime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~Datetime, type="l", 
             ylab="Global Rective Power (kilowatts)",xlab="")
})

## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

