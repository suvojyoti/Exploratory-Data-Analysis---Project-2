# Week 4 Course Project
#=======================

# Load dplyr package
library(dplyr)
download.file("https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip", 
              "d.zip", mode = "wb")
unzip("d.zip")
file.remove("d.zip")
# Set working directory
setwd("D:/Personal/Data Science/Courses/Coursera Data Science/Getting and Cleaning Data/data/UCI HAR Dataset")

# Read activity labels
temp1<-read.table("activity_labels.txt",sep = "")
# factorize to add activities later
activity_labels<-as.character(temp1$V2)

# Read features
temp2<-read.table("features.txt",sep = "")
features<-temp2$V2

# Read training Data
x_train<-read.table("train/X_train.txt",sep="")
names(x_train)<-features
# Read activity labels of training data
y_train<-read.table("train/y_train.txt",sep = "")
names(y_train)<-"Activity"
y_train$Activity<-as.factor(y_train$Activity)
# Assign levels
levels(y_train$Activity)<-activity_labels

# Read subjects
trainSubj = read.table("train/subject_train.txt", sep = "")
names(trainSubj) = "subject"
trainSubj$subject = as.factor(trainSubj$subject)
# Combine data for measurements, subject and activity
trainSet = cbind(x_train, trainSubj, y_train)

#====================================
# Read testing Data
x_test<-read.table("test/X_test.txt",sep="")
names(x_test)<-features
# Read activity labels of testing data
y_test<-read.table("test/y_test.txt",sep = "")
names(y_test)<-"Activity"
y_test$Activity<-as.factor(y_test$Activity)
# Assign levels
levels(y_test$Activity)<-activity_labels

# Read subjects
testSubj = read.table("test/subject_test.txt", sep = "")
names(testSubj) = "subject"
testSubj$subject = as.factor(testSubj$subject)
# Combine data for measurements, subject and activity
testSet = cbind(x_test, testSubj, y_test)

# create total data set
dataSet<-rbind(trainSet,testSet)

# Extract only measures of mean and std
# Select mean columns 
means<-dataSet[,grepl("mean()",names(dataSet))]
# Select std columns 
stds<-dataSet[,grepl("std()",names(dataSet))]
# Select Activity and subject
# and
# Bind both data
dimensions<-dataSet[,c("Activity","subject")]
workData<-cbind(dimensions,means,stds)

# Take average
# First select the measures for which average has to be taken
measures<-cbind(means,stds)
# Convert the activity and subject to characters from levels
workData$Activity<-as.character(workData$Activity)
workData$subject<-as.character(workData$subject)

# Then take mean on the measures, grouped by subject and activity
# Take ddply fuction from plyr package
library(plyr)
summaryData = ddply(workData, .(subject, Activity), 
                    function(d) colMeans(d[,-(1:2)]))
# Clean the attribute names, remove "()",
# substitute "-" by "_" and remove repeatative names
names(summaryData)<-sub("\\(\\)", "",names(summaryData))
names(summaryData)<-sub("-", "_",names(summaryData))
names(summaryData)<-sub("BodyBody", "Body",names(summaryData))

# Write data into a text file
write.table(summaryData,file = "Summary.txt",row.names = F,quote = F)
