# Check if dplyr package is installed
require("dplyr")

# Verify all the needed files are present
if(!file.exists("UCI HAR Dataset/train/X_train.txt")){
  return("ERROR: Could not find file 'UCI HAR Dataset/train/X_train.txt' in working directory")
}
if(!file.exists("UCI HAR Dataset/train/y_train.txt")){
  return("ERROR: Could not find file 'UCI HAR Dataset/train/y_train.txt' in working directory")
}
if(!file.exists("UCI HAR Dataset/train/subject_train.txt")){
  return("ERROR: Could not find file 'UCI HAR Dataset/train/subject_train.txt' in working directory")
}
if(!file.exists("UCI HAR Dataset/test/X_test.txt")){
  return("ERROR: Could not find file 'UCI HAR Dataset/test/X_test.txt' in working directory")
}
if(!file.exists("UCI HAR Dataset/test/y_test.txt")){
  return("ERROR: Could not find file 'UCI HAR Dataset/train/y_test.txt' in working directory")
}
if(!file.exists("UCI HAR Dataset/test/subject_test.txt")){
  return("ERROR: Could not find file 'UCI HAR Dataset/test/subject_test.txt' in working directory")
}
if(!file.exists("UCI HAR Dataset/features.txt")){
  return("ERROR: Could not find file 'UCI HAR Dataset/features.txt' in working directory")
}
if(!file.exists("UCI HAR Dataset/activity_labels.txt")){
  return("ERROR: Could not find file 'UCI HAR Dataset/activity_labels.txt' in working directory")
}

# **************************************************************************************
# cleantable()
# Function that takes one of the original data sets along with variable, activity, and
# subject information. It first properly labels the variable columns.  It then trims
# the data set down to only the mean and standard deviation values. After that is
# complete it then merges the subject and activity information.

# baseData - A data set containing either the training and test data
# subjects - A data set containing the corresponding test subjects
# activitydata - A data set containing the corresponding test activities
# lbl_column - data set containing the variable names to label the columns
# lbl_activity - data set containing the activity labels
# **************************************************************************************

cleantable <- function(baseData, subjects, activitydata, lbl_column, lbl_activity){
  # Label the columns in that activity label data set to make it easier to merge
  colnames(lbl_activity) <- c("AID", "Activity")
  
  colnames(baseData) <- lbl_column[,2] # Add column labels to the data set
  
  # trim the data set variables down to just mean and standard deviation values
  trimmedData <- baseData[,grep("(.[Mm][Ee][Aa][Nn].*[(][)].)|(.[Ss][Tt][Dd].*[(][)].)", lbl_column[,2])]
  
  trimmedData$AID <- activitydata[,1] # Add the activity data
  
  trimmedData$Subject <- subjects[,1] # Add the subject data
  
  # Merge the activity labels using a outer left join on AID
  cleanData <- merge(lbl_activity, trimmedData, by = "AID", all.x =TRUE)
  
  # Remove the AID column because it is no longer needed
  cleanData <- subset(cleanData, select=-c(AID))
  
  # Reorder the columns so that the first two are Subject and Activity
  cleanData <- cleanData[c(59,1:ncol(cleanData)-1)]
  
  return(cleanData)
}

columnheader <- read.table("UCI HAR Dataset/features.txt", header = FALSE) # Read in column headers
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE) # Read in activity labels

trainData <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE) # Read in training data set
trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE) # Read in training activities
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE) # Read in training subjects

# Pass data to cleantable function to get a trimmed and cleaned training data set
cleanTrain <- cleantable(trainData, trainSubjects, trainActivities, columnheader, activitylabels)
rm(list = c("trainData", "trainActivities", "trainSubjects")) # Remove variables that are no longer needed

testData <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE) # Read in test data set
testActivities <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE) # Read in test activities
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE) # Read in test subjects

# Pass data to cleantable function to get a trimmed and cleaned test data set
cleanTest <- cleantable(testData, testSubjects, testActivities, columnheader, activitylabels)
# Remove variables that are no longer needed
rm(list = c("testData", "testActivities", "testSubjects", "columnheader", "activitylabels", "cleantable"))

# Merge the cleaned training and test data sets together
cleanedData <- rbind(cleanTrain, cleanTest)
# Reorder the merged data set rows by subject and Activity
cleanedData <- arrange(cleanedData, Subject, Activity)
# Write the cleanded data set out to a file
write.table(cleanedData, file = "cleanedData.txt", row.names = FALSE)

# Remove variables that are no longer needed
rm(list = c("cleanTrain", "cleanTest"))

# Create a new data set that contains the average for each variable by each Subject and Activity pair
averagedData <- cleanedData %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))

# Write the averaged data set out to a file
write.table(averagedData, file = "averagedData.txt", row.names = FALSE)
