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
#par(mfrow=c(2,2), mar=c(4,4,2,2), oma=c(0,0,1,0))
par(mfrow=c(2,2), mar=c(4,4,2,2))
# Plot 1
plot(hpc$DateTime, hpc$Global_active_power, type="l", ylab="Global Active Power (killowats)", xlab="")

# Plot 2
plot(hpc$DateTime, hpc$Voltage, type="l", ylab="Voltage", xlab="")

# Plot 3
plot(hpc$DateTime, hpc$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(hpc$DateTime, hpc$Sub_metering_2, type="l", col="red")
lines(hpc$DateTime, hpc$Sub_metering_3, type="l", col="blue")
legend("topright",                                       # Add legend to plot
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1, lwd=1, y.intersp=0.5, cex=0.6)

#Plot 4
plot(hpc$DateTime, hpc$Global_reactive_power, type="l", ylab="Global_Reactive_Power", xlab="")

dev.print(png, file = "plot4.png", width = 480, height = 480)
dev.off()