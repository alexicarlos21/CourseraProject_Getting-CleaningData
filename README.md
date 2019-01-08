## **Getting and Cleaning Data - A Coursera Project**

By Alexi Erlyn Carlos


### Overview
This course project from Coursera serves as a demonstration of my ability to collect, work with, and clean a data set.
Contained in this repository are the following:

- `README.md` - provides an overview and summary of the project
- `run_analysis.R`- R script that performs the function of getting and cleaning data
- `tidydata.txt` - output file from the 'run_analysis.R' script, a clean data set.
- `CodeBook.md` - describes the process of getting and cleaning data used in this project

### Project Summary

The R script included here performs the tasks below:

0. Downloads, unzips, and reads data files from a given link (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject - labelled as tidydata.txt. 

### Other Information
For a detailed description of the project and how it was created, kindly refer to CodeBook.md file.
