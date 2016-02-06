# Plot1
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

# Set png 
png("plot1.png", width=480, height=480)
# Plot
hist(GAP, col="red", 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off()





















