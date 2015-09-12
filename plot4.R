## plot4.R
## Created 12-Sep-15 as part of Exploratory Data Analysis, week 1, project 1
## Sumbit four sets of R-code and the png plot it creates 
##
## Assumptions: the current working directory is the location for all input and output

# dplyr needed for filter
library(dplyr)

#Electric power consumption dataset
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, dest= "exdata-data-household_power_consumption.zip")
# (1). Unzip the file ...
unzip("exdata-data-household_power_consumption.zip", files = "household_power_consumption.txt", overwrite = TRUE)

# (2). Create dataframe, specifying as.is TRUE for the Date and Time columns, which leaves them as strings
consump <- read.table("household_power_consumption.txt", header=TRUE, sep=";", quote="", na.strings = c("?"), as.is = c(TRUE, TRUE))

# (3). extract only the 2 days of interest
consump2 <- filter(consump, Date == "1/2/2007" | Date == "2/2/2007" )
rm("consump")  # free memory

# (4). convert Date + Time into datetime class for ease of plotting
# tz doesn't really matter, but data is from France so assume CET
# Note that without forcing the class to POSIXct we get a combination of POSIXlt POSIXt that cannot be used for plots
consump2$Log_time <- as.POSIXct(strptime(paste(consump2$Date,consump2$Time), "%d/%m/%Y %H:%M:%S", tz="CET"))

## PLOT 2 X 2 PANEL OF CHARTS ...
png(filename = "plot4.png", width=480, height=480)

# Set panel layout as 2 rows by 2 columns
par(mfrow = c(2,2))

# Plot 1,1 Global Active Power (same as plot 2) except for no units on ylab
with(consump2, plot(Log_time, Global_active_power, type = "l", xlab = "", ylab="Global Active Power" ))

# Plot 1,2 Voltage
with(consump2, plot(Log_time, Voltage, type = "l", xlab = "datetime", ylab="Voltage" ))

# Plot 2,1 Energy Sub Numbering, same as plot 3 but no panel-border
with(consump2, plot(Log_time, Sub_metering_1, type = "n", xlab="", ylab="Energy sub metering"))
with(consump2, points(Log_time, Sub_metering_1, col = "black", type = "l"))
with(consump2, points(Log_time, Sub_metering_2, col = "red", type = "l"))
with(consump2, points(Log_time, Sub_metering_3, col = "blue", type = "l"))
legend("topright", lty=c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), bty = "n" )

# Plot 2,2 Global Reactive Power
with(consump2, plot(Log_time, Global_reactive_power, type = "l", xlab = "datetime", ylab="Global_reactive_power" ))

dev.off()
