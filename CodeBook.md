# **Getting and Cleaning Data - A Coursera Project**

By Alexi Erlyn Carlos


### Description
A full description of the process of getting and cleaning data used in this project is contained here.
Data and variables from the source file are also discussed.



### Source File

Data for this project are contained in this link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, 
entitled *Human Activity Recognition Using Smartphones Data Set.*

The data contained herein are from the recordings of 30 subjects performing activities of daily living while 
carrying a waist-mounted smartphone with embedded tri-axial accelerometers and tri-axial gyroscopes.

### Variables
- **Subject** - each of the 30 volunteers were given an ID, some of whom are test subjects and some are training subjects
- **Activity** - 6 different activities were performed by each subject: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
- **Features** - accelerometer and gyroscope measurements from the subjects on a given activity

### Process used in the R Script for Getting and Cleaning Data
#### STEP 0: Download, unzip, and read data files from the source file.
- Download zipped file from the given link, if not yet downloaded
- Unzip the file if data directory does not exist yet
- Read the data from the unzipped file separately into the variables mentioned above, distinguishing between test and train  
    - Y_test.txt
    - Y_train.txt
    - subject_train.txt 
    - subject_test.txt
    - X_test.txt
    - X_train.txt
- Files from the Inertial Signals folder are ignored

#### STEP 1: Merges the training and the test sets to create one data set.
- Concatenate the Train and Test data tables by rows. Now, we only have one data set for each of the three variables
- Set names to variables
- Merge columns of all three variables and label as *Data*

#### STEP 2: Extract only the measurements on the mean and standard deviation for each measurement. 
- Subset name of features by measurements on the mean and standard deviation by using the *grep* command
- Subset the "Data" by selected names of features

#### STEP 3: Use descriptive activity names to name the activities in the data set
- Read *activity_labels.txt* from the unzipped file
- Factorize variable "activity" to "Data" using descriptive activity names 

#### STEP 4: Appropriately label the data set with descriptive activity names.
- In the former part, variables "activity" and "subject" and names of the activities have been labelled 
using descriptive names.
- In this part, Names of Features will labelled using descriptive variable names.
- Use the *gsub* function for replacement 

#### STEP 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject
- Create data set *Data2* using the above requirement
- Create a text file labeled tidydata.txt 

### Output File
The R script discussed above returns a clean data set labelled *tidydata.txt*

