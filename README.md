# Getting and Cleaning Data Course Project

The goal of this project is to prepare tidy data that can be used for later analysis. The data is from the Human Activity Recognition Using Smartphones Data Set contained in the UCI Machine Learning Repository. A full description of the data set is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.


## Usage

The R script called `run_analysis.R` downloads the data set into a temporary directory and then does the following:

1) Merges the training and the test sets to create one data set.  
2) Extracts only the measurements on the mean and standard deviation for each measurement.  
3) Uses descriptive activity names to name the activities in the data set.  
4) Appropriately labels the data set with descriptive variable names.  
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

The resulting data set is stored in the file tidy_data.txt.

## CodeBook

Additional information about the transformations performed, variables and data is available in the CodeBook.MD file.
