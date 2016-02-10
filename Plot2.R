setwd("D:/Personal/Data Science/Courses/Coursera Data Science/Exploratory Data Analysis/Course Project2")

url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
f<-download.file(url,destfile = "f.zip", mode = "wb")
unzip("f.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Install required packages
library(dplyr)
library(plyr)

# 2.Have total emissions from PM2.5 decreased in the 
# Baltimore City, Maryland (fips == "24510") from 1999 
# to 2008? Use the base plotting system to make a plot
# answering this question.
#------------------------------------------------------
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

# Add emmissions over the years and the fips
fipsNEI = ddply(NEI, .(fips,year), 
                function(d) sum(d[,"Emissions"]))
# Filter only Baltimore Data
baltNEI<-filter(fipsNEI,fipsNEI$fips=="24510")
# Convert to Kilotons
baltNEI$V1<-baltNEI$V1/1000

# Define png file
png(filename = "Plot2.png",
    width = 1200, height = 720)

plot(baltNEI$year,baltNEI$V1,col="green",type = "b",
     main = "Total PM2.5 emissions over the years for Baltimore",
     xlab="Year", ylab = "Total Emissions in Baltimore in Kilotons")
dev.off()
