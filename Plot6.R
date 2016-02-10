#6. Compare emissions from motor vehicle sources in 
# Baltimore City with emissions from motor vehicle 
# sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?
#---------------------------------------------------------------------------

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
# Filter Baltimore and California data in
# two different data sets
caliNEI<-filter(NEI,fips=="06037")
baltNEI<-filter(NEI,fips=="24510")
# Find the source classification codes which relate to 
# motor vehicles
motvSCC<-grepl("[Mm]otor [Vv]ehicle[s]+ ",SCC$Short.Name)
# Filter those classification codes only
mSCC<-as.character(SCC[motvSCC,][,c("SCC","Short.Name")])
# Merge data with SCC codes
caliData<-merge(caliNEI,mSCC)
baltData<-merge(baltNEI,mSCC)
# Create City column for grouping and plotting
City<-rep("California",nrow(caliData))
caliData<-cbind(caliData,City)
City<-rep("Baltimore",nrow(baltData))
baltData<-cbind(baltData,City)
# Merge both datasets of Baltimore and California
dataFrame<-rbind(caliData,baltData)
# Sum up emmission on city and year
dataFrame<-ddply(dataFrame, .(City,year), 
                 function(d) sum(d[,"Emissions"]))
# Creat png file
png(filename = "Plot6.png",
    width = 1200, height = 720)
# Plot
qplot(dataFrame$year,dataFrame$V1,color=dataFrame$City,
      geom=c("point","path"))
dev.off()

