# load package
library(dplyr)

# download and unzip file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="data.zip", method="curl")
unzip ("data.zip", exdir = "./")

# read data
data_full <- read.table("household_power_consumption.txt", header=TRUE, na.strings="?", sep=";")
data <- data_full%>%
  filter(Date %in% c("1/2/2007", "2/2/2007"))

# plot1.png
with(data = data, hist(Global_active_power,
                       col = "red",
                       main = "Global Active Power",
                       xlab = "Global Active Power (kilowatts)",
                       ylab = "Frequency")
     )
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()