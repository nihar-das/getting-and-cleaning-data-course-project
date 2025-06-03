## Dataset information (source: [UCL HAR Dataset](https://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones))

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING,WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### For each record it is provided :

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment.

### Original source includes following files:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

### The following files are available for the train and test data:

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

## Working of `run_analysis.R` script

**How to use the script**

```
source("run_analysis.R")
main()
```

**Will give processed data file named `tidy_data.txt` as ouput in the working directory**

### 1. Merging train and test sets as one data

1.  Create base path
2.  Create train path
3.  Create test path
4.  Load _features.txt_ from base path and extract second element as `feature_names` (as first variable is just row index which is not needed)
5.  Add three more elements _subject_id_ and _activity_id_ to `feature_names` (These elements represent column/variable names which will merged on further steps)
6.  Load _subject_train.txt_, _X_train.txt_ and _y_train.txt_ from train path as table
7.  Merge `subject_train`, `X_train` and `y_train` DF column wise and name it `merged_train`
8.  Similarly repeat step 6 to 7 for test path resulting in merged_test
9.  Merge `merged_train` and merged_test row wise to create final `merged_data`
10. Pass `feature_names` as column name to `merged_data` DF

### 2. Extract mean and std deviation measurements

1.  Extract all columns names with "mean" or "std" text in name along with _activity_id_ and _subject_id_ columns
2.  Subset `merged_data` DF with columns names obtained from step 1

### 3. Average of each variable for each activity and each subject

##### Will be using `dplyr` package for this

1.  Load dplyr package
2.  Convert DF to tbl_df
3.  Group by _activity_id_ and _subject_id_ on tbl_df obtained from step 2
4.  For each possible _activity_id_ and _subject_id_ pair/subgroup obtained from step 3, calculate mean for each column (except _activity_name_ column)

### 4. Main

1.  Run `merge_train_test_set` whose working steps is explained in section 1
2.  Run `extract_data_with_required_variables` on DF obtained from step 1 whose working steps is explained in section 2
3.  Run `mean_by_activity_subject` and pass DF obtained from step 2. `mean_by_activity_subject` working steps is explained in section 3
4.  Load _activity_labels_ from _base_path_
5.  Merge DF from step 3 with activity_labels DF from step 4 to give descriptive activity name per observation
6.  Write final tidy data to disk with name `tidy_data.txt`
