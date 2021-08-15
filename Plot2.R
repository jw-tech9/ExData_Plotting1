library(chron)
# 
# Download and unzip files
# 
filename <- "Electric_power_consumption.zip"
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, method="curl")
}  
unzip(filename) 

#
# Read Data
# filter out only the records with dates of interest
#
hpc_full <- read.table("household_power_consumption.txt", header=TRUE, na.strings="?", sep=";")
hpc_full$Date <- as.Date(hpc_full$Date, "%d/%m/%Y")
hpc <- hpc_full[(hpc_full$Date == "2007-02-01" | hpc_full$Date == "2007-02-02"),]
#
# Convert Date Time columns
#hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")
dt <- paste(hpc$Date, hpc$Time)
hpc$DateTime <- as.POSIXct(dt)
#
# plot 
#
plot(hpc$DateTime, hpc$Global_active_power, type="l", ylab="Global Active Power (killowats)", xlab="")
dev.print(png, file = "plot2.png", width = 480, height = 480)
dev.off()