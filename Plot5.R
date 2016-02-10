# 5. How have emissions from motor vehicle sources 
# changed from 1999-2008 in Baltimore City?
#-------------------------------------------------
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
f<-download.file(url,destfile = "f.zip", mode = "wb")
# Unzip and load
unzip("f.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Install required packages
library(dplyr)
library(plyr)
library(ggplot2)
# Find the source classification codes which relate to 
# motor vehicles
motvSCC<-grepl("[Mm]otor [Vv]ehicle[s]+ ",SCC$Short.Name)
# Filter those classification codes only
mSCC<-as.character(SCC[motvSCC,][,c("SCC","Short.Name")])
baltNEI<-filter(NEI,NEI$fips=="24510")
# Merge the measurement data for these codes only
dataFrame<-merge(baltNEI,mSCC)
# Sum up the emmission 
# over the years
bNEI<-ddply(dataFrame, .(year), 
            function(d) sum(d[,"Emissions"]))
# Define png file
png(filename = "Plot5.png",
    width = 1200, height = 720)
# plot
plot(bNEI$year,bNEI$V1,col="red",type = "b",
     main = "Total PM2.5 emissions over 
     the years for motor vehicles in Baltimore",
     xlab="Year", ylab = "Total Emissions in tons")

dev.off()

