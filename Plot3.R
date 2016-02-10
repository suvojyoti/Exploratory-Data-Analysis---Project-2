# 3. Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, which of 
# these four sources have seen decreases in emissions
# from 1999-2008 for Baltimore City? Which have seen 
# increases in emissions from 1999-2008? Use the 
# ggplot2 plotting system to make a plot answer this question.
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
library(ggplot2)

# Add emmissions over the fips, years and the types
fipsNEI <- ddply(NEI, .(fips,year,type), 
                 function(d) sum(d[,"Emissions"]))
# Filter out Baltimore data
baltNEI<-filter(fipsNEI,fipsNEI$fips=="24510")
# Convert to ktons
baltNEI$V1<-baltNEI$V1/1000
names(baltNEI)<-c("fips","year","type","emission")
# Define png file
png(filename = "Plot3.png",
    width = 1200, height = 720)
# Plot
qplot(year,emission,data=baltNEI,facets = .~type)
dev.off()

#-----------
# Conclusion
#-----------
# So, the result shows that except POINT type, all others
# has seen decrease in emissions

