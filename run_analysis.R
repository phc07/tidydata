##Assume source data (all text files) are downloaded and stored in the same folder of this script
##Folder structure and location of files is illustrated as below
##   run_analysis.R
##  >UCI HAR Dataset
##     activity_labels.txt
##     features.info.txt
##     features.txt
##     >test
##        subject_test.txt
##        X_test.txt
##        y_test.txt
##     >train
##        subject_train.txt
##        X_train.txt
##        y_train.txt

library(reshape2)

## Read activity labels and features
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")
## Turn the columns to character
activityLabels[,2] <- as.character(activityLabels[,2])
features[,2] <- as.character(features[,2])

## Read only mean and standard deviation
featuresKept <- grep(".*mean.*|.*std.*", features[,2])

train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresKept]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresKept]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

## combine training and test data, then add column names
## turn the column names into more standard format
featuresKept.names <- features[featuresKept,2]
featuresKept.names = gsub('-mean', 'Mean', featuresKept.names)
featuresKept.names = gsub('-std', 'Std', featuresKept.names)
featuresKept.names <- gsub('[-()]', '', featuresKept.names)

tData <- rbind(train, test)
colnames(tData) <- c("subject", "activity", featuresKept.names)

## turn activities & subjects into factors
tData$activity <- factor(tData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
tData$subject <- as.factor(tData$subject)

tData.melted <- melt(tData, id = c("subject", "activity"))
tData.mean <- dcast(tData.melted, subject + activity ~ variable, mean)

## export result to a text file
write.table(tData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)