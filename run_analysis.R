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

cleantable <- function(baseData, subjects, activitydata, lbl_column, lbl_activity){
  lbl_column <- lbl_column[,2]
  colnames(lbl_activity) <- c("AID", "Activity")
  colnames(baseData) <- lbl_column
  trimmedData <- baseData[,grep("(.[Mm][Ee][Aa][Nn].*[(][)].)|(.[Ss][Tt][Dd].*[(][)].)", lbl_column)]
  trimmedData$AID <- activitydata[,1]
  trimmedData$Subject <- subjects[,1]
  cleanData <- merge(lbl_activity, trimmedData, by = "AID", all.x =TRUE)
  cleanData <- subset(cleanData, select=-c(AID))
  cleanData <- cleanData[c(59,1:ncol(cleanData)-1)]
  return(cleanData)
}

columnheader <- read.table("UCI HAR Dataset/features.txt", header = FALSE)
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

trainData <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)

cleanTrain <- cleantable(trainData, trainSubjects, trainActivities, columnheader, activitylabels)
rm(list = c("trainData", "trainActivities", "trainSubjects"))

testData <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
testActivities <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)

cleanTest <- cleantable(testData, testSubjects, testActivities, columnheader, activitylabels)
rm(list = c("testData", "testActivities", "testSubjects", "columnheader", "activitylabels", "cleantable"))

cleanedData <- rbind(cleanTrain, cleanTest)
cleanedData <- arrange(cleanedData, Subject, Activity)

rm(list = c("cleanTrain", "cleanTest"))

summarizedData <- cleanedData %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))
