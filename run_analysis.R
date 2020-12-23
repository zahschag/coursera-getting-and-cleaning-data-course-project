##    The submitted data set is tidy.
## The Github repo contains the required scripts.
## GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
## The README that explains the analysis files is clear and understandable.
## The work submitted for this project is the work of the student who submitted it.

## Verification Criteria
## ===================================================================================
## [X]Merges the training and the test sets to create one data set.
## [X]Extracts only the measurements on the mean and standard deviation for each measurement.
## [X]Uses descriptive activity names to name the activities in the data set
## [X]Appropriately labels the data set with descriptive variable names.
## [X]From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## ====================================================================================

# Load dplyr library
library(dplyr)

# Set working directory
setwd("~/Coursera Data Science/R Projects")

# File
filename <- "name.zip"
folderName <- "UCI HAR Dataset"

# Does the archive exists?
  # No Download file.
if(!file.exists(filename)) {
  file_URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(file_URL, filename, method="curl")
}

# Does the folder already exists?
  #No: Unzip file
if(!file.exists(folderName)) {
  unzip(filename)
}

# Read and assign data to variables.
activity_labels <- read.table(paste(folderName,"/activity_labels.txt", sep=""), col.names = c("code","activity"))
features_dtable <- read.table(paste(folderName,"/features.txt",sep=""), col.names = c("feat_number", "feature"))
subject_test_dtable <- read.table(paste(folderName,"/test/subject_test.txt",sep=""), col.names = c("subject"))
subject_train_dtable <- read.table(paste(folderName,"/train/subject_train.txt",sep=""), col.names= c("subject"))
x_test_dtable <- read.table(paste(folderName,"/test/X_test.txt",sep=""), col.name = features_dtable$feature)
y_test_dtable <- read.table(paste(folderName,"/test/Y_test.txt",sep=""), col.name = c("code"))
x_train_dtable <- read.table(paste(folderName,"/train/X_train.txt",sep=""), col.name = features_dtable$feature)
y_train_dtable <- read.table(paste(folderName,"/train/Y_train.txt",sep=""), col.name = c("code"))

# Merge the data
merged_x_data <- bind_rows(x_train_dtable, x_test_dtable)
merged_y_data <- bind_rows(y_train_dtable, y_test_dtable)
merged_subject <- bind_rows(subject_test_dtable, subject_train_dtable)
all_merged <- bind_cols(merged_subject, merged_y_data, merged_x_data)

# Give the variables in the merged tidy set meaningful descriptive names.
tdySet <- all_merged %>%
  select(subject, code, contains("mean"), contains("std")) %>%
  rename(activity = code) %>%
  rename_with(~ gsub("Acc", "Accelerometer", .x, fixed=TRUE)) %>%
  rename_with(~ gsub("Gyro_", "Gyroscope", .x, fixed=TRUE)) %>%
  rename_with(~ gsub("BodyBody", "Body", .x, fixed=TRUE)) %>%
  rename_with(~ gsub("mag", "Magnitude", .x, fixed=TRUE)) %>%
  rename_with(~ gsub("tBody", "TimeBody", .x, fixed=TRUE)) %>%
  rename_with(~ gsub("fBody", "FrequencyBody", .x, fixed=TRUE)) %>%
  rename_with(~ gsub("tGravity", "TimeGravity", .x, fixed=TRUE))%>%
  rename_with(~ gsub("std", "STD", .x, fixed=TRUE)) %>%
  rename_with(~ gsub("gravityMean", "GravityMean", .x, fixed=TRUE)) %>%
  rename_with(~ gsub("gravity", "Gravity", .x, fixed=TRUE)) %>%
  rename_with(~ gsub("mean", "Mean", .x, fixed=TRUE))

# Replace integer value with the string representation of the activity.
tdySet$activity <- activity_labels[tdySet$activity,2]

# Create independent tiny dataset with the avg of all variables by activity and subject.
output_set <- tdySet %>%
  group_by(subject, activity) %>%
  summarize_all(list(mean))

# Save the independent tiny set to a text file.
write.table(output_set, "Output-File.txt", row.name=FALSE)
   
