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
#
hpc_full <- read.table("household_power_consumption.txt", header=TRUE, na.strings="?", sep=";")
#
# Convert Date Time columns
hpc_full$Date <- as.Date(hpc_full$Date, "%d/%m/%Y")
#hpc$Time <- strptime(hpc$Time, "%H:%M:%S")
#hpc$Time <- times(hpc$Time)

#
# filter out only the records with dates of interest
hpc <- hpc_full[(hpc_full$Date == "2007-02-01" | hpc_full$Date == "2007-02-02"),]
#
# plot histogram
#
hist(hpc$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (killowats)", ylab="Frequency")
dev.print(png, file = "plot1.png", width = 480, height = 480)
dev.off()