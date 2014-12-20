## Getting and Cleaning Data - Course project

## activity_labels.txt: 1 WALKING, etc
## features.txt: 1 tBodyAcc-mean()-X
## features_info.txt: background info
## README.txt: background info
## For test (same for train):
##  subject_test.txt: 0
##  y_test.txt: 5
##  X_test.txt:   2.5717778e-001 -2.3285230e-002 -1.4653762e-002 etc ...

## No need for the inertia folder
## descriptive activity names, eg: Walking

setwd("~/Developer/DataScience/GettingAndCleaningData")

## 1. Merge the training and the test sets to create one data set

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <-read.table("./UCI HAR Dataset/features.txt")

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")

## str(activity_labels) ## 6 possible values and corresponding ID (eg, WALKING)
## str(features) ## 561 possible measurements and corresponding ID (eg, tBodyAcc-mean()-X)
## str(x_test) ## 2947 observations of 561 variables
## str(y_test) ## activity label for each obs. (1:6)
## str(subject_test) ## subject for each obs. (2  4  9 10 12 13 18 20 24)

x_test[,"activity.ID"] <- y_test$V1
x_test[,"subject.ID"] <- subject_test$V1

x_train[,"activity.ID"] <- y_train$V1
x_train[,"subject.ID"] <- subject_train$V1

data <- rbind(x_train, x_test)

## 2. Extract only the measurements on the mean and standard deviation for each measurement
factor_columns <- c("subject.ID", "activity.ID")
reduced_features <- features[grep("mean()|std()",features$V2),] ## get the mean and std labels and their corresponding indices
keep_cols <- paste("V", reduced_features$V1, sep="")
keep_cols <- c(factor_columns, keep_cols)
data <- data[,keep_cols]

## 3. Use descriptive activity names to name the activities in the data set
colnames(activity_labels) <- c("activity.ID", "activity")
merged_data <- merge(activity_labels,data,by.x="activity.ID",by.y="activity.ID", all = FALSE)
merged_data$activity.ID <- NULL
merged_data <- cbind(merged_data$subject.ID, merged_data[,c(-2)]) ## switch activity and subject.ID places

## 4. Appropriately label the data set with descriptive variable names
descriptive_cols <- c(c("subject.ID", "activity"), as.character(reduced_features$V2))
colnames(merged_data) <- descriptive_cols
merged_data$subject.ID <- as.factor(merged_data$subject.ID)

## 5. Create a tidy data set with the avg of each variable for each activity and each subject
tidy_data <- aggregate(.~subject.ID+activity, merged_data, FUN=mean)

## 6. Write tidy_data to file
write.table(tidy_data,"./tidy_data.txt",row.name=FALSE)
