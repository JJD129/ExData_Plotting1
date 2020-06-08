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

# plot4.png
par(mfrow=c(2,2), mar=c(4,4,2,1))
with(data = data, {plot(Global_active_power~DateTime,
                       type = "l",
                       xlab = "",
                       ylab = "Global Active Power (kilowatts)"
                       )
  plot(Voltage~DateTime,
       type="l",
       ylab = "Volatage (volt)",
       xlab = ""
       )
  plot(Sub_metering_1~DateTime,
                          type = "l",
                          xlab = "",
                          ylab = "Energy sub metering")
    lines(Sub_metering_2~DateTime,
          col = "red")
    lines(Sub_metering_3~DateTime,
          col = "blue")
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         col = c("black","red","blue"),
         lty = 1,
         bty = "n"
  )
  plot(Global_reactive_power~DateTime,
       type = "l",
       ylab = "Global Reactive Power (kilowatts)",
       xlab = "")
})

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()