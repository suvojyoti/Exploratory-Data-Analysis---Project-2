# Plot3
#========
# Week 1 Assignment

#Select datafile
File <- "household_power_consumption.txt"
# Load into table
power <- read.table(File, header=TRUE, sep=";", stringsAsFactors=FALSE)
# Take subset on dates
dat <- power[power$Date %in% c("1/2/2007","2/2/2007") ,]
# Convert sub metering as numeric
sm1 <- as.numeric(dat$Sub_metering_1)
sm2 <- as.numeric(dat$Sub_metering_2)
sm3 <- as.numeric(dat$Sub_metering_3)
# Set png
png("plot3.png", width=480, height=480)
# First plot submittering 1
plot(dt, sm1, type="l", ylab="Energy Submetering", xlab="")
# Then add lines of submitering 2 and sub metering 3
lines(dt, sm2, type="l", col="red")
lines(dt, sm3, type="l", col="blue")
# Draw legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2, col=c("black", "red", "blue"))
dev.off()


#convert date and time to corresponding classes and merge
dt <- strptime(paste(dat$Date, dat$Time, sep=" "), 
               "%d/%m/%Y %H:%M:%S") 

# Set png 
png("plot2.png", width=480, height=480)
# Plot
plot(dt,GAP, type="l", 
     xlab = "",
     ylab="Global Active Power (kilowatts)")
dev.off()





















