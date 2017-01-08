# Getting and Cleaning Data Course Project

## Description
`run_analysis.R`  reconsiliate 2 different sets of data (test and train), clean them with teh right column name. Then perform the mean calculation. 


## Work to do
You should create one R script called run_analysis.R that does the following.

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Useful variables
* data_test: subject_test.txt, X_test.txt and y_test.txt merged in one file. It s important to note that `cbind(subject_test, y_test, x_test)` have y_test them x_test as it will be much easier to manage the 2 first columns at teh beginning than subject at first column and activity (y_test) at the last column.
* data_train; subject_train.txt, X_train.txt and y_train.txt merged in one file. It s important to note that `cbind(subject_train, y_train, x_train)` have y_train them x_train as it will be much easier to manage the 2 first columns at teh beginning than subject at first column and activity (y_train) at the last column.
* my_data: full set of data in 1 table
* my_data2: clean version of my_data
* avg_data: my_data2 with mean version


## Calculations
The main calculation is the average (mean) calculation at the end.
`avg_data <- ddply(mydata2, .(subjectid, activity), function(x) colMeans(x[, -c(1, 2)]))`
teh goal was to exclude the 2 first column and calculate the mean of all the numeric values for each subject and activity.


## Other informations
* The data source come from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

