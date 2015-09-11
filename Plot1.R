## Plot1.R
## Created 11-Sep-15 as part of Exploratory Data Analysis, week 1, project 1
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
consump2$Log_time <- strptime(paste(consump2$Date,consump2$Time), "%d/%m/%Y %H:%M:%S", tz="CET")

# (5). Create png file for Plot 1.  The hex RGB value for the bar colour was taken from the example
png(filename = "Plot1.png", width=480, height=480)
hist(consump2$Global_active_power, col= "#DA4820", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
