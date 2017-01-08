## -------------------------------------------
##
## Created by: Max
## Created date: 08/01/2016
## Description: Getting and Cleaning Data Course Project
##
## -------------------------------------------

# Clean and load libraries
rm(list=ls())
library(plyr)


# Variables
url       <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile  <- "./data.zip"


# Download the archive as data source and make it ready for use
if (!file.exists(zipFile)){
    download.file(url, destfile = zipFile)
}  
if (!file.exists("UCI HAR Dataset")) { 
    unzip(zipFile)
}

# 1. Merges the training and the test sets to create one data set
features <- read.table("./UCI HAR Dataset/features.txt")

# Combine the 3 train files and clean the column names of each first (column names of x id inside features.txt)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(subject_train) <- "subjectid"
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
names(x_train) <- features$V2
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
names(y_train) <- "activity"
data_train <- cbind(subject_train, y_train, x_train)

# Combine the 3 test files and clean the column names of each first (column names of x id inside features.txt)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(subject_test) <- "subjectid"
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
names(x_test) <- features$V2
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
names(y_test) <- "activity"
data_test <- cbind(subject_test, y_test, x_test)

#combine the 2 dataset test and train in only 1
mydata <- rbind(data_train, data_test)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement
mean_std_features <- grepl("(mean|std)\\(\\)", names(mydata))
mean_std_features[1:2] <- TRUE # to keep the column from subject & y

# Copy only the required columns to a new data set
mydata2 <- mydata[, mean_std_features]


# 3. Uses descriptive activity names to name the activities in the data set
mydata2$activity <- factor(mydata2$activity, labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))


# 4. Appropriately labels the data set with descriptive variable names.
names(mydata2) <- gsub("^t", "Time", names(mydata2))
names(mydata2) <- gsub("^f", "Frequency", names(mydata2))
names(mydata2) <- gsub("Gyro", "Gyroscope", names(mydata2))
names(mydata2) <- gsub("BodyBody", "Body", names(mydata2))
names(mydata2) <- gsub("-mean\\(\\)", "Mean", names(mydata2))
names(mydata2) <- gsub("-std\\(\\)", "StandardDeviation", names(mydata2))
names(mydata2) <- gsub("-", "", names(mydata2))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
avg_data <- ddply(mydata2, .(subjectid, activity), function(x) colMeans(x[, -c(1, 2)]))
write.table(avg_data, "avg_data.txt", row.name = FALSE)


## End
