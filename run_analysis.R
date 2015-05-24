library(data.table)
library(gdata)
library(plyr)

##data of different activities (e.g. walking, sitting...)
activityLabels<-read.table("activity_labels.txt")

##data with column headings for the main datasets
featuresCollabels<-read.table("features.txt")

####TRAINING DATA####
##data containing main dataset (dims: 7532 rows, 561 cols)
valsTrain<-read.table("C:\\Users\\Beto\\Desktop\\courseProject\\UCI HAR Dataset\\train\\X_train.txt")

#data with ids of subject in study
subjectTrain<-read.table("C:\\Users\\Beto\\Desktop\\courseProject\\UCI HAR Dataset\\train\\subject_train.txt")

##data with activity being performed by subjects
activityTrain<-read.table("C:\\Users\\Beto\\Desktop\\courseProject\\UCI HAR Dataset\\train\\y_train.txt")

##Assemble train data frame
##rename columns of main dataset
setnames(valsTrain, old = 1:561, new = (as.character(featuresCollabels[[2]])))

##add column to main dataset indentifying each person/subject in study
valsTrain$subject<-subjectTrain$V1

##add column to main dataset indicating activity performed as an ID
valsTrain$activityID<-activityTrain$V1

####TEST DATA####
##data containing main dataset (dims: 2947 rows, 561 cols)
valsTest<-read.table("C:\\Users\\Beto\\Desktop\\courseProject\\UCI HAR Dataset\\test\\X_test.txt")

#data with ids of subject in study
subjectTest<-read.table("C:\\Users\\Beto\\Desktop\\courseProject\\UCI HAR Dataset\\test\\subject_test.txt")

##data with activity being performed by subjects
activityTest<-read.table("C:\\Users\\Beto\\Desktop\\courseProject\\UCI HAR Dataset\\test\\y_test.txt")

##Assemble test data frame
##rename columns of main dataset
setnames(valsTest, old = 1:561, new = (as.character(featuresCollabels[[2]])))

##add column to main dataset indentifying each person/subject in study
valsTest$subject<-subjectTest$V1

##add column to main dataset indicating activity performed as an ID
valsTest$activityID<-activityTest$V1

##STEP1: Merge train and test data
allValues<-rbind(valsTest,valsTrain)

##column labels with mean and std values
colLabelsMean<-matchcols(allValues, with=c("mean"))
colLabelsStdev<-matchcols(allValues, with=c("std"))
colLabels<-rbind(colLabelsMean,colLabelsStdev, "subject","activityID")

##STEP2:Extract only the measurements on the mean and stdev for each measurement
allValuesMeanStdev<-allValues[,(names(allValues) %in% colLabels)]

##STEP3 Add descriptive activity names
allValuesMeanStdev$activityName <- "" ## add new empty column for activity names
for (i in 1:length(allValuesMeanStdev[[1]]) ) ##populate activity name column
{
	if (allValuesMeanStdev$activityID[i] == 1)
	{
		allValuesMeanStdev$activityName[i] = "WALKING"
	}
	if (allValuesMeanStdev$activityID[i] == 2)
	{
		allValuesMeanStdev$activityName[i] = "WALKING_UPSTAIRS"
	}
	if (allValuesMeanStdev$activityID[i] == 3)
	{
		allValuesMeanStdev$activityName[i] = "WALKING_DOWNSTAIRS"
	}
	if (allValuesMeanStdev$activityID[i] == 4)
	{
		allValuesMeanStdev$activityName[i] = "SITTING"
	}
	if (allValuesMeanStdev$activityID[i] == 5)
	{
		allValuesMeanStdev$activityName[i] = "STANDING"
	}
	if (allValuesMeanStdev$activityID[i] == 6)
	{
		allValuesMeanStdev$activityName[i] = "LAYING"
	}
}

##Step 4 Add labels the data set with descriptive variable names
names(allValuesMeanStdev)<-gsub("Acc", "Accelerometer", names(allValuesMeanStdev))
names(allValuesMeanStdev)<-gsub("Gyro", "Gyroscope", names(allValuesMeanStdev))
names(allValuesMeanStdev)<-gsub("BodyBody", "Body", names(allValuesMeanStdev))
names(allValuesMeanStdev)<-gsub("Mag", "Magnitude", names(allValuesMeanStdev))

##Step5 Creates a tidy data set with the average of each variable for each activity and each subject
allValuesMeanStdev$subject <- as.factor(allValuesMeanStdev$subject)## make subject into factors
allValuesMeanStdev <- data.table(allValuesMeanStdev)
aggData <- aggregate(. ~subject + activityName, allValuesMeanStdev, mean)
aggData<-aggData[order(aggData$subject),]
write.table(aggData, "aggData.txt", sep=",",row.name=FALSE) 

