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

png(filename = "plot2.png", width = 480, height = 480)
plot(HPC$Datetimes, HPC$Global_active_power,type = "l", xlab = "")
dev.off()
