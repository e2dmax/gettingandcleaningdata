The run_analysis.R script takes several of the original data files from the data set at the below URL and creates a two new data sets.
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#New Data Sets
* __cleanedData__ - data set contains the merged mean and standard deviation data from the original train and test data sets.
* __averagedData__ - data set with the average of each variable for each activity and each subject in the cleanedData data set. 

#Transforms
These are the transforms that the run_analysis.R script performs on the original data files to create the two new data sets.

1. Reads in the features.txt file to get the variable names
2. Reads in the activity_labels.txt to get the activity ID to activity name information
3. Reads in the X_train.txt file to get the training data
4. Reads in the y_train.txt file to get the corresponding training data activities
5. Reads in the subject_test.txt file to get the corresponding test subjects
6. 

