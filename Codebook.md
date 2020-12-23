The `run_analysis.R` script prepares the data by following the steps required to meet the course project's definition.

1. Download the dataset
 * Download [this dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 
 and extract its contents into the folder named UCI HAR Dataset.
 
 2. Assign the extracted data to variables
 
 * `activity_labels` <- `activity_labels.txt`: 6 row, 2 columns.
 List of static and dynamic activities performed when they were being tracked as well as the corresponding label (code) 
 
 * `features_dtable` <- `features.txt` : 561 rows, 2 columns
 Features chosen for this db are originate from the accelerometer & gyroscope 3 axial raw signals tAcc-XYZ and tGyro-XYZ.

 * `subject_test_dtable` <- `subject_test.txt` 2947 rows, 1 column
Has test data of 30%(9/30) of participants being observed.

 * `subject_train_dtable` <- `subject_train.txt`: 7352 rows, 1 column
 Has train data of 70%(21/30) of the participants being observed.
 
 * `x_test_dtable` <- `X_test.txt` 2947 rows, 561 columns
Recorded features test data 

 * `y_test_dtable` <- `Y_test.txt` 2947 rows, 1 column
Activity code labels for test data

 
 * `x_train_dtable` <- `X_train.txt` 7352 rows, 561 columns
Recorded features train data 

 * `y_train_dtable` <- `Y_train.txt` 7352 rows, 1 column
Activity code labels for train data

3. Creates one data set from all the training and test data.
* `merged_x_data` (10299 rows, 561 columns) includes the recorded features for the test and training data, this is created by using the `bind_rows` function on the `x_train_dtable` and `x_test_dtable`.
* `merged_y_data` (10299 rows, 1 column) incldudes the activity code labels for the test and training data, that is created using the `bind_rows` function on the `y_train_dtable` and `y_test_dtable`.
* `merged_subject` (10299 rows, 1 column) is the result of merging the test and train data from all participants observed. Is created by using the `bind_rows ` function on the `subject_test_dtable` and `subject_train_dtable`.
* `all_merged` (10299, 563 columns) is the result of merging merged_x_data, merged_y_data, and merged_subject using the `bind_cols` function.

4. Extract only the measurements on the mean and standard deviation for each measurement.
* `tdySet` (10299 rows, 88 columns) Using `select` from the dplyr library, a subset of the `all_merged` variable is selected by the following columns: subject and code. To select only the observations that have the standard deviation and mean we use the `contains` from the tidy select library to match `mean` or `std`.


5. Renames variables with more descriptive names using the `rename_with` function from the dplyr library and `gsub` function from `grep`
`code` replaced with `activity`
* All `Acc` found in column names is replaced with 'Accelerometer'.
* All `Gyro` found in column names is replaced with `Gyroscope`.
* All `BodyBody` replaced with `Body`.
* All `mag` replaced with `Magnitude`.
* All `tbody` replaced with `TimeBody`
* All `fbody` replaced with `FrequencyBody`
* All `tGravity` replaced with `TimeGravity`
* All `std` replaced with `STD`
* All `gravityMean` replaced with `GravityMean`
* All `gravity` replaced with `Gravity`
* All `mean` replaced with `Mean`


6. Replace integer value with the string representation of the activity labels.

7. Creates independent tiny dataset with a summary that includes the avg of all variables by activity and subject.
* `output_set`(10299 rows, 88 columns) the summary for the `output_set` was created by using the `group_by` and `summarize_all` functions from the dplyr library.
* Export the `output_set` to `Output-File.txt`.