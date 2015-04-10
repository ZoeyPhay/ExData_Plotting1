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
hist(subset_data$Global_active_power, main = "Global Active Power", ylab = "Frequency", xlab = "Global Active Power (kilowatts)", col = "red", breaks = 13, ylim = c(0,1200), xlim = c(0, 6), xaxp = c(0, 6, 3))

## Saving file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
