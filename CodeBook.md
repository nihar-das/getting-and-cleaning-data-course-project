**Aim:** Describes the variables, the data, and any transformations or work that you performed to clean up the data

### 1. Merging Train and test sets as one data

1.  Create base path
2.  Create train path
3.  Create test path
4.  Load features.txt from base path and extract second element as *feature_names* (as first variable is just row index which is not needed)
5.  Add two more element *subject_id* and *activity_id* to *feature_names* <add reason of adding two more variable names>
6.  Load *subject_train.txt*, *X_train.txt* and *y_train.txt* from train path as table
7.  Merge subject_train, X_train and y_train DF column wise and name it merged_train
8.  Similarly repeat step 6 to 7 for test path resulting in merged_test
9.  Merge merged_train and merged_test row wise to create final merged_data
10. Pass feature_names as column name to merged_data DF

### 2. Extract mean and std deviation measurements

1.  Extract all columns names with "mean" or "std" text in name along with activity_id and subject_id columns
2.  Subset merged_data with columns names from step 1

### 3. Average of each variable for each activity and each subject

**Will be using dplyr package for this** 1. Load dplyr package 2. convert DF from 2.2 to tbl_df 3. Group by activity_id and subject_id on tbl_df obtained from step 2 4. For each column on subgroup obtained from step 3, calculate mean

### 5. Main

1.  Run merge_train_test_set whose working steps is explained in section 1
2.  Run extract_data_with_required_variables on DF obtained from step 1 whose working steps is explained in section 2
3.  Load activity_labels from base_path
4.  Merge DF from step 2 with activity_label to give descriptive activity name per observation
5.  Run mean_by_activity_subject whose working steps is explained in section 3
6.  Write final tbl_df(tidy data) to txt file(to be done)
