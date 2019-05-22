library(tidyverse)
library(data.table)
file.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file.dest <- "ExData.zip"
zip.dir <- "/ExData"
download.file(file.url, file.dest)
unzip(file.dest, exdir = zip.dir)
HPC <- fread(paste(zip.dir, dir(zip.dir)[[1]], sep = "/"))
HPC$Datetime <- paste(HPC$Date, HPC$Time) %>%
  strptime(format = "%d/%m/%Y %T")
HPC$Date <- HPC[, Date] %>%
  as.Date(format = "%d/%m/%Y")
HPC <- HPC[Date == "2007-02-01" | Date == "2007-02-02"]
HPC$Global_active_power<- as.numeric(HPC[,Global_active_power])


#plot1
hist(HPC[,Global_active_power], col = "red")
