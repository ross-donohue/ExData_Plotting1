library(tidyverse)
library(data.table)
file.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file.dest <- "ExData.zip"
zip.dir <- "/ExData"
download.file(file.url, file.dest)
unzip(file.dest, exdir = zip.dir)
HPC <- fread(paste(zip.dir, dir(zip.dir)[[1]], sep = "/"))
HPC$Date <- HPC[, Date] %>%
  as.Date(format = "%d/%m/%Y")
HPC <- HPC[Date == "2007-02-01" | Date == "2007-02-02"]
HPC$Datetimes <- paste(HPC$Date, HPC$Time) %>%
  as.POSIXct()
HPC$Global_active_power<- as.numeric(HPC[,Global_active_power])
HPC$Sub_metering_1 <- as.numeric(HPC$Sub_metering_1)
HPC$Sub_metering_2 <- as.numeric(HPC$Sub_metering_2)
HPC$Sub_metering_3 <- as.numeric(HPC$Sub_metering_3)

png(filename = "plot4.png", width = 480, height = 480)
attach(HPC)
par(mfrow=c(2,2))
plot(Datetimes, Global_active_power,type = "l", xlab = "")
plot(Datetimes, Voltage, type = "l", xlab = "datetime")
plot(Datetimes, Sub_metering_1, type = "l", col = "black", xlab = "", ylab= "Energy Sub Metering")
lines(Datetimes, Sub_metering_2, type = "l", col = "red", xlab = "")
lines(Datetimes, Sub_metering_3, type = "l", col = "blue", xlab = "")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
plot(Datetimes, Global_reactive_power, type = "l", xlab = "datetime")
detach(HPC)
dev.off()
