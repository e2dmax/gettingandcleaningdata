The run_analysis.R script takes several of the original data files from the data set at the below URL and creates two new data sets.

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#Original Data Sets Used
* __activity_labels.txt__ - mapping of Activity ID number to activity name
* __features.txt - variable__ labels used to name the columns in both test and training data sets
* test/__subject_test.txt__ - test subject ID numbers for the test data set
* test/__X_test.txt__ - test data set
* test/__y_test.txt__ - activities for test data set by activity ID number
* train/__subject_train.txt__ - test subject ID numbers for the training data set
* train/__X_train.txt__ - training data set
* train/__y_train.txt__ - activities for training data set by activity ID number

#Output Data Sets
* __cleanedData__ - data set contains the merged mean and standard deviation data from the original train and test data sets.
* __averagedData__ - data set with the average of each variable for each activity and each subject in the cleanedData data set. 

#cleanedData

###Processing Steps
The following process was used to clean, format, and merge the Test and Training data sets into the cleanedData data set

1. Used the data from the features.txt file to label the columns in each data set
2. Trimmed each data set to only the mean and standard deviation variables as specified in the requirements
    * Kept any variable with mean or std in its function name. Requirement was not specific on which mean variables to keep, so all were included.  Exception are ones that are only used in calculating the angle.
3. Joined the corresponding activity data to each data set on the assumption that the data rows were ordered to match
4. Joined the corresponding subject data to each data set on the assumption that the data rows were ordered to match
5. Performed an outer left join by activity ID of each data set with the activity names from the activity_labels.txt file.
6. Removed the activity ID column from the data sets since it was no longer needed
7. Reordered the data sets so that the first two columns were Subject and Activity (not required, but makes it is easier to read)
8. Merged the training and test data sets into the final data set called __cleanedData__
  * It was assumed that a Subject ID number represented the same person between the test and training data sets
9. Wrote out the new data set to __cleanedData.txt__

###Variable Definitions
* __Subject__ - ID number representing a test subject.
* __Activity__ - Physical activity performed by the subject

_As described in the features_info.txt file in the original data set_

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

The set of variables kept in this new data set were estimated from the above described signals are: 

mean(): Mean value

std(): Standard deviation

meanFreq(): Weighted average of the frequency components to obtain a mean frequency

* __tBodyAcc-mean()-X__
* __tBodyAcc-mean()-Y__
* __tBodyAcc-mean()-Z__
* __tBodyAcc-std()-X__
* __tBodyAcc-std()-Y__
* __tBodyAcc-std()-Z__
* __tGravityAcc-mean()-X__
* __tGravityAcc-mean()-Y__
* __tGravityAcc-mean()-Z__
* __tGravityAcc-std()-X__
* __tGravityAcc-std()-Y__
* __tGravityAcc-std()-Z__
* __tBodyAccJerk-mean()-X__
* __tBodyAccJerk-mean()-Y__
* __tBodyAccJerk-mean()-Z__
* __tBodyAccJerk-std()-X__
* __tBodyAccJerk-std()-Y__
* __tBodyAccJerk-std()-Z__
* __tBodyGyro-mean()-X__
* __tBodyGyro-mean()-Y__
* __tBodyGyro-mean()-Z__
* __tBodyGyro-std()-X__
* __tBodyGyro-std()-Y__
* __tBodyGyro-std()-Z__
* __tBodyGyroJerk-mean()-X__
* __tBodyGyroJerk-mean()-Y__
* __tBodyGyroJerk-mean()-Z__
* __tBodyGyroJerk-std()-X__
* __tBodyGyroJerk-std()-Y__
* __tBodyGyroJerk-std()-Z__
* __fBodyAcc-mean()-X__
* __fBodyAcc-mean()-Y__
* __fBodyAcc-mean()-Z__
* __fBodyAcc-std()-X__
* __fBodyAcc-std()-Y__
* __fBodyAcc-std()-Z__
* __fBodyAcc-meanFreq()-X__
* __fBodyAcc-meanFreq()-Y__
* __fBodyAcc-meanFreq()-Z__
* __fBodyAccJerk-mean()-X__
* __fBodyAccJerk-mean()-Y__
* __fBodyAccJerk-mean()-Z__
* __fBodyAccJerk-std()-X__
* __fBodyAccJerk-std()-Y__
* __fBodyAccJerk-std()-Z__
* __fBodyAccJerk-meanFreq()-X__
* __fBodyAccJerk-meanFreq()-Y__
* __fBodyAccJerk-meanFreq()-Z__
* __fBodyGyro-mean()-X__
* __fBodyGyro-mean()-Y__
* __fBodyGyro-mean()-Z__
* __fBodyGyro-std()-X__
* __fBodyGyro-std()-Y__
* __fBodyGyro-std()-Z__
* __fBodyGyro-meanFreq()-X__
* __fBodyGyro-meanFreq()-Y__
* __fBodyGyro-meanFreq()-Z__

#averagedData
###Processing Steps
The following process was used to create the averagedData data set. The requirement was to average each variable on each subject and activity pair.

1. Used the dplyr group_by function to group the __cleanedData__ data set by Subject and Activity
2. Used the dplyr summarise_each function to run the mean function on each grouping
3. The resulting output was stored in __averagedData__
4. Wrote out the new data set to __averagedData.txt__

###Variable Definitions
The varaibles in this data set have the same names as ones in the cleanedData data set, but the values are actually averages of those variables for each Subject and Activity pair.
