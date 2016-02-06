# Plot4
#========
# Week 1 Assignment

#Select datafile
File <- "household_power_consumption.txt"
# Load into table
power <- read.table(File, header=TRUE, sep=";", stringsAsFactors=FALSE)
# Take subset on dates
dat <- power[power$Date %in% c("1/2/2007","2/2/2007") ,]

# Convert global active power as numeric
GAP <- as.numeric(dat$Global_active_power)

# Convert global active power as numeric
GRP <- as.numeric(dat$Global_reactive_power)

# Convert voltage as numeric
VLT <- as.numeric(dat$Voltage)

# Convert sub metering as numeric
sm1 <- as.numeric(dat$Sub_metering_1)
sm2 <- as.numeric(dat$Sub_metering_2)
sm3 <- as.numeric(dat$Sub_metering_3)

# Set png
png("plot4.png", width=480, height=480)
# Set par
par(mfrow=c(2,2),mar=c(4,2,2,1))


# Plot graph1 of global active power(i.e., at postition (1,1))
plot(dt,GAP, type="l", 
     xlab = "",
     ylab="Global Active Power")
# Plot graph2 of voltage(1.e, position (1,2))
plot(dt,VLT, type="l",
     xlab = "datetime",
     ylab="Voltage")

# Plot graph3 of submitering(i.e, position (2,1))
plot(dt, sm1, type="l", ylab="Energy Submetering", xlab="")
# Then add lines of submitering 2 and sub metering 3
lines(dt, sm2, type="l", col="red")
lines(dt, sm3, type="l", col="blue")
# Draw legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       #fill=1:6,
       cex = .6,
     # bty = "o",
       lty=, lwd=.25, col=c("black", "red", "blue"))

# Plot graph4 of global reactive power(i.e, position (2,2))
plot(dt,GRP, type="l", 
     xlab = "datetime",
     ylab="Global_reactive_power")

dev.off()












