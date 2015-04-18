## Merge training and test data sets 
tData <- read.table("/data/train/X_train.txt")
## retrieve/set dim for tData using dim()
dim(tData) 
## return first part of data frame tData
head(tData)
tLbl <- read.table("/data/train/y_train.txt")
table(tLbl)
tSubject <- read.table("/data/train/subject_train.txt")
testData <- read.table("/data/test/X_test.txt")
dim(testData) 
testLabel <- read.table("/data/test/y_test.txt") 
table(testLabel) 
testSubject <- read.table("/data/test/subject_test.txt")
joinData <- rbind(tData, testData)
dim(joinData) 
joinLabel <- rbind(tLbl, testLabel)
dim(joinLabel) 
joinSubject <- rbind(tSubject, testSubject)
dim(joinSubject)

## Pull just measurement on the mean & std dev for each
features <- read.table("/data/features.txt")
dim(features)  
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanStdIndices)
joinData <- joinData[, meanStdIndices]
dim(joinData) 
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) 
names(joinData) <- gsub("mean", "Mean", names(joinData)) 
names(joinData) <- gsub("std", "Std", names(joinData)) 
names(joinData) <- gsub("-", "", names(joinData))  

## name desc actvty names 
activity <- read.table("/data/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"

names(joinSubject) <- "subject"
cleanedData <- cbind(joinSubject, joinLabel, joinData)
dim(cleanedData) 
write.table(cleanedData, "merged_data.txt") 

subjectLen <- length(table(joinSubject)) 
activityLen <- dim(activity)[1] 
columnLen <- dim(cleanedData)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLen) {
  for(j in 1:activityLen) {
    result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
    result[row, 2] <- activity[j, 2]
    bool1 <- i == cleanedData$subject
    bool2 <- activity[j, 2] == cleanedData$activity
    result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
    row <- row + 1
  }
}
head(result)
write.table(result, "data_with_means.txt") 
source("run_analysis.R")
data <- read.table("data_with_means.txt")
data[1:12, 1:13]
setpwd("/data")
setwd("/data")
