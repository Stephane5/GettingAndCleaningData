# Getting and Cleaning Data - Course project


## How the script works

### Step 1. Merge the training and the test sets to create one data set

First, read each of the relevant files and assign the content to variables
- activity_labels.txt contains the 6 possible activities and their corresponding ids (eg, WALKING)
- features.txt contains the 561 possible measurements and their corresponding ids (eg, tBodyAcc-mean()-X)
- we have the same set of files in the test and train folders, ie:
  - x_train/test.txt that contains 2947 observations across 561 variables (the features)
  - y_train/test.txt that contains the related activity id of each of the 2947 observations
  - subject_train/test.txt that contains the suject id of each of the 2947 observations

Then, accordindly merge the content of x_train.txt, y_train.txt and subject_train.txt into a single train dataframe. In the same fashion, we merge the content of x_test.txt, y_test.txt and subject_test.txt into a single test dataframe.

Finally, the train and test dataframes are merged into a single dataframe

### 2. Extract only the measurements on the mean and standard deviation for each measurement


First, create a short list of features to only keep the mean and std features
Then, drop the columns that do not correspond the short list of features

### 3. Use descriptive activity names to name the activities in the data set

Merge the activity label data with the dataframe

### 4. Appropriately label the data set with descriptive variable names

Replace the V1, V2 column labels with the appropriate feature names

### 5. Create a tidy data set with the avg of each variable for each activity and each subject

Aggregate the date by getting the mean of each feature for each activity and subject

### 6. Write tidy_data to file

Write the resulting tidy data into a tidy_data.txt file



## Code book

subject.ID: each of the 30 participants in the experiments are identified by this id

activity: activity label (among the following values: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)

Measurements (signals). Rather than giving an explanation for each single measurement, it makes more sense to explain the naming convention:
* Starts with t or f:
** t indicates the time domain signals
** f indicates the frequency domain signals (Fast Fourier Transform applied to the t signals)
* Ends with mean(), std(), mean()-X, mean()-Y, mean()-Z, std()-X, std()-Y, std()-Z: respectively the mean and standard deviation of a measurement, and the mean and standard deviation of a measurement across the three axes
* Contains Acc or Gyro
** Acc indicates that the measurement was made using the accelerometer
** Gyro indicates that the measurement was made using the gyroscope
* Contains Mag: indicates it measures the magnitude (euclidian norm)
* The list of recorded signals are:
** BodyAcc: body acceleration
** GravityAcc: gravity acceleration
** BodyAccJerk: body acceleration jerk
** BodyGyro: angular velocity
** BodyGyroJerk: angular velocity jerk

