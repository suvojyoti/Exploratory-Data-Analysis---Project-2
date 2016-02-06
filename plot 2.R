# Plot2
#========
# Week 1 Assignment

#Select datafile
File <- "household_power_consumption.txt"
# Load into table
power <- read.table(File, header=TRUE, sep=";", stringsAsFactors=FALSE)
# Take subset on dates
data <- power[power$Date %in% c("1/2/2007","2/2/2007") ,]
# Convert global active power as numeric
GAP <- as.numeric(data$Global_active_power)

#convert date and time to corresponding classes and merge
dt <- strptime(paste(data$Date, data$Time, sep=" "), 
               "%d/%m/%Y %H:%M:%S") 

# Set png 
png("plot2.png", width=480, height=480)
# Plot
plot(dt,GAP, type="l", 
    xlab = "",
        ylab="Global Active Power (kilowatts)")
dev.off()





















