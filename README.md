# gettingandcleaningdata
Project for Coursera Data Science course on getting and cleaning data.  It contains the following files.

* __run_analysis.R__ - performs the actions below
* __CodeBook.md__ - describes the transforms and data
* __README.md__ - desribes the project files

###run_analysis.R
This is an R script that will take data from 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

It was collected from the accelerometers from a Samsung Galaxy S smartphone while test subjects were performing different physical activities.

The script expects the data to be unzipped in a sub directory of the directory containing the script.  It also expects it to be in the below file structure.  The script does not consume the raw data files, but only the post processed ones that are listed below.

  * run_analysis.R
  * __UCI HAR Dataset__
    * __test__
      * subject_test.txt
      * X_test.txt
      * y_test.txt
    * __training__
      * subject_train.txt
      * X_train.txt
      * y_train.txt
    * activity_labels.txt
    * features.txt

#### Script Process Requirements
1. Merges the training and the test sets into one data set
2. Extracts only the measurements on the mean and standard deviation for each measurement
3. Replaces the activity ID with the descriptive activity names
4. Adds labels to the data set columns with names describing the variables
5. Then it uses the meraged data set and creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#cleanedData
###Processing Steps
The following process was used to clean, format, and merge the Test and Training data sets into the cleanedData data set

1. Used the data from the features.txt file to label the columns in each data set
2. Trimmed each data set to only the mean and standard deviation variables as specified in the requirements
    * Kept any variable with mean or std in its name. Requirement was not specific on which mean variables to keep, so all were included
3. Joined the corresponding activity data to each data set on the assumption that the data rows were ordered to match
4. Joined the corresponding subject data to each data set on the assumption that the data rows were ordered to match
5. Performed an outer left join by activity ID of each data set with the activity names from the activity_labels.txt file.
6. Removed the activity ID column from the data sets since it was no longer needed
7. Reordered the data sets so that the first two columns were Subject and Activity (not required, but makes it is easier to read)
8. Merged the training and test data sets into the final data set called __cleanedData__
  * It was assumed that a Subject ID number represented the same person between the test and training data sets
9. Wrote out the new data set to __cleanedData.txt__

#averagedData
###Processing Steps

The following process was used to create the averagedData data set. The requirement was to average each variable on each subject and activity pair.

1. Used the dplyr group_by function to group the cleanedData data set by Subject and Activity
2. Used the dplyr summarise_each function to run the mean function on each grouping
3. The resulting output was stored in averagedData
4. Wrote out the new data set to averagedData.txt
