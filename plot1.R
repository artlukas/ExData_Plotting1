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
# Convert first column into dates
data$Date <- as.Date(data$Date, FUN=strptime, format="%d/%m/%Y")
# create plot in png
png(filename = "data/ExData_Plotting1/plot1.png", width = 480, height = 480)
hist(data$Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")
dev.off()
