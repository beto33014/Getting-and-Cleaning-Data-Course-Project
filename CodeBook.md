# Codebook

This codebook (CodeBook.md) describes the variables, the data, and transformations performed to clean up the data.

Was code book submitted to GitHub that modifies and updates the codebooks available to you with the data to indicate all the variables and summaries you calculated, along with units, and any other relevant information?

##Data
The original accelerometers data from the Samsung Galaxy S smartphones was acquired from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

This data included the following files for a test and training data set:
* activity_labels.txt: data of different activities (e.g. walking, sitting...)
* features.txt: data with column headings for the main datasets (X_train.txt,X_test.txt)
* subject_test.txt: data with ids of subjects in study
* X_test.txt: data containing accelerometers dataset
* y_test.txt: data with activity being performed by subjects
* subject_train.txt: data with ids of subjects in study
* X_train.txt: data containingaccelerometers dataset
* y_train.txt: data with activity being performed by subjects

Accelerometer data comprises triaxial acceleration, triaxial Angular velocity, time and frequency, activity, and an identifier of the subject who carried out the experiment. Features are normalized and bounded within [-1,1] 

##Transformations
Accelerometer data from training and testing phases of the experiment were merged into a single data set.  This data set was subsetted for varibales that measures mean and standard deviations of a variable meaured in the experiment.  Afterwards the average of each substetted variable for each activity and each subject was calculated.

##Variables
The following a r data frames created to clean the accelerometer data:
* valsTrain:
* valsTest
* allValues
* allValuesMeanStdev:
* aggData:

