# 1. Have total emissions from PM2.5 decreased in the 
# United States from 1999 to 2008? Using the base plotting 
# system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.
#-------------------------------------------------------------

# Extract zipped file
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
f<-download.file(url,destfile = "f.zip", mode = "wb")
# Unzip and load
unzip("f.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Install required packages
library(dplyr)
library(plyr)

# Add emmissions over the years
sumNEI = ddply(NEI, .(year), 
               function(d) sum(d[,"Emissions"]))
# Convert emmission to Ktons
sumNEI$V1<-sumNEI$V1/1000

# Create png file
png(filename = "Plot1.png",
    width = 1200, height = 720)
# Plot
plot(sumNEI$year,sumNEI$V1,col="blue",type = "b",
     main = "Total PM2.5 emissions over the years",
     xlab="Year", ylab = "Total Emissions in Kilotons")

dev.off()
