# Check if the file already exists. If not then create a directory, download file and unzip
if (!file.exists("data/ExData_Plotting1/household_power_consumption.txt")) {
   WD <- getwd()
   if(!file.exists("data/ExData_Plotting1")) {
      dir.create("data/ExData_Plotting1")
   }
   else {
      setwd("data/ExData_Plotting1")
   }   
   fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip"
   datafile <- download.file(fileUrl, destfile="power.zip")
   unzip("power.zip")
   setwd(WD)
}

# Read file
data <- read.csv("data/ExData_Plotting1/household_power_consumption.txt", header=TRUE, na.strings="?", sep=";", stringsAsFactors = FALSE)
# subset the dates we need
reqDates <- data$Date == "1/2/2007" | data$Date == "2/2/2007"
data <- data[reqDates,]
# Convert first two columns into date & time
datetimetemp <- paste(data$Date,data$Time)
datetime <- strptime(datetimetemp,"%d/%m/%Y %H:%M:%S")


# create plots in png
png(filename = "data/ExData_Plotting1/plot4.png", width = 480, height = 480)

# fit 2 * 2 plots
par(mfrow=c(2,2))

# 1st plot
plot(x=datetime, y=data$Global_active_power, type="l", ylab="Global Active Power", xlab="")

# 2nd plot
plot(x=datetime, y=data$Voltage, type="l", ylab="Energy sub metering")

# 3rd plot
plot(x=datetime, y=data$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(datetime, data$Sub_metering_2, col="red")
lines(datetime, data$Sub_metering_3, col="blue")
legend("topright", legend=names(data)[7:9], col=c("black", "red", "blue"), lwd=1, bty="n")

# 4th plot
plot(x=datetime, y=data$Global_reactive_power, type="l", ylab="Global_reactive_power")

dev.off()
