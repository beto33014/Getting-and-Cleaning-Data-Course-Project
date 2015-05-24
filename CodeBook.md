# Getting-and-Cleaning-Data-Course-Project
Within this repository there is a r script (run_analysis.R) that uses accelerometer data from Samsung Galaxy S smartphones. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The r script run_analysis.R processes the accelerometer data using the following steps to produce an aggregated, clean dataset:
* Merge datasets (training and the test) to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Add descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* Create a tidy data set with the average of each variable for each activity and each subject.

The ouput from the r script is a comma delimited text file (aggData.txt) with the average of each variable for each activity and each subject.  Additionally enclosed in this repository is a codebook (CodeBook.md) that describes the variables, the data, and transformations performed to clean up the data.

