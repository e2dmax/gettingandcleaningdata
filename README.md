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

#### Script Process
1. Merges the training and the test sets into one data set
2. Extracts only the measurements on the mean and standard deviation for each measurement
3. Replaces the activity ID with the descriptive activity names
4. Adds labels to the data set columns with names describing the variables
5. Then it uses the meraged data set and creates a second, independent tidy data set with the average of each variable for each activity and each subject.
