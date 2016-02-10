# 4. Across the United States, how have emissions from coal 
# combustion-related sources changed from 1999-2008?
#-------------------------------------------------------
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
library(ggplot2)

# Find the source classification codes which relate to 
# coal combustion
coalSCC<-grepl("[Cc]oal .+ [Cc]ombustion",SCC$Short.Name)
# Filter those classification codes only
cSCC<-SCC[coalSCC,][,c("SCC","Short.Name")]
# Merge the measurement data for these codes only
dataFrame<-merge(NEI,cSCC,by.x = "SCC",by.y = "SCC")
# Sum up the emmission for coal combustion related sources
# over the years
coalNEI<-ddply(dataFrame, .(SCC,year), 
               function(d) sum(d[,"Emissions"]))
# Arrange the data by source code and year
coalNEI<-arrange(coalNEI,SCC,year)
# Rename for plotting
names(coalNEI)<-c("CoalEmmissionType","Year","EmissioninTons")
# Define png file
png(filename = "Plot4.png",
    width = 1200, height = 720)
# Plot
qplot(Year,EmissioninTons,data=coalNEI,
      color=CoalEmmissionType,
      facets = .~CoalEmmissionType,
      geom=(c("point","smooth")))
dev.off()