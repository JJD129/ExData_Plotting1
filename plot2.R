# load package
library(dplyr)

# download and unzip file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="data.zip", method="curl")
unzip ("data.zip", exdir = "./")

# read data
data_full <- read.table("household_power_consumption.txt", header=TRUE, na.strings="?", sep=";")
data <- data_full%>%
  filter(Date %in% c("1/2/2007", "2/2/2007"))

# date and time format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
dateTime <- paste(data$Date, data$Time)
data$DateTime <- as.POSIXct(dateTime)

# plot2.png
with(data = data, plot(Global_active_power~DateTime,
                       type = "l",
                       xlab = "",
                       ylab = "Global Active Power (kilowatts)"
                       )
)
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()