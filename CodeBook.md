## Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## Attribute Information
For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
 
- Triaxial Angular velocity from the gyroscope. 
 
- A 561-feature vector with time and frequency domain variables. 
 
- Its activity label. 
 
- An identifier of the subject who carried out the experiment.

## Description of files used from the dataset

- 'features.txt': List of all features.
 
- 'activity_labels.txt': Links the class labels with their activity name.
 
- 'X_train.txt': Training set.
 
- 'y_train.txt': Training labels.
 
- 'X_test.txt': Test set.
 
- 'y_test.txt': Test labels.
 
- 'subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

## Transformations 

- Rename columns in `y_train.txt`, `y_test.txt`, `subject_train.txt` and `subject_test.txt` to be more descriptive

- For both the training and test data sets, merge subject and activity label data with observations in `X_train.txt` and X_test.txt`

- Combine the training and test data into a single data frame with `rbind()`

- Isolate `mean()` and `std()` measurements from the data set using `grep()`

- Use `gather()` and `separate()` functions to set each variable as a column; resulting columns are "signal", "axis" and "statistic"

- Based on the key in `activity_labels.txt`, use `gsub()` and `mutate()` to create descriptive names for activities in the data set

- Create a second, independent tidy data set with the average of each variable for each activity and each subject using the `group_by()` and `summarize()` functions

- Save the new data set by using `write.table()` to generate `tidy_data`.text
