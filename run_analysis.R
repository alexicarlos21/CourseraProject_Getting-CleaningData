###################################################################################################
## GETTING AND CLEANING DATA - COURSE PROJECT IN COURSERA							  #	  
## Author: Alexi Carlos		 											  #
## 																  #
## This script does the following: 											  #
##   0) Downloads, unzips, and reads data files from a given link					 	  #
##   1) Merges the training and the test sets to create one data set.					  #
##   2) Extracts only the measurements on the mean and standard deviation for each measurement.   #
##   3) Uses descriptive activity names to name the activities in the data set			  #
##   4) Appropriately labels the data set with descriptive variable names.				  #
##   5) From the data set in step 4, creates a second, independent tidy data set with the 	  #
##	  average of each variable for each activity and each subject.					  #					  
###################################################################################################


###################################################################################################
## OBTAIN DATA
###################################################################################################


# DOWNLOAD ZIPPED DATA IF NOT DOWNLOADED YET
zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- "UCI HAR Dataset.zip"

if (!file.exists(zipFile)) {
  download.file(zipUrl, zipFile, mode = "wb")
}

# UNZIP THE FILE IF DATA DIRECTORY DOES NOT EXIST YET
path_rf <- "UCI HAR Dataset"
if (!file.exists(path_rf)) {
  unzip(zipFile)
}

###################################################################################################
## READ DATA
###################################################################################################

#READ THE ACTIVITY FILES
dataActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)

#READ THE SUBJECT FILES
dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)

#READ THE FEATURES FILES
dataFeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)


###################################################################################################
## STEP 1 : Merge the training and the test sets to create one data set.
###################################################################################################


#CONCATENATE THE DATA TABLES BY ROWS
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)

#SET NAMES TO VARIABLES
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2

#MERGE COLUMNS TO GET THE DATA FRAME "DATA" FOR ALL DATA
dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)

###################################################################################################
## STEP 2 : Extract only the measurements on the mean and standard deviation for each measurement.
###################################################################################################

#SUBSET NAME OF FEATURES BY MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION
subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]


#SUBSET THE DATA FRAME "DATA" BY SELECTED NAMES OF FEATURES
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)



###################################################################################################
## STEP 3 : Use descriptive activity names to name the activities in the data set.
###################################################################################################

#READ DESCRIPTIVE ACTIVITY NAMES FROM "activity_labels.txt"
activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)

#FACTORIZE VARIABLE ACTIVITY IN THE DATA FRAME "DATA" USING DESCRIPTIVE ACTIVITY NAMES
Data$activity<-factor(Data$activity,labels=activityLabels[,2])

###################################################################################################
## STEP 4 : Appropriately label the data set with descriptive variable names.
###################################################################################################

#In the former part, variables "activity" and "subject" and names of the activities have been labelled 
#using descriptive names.
#In this part, Names of Features will labelled using descriptive variable names.

names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

###################################################################################################
## STEP 5 : From the data set in step 4, create a second, independent tidy data set with the 
##           average of each variable for each activity and each subject.
###################################################################################################

#CREATE INDEPENDENT TIDY DATA SET
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)


