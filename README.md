## Getting and Cleaning Data in R

This repository provides the required processing script and codebook to work on `UCL HAR Dataset`.

Processing script working is followed as per instructions given below:

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#### _More details on working of the script and dataset is given in CodeBook.md_

## How to use this repository to process data ?

1. Clone the repository
2. Create a directory name `Data`
3. Download the [UCL HAR Dataset](https://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones)
4. Extract the `UCL HAR Dataset` to `Data` directory with both directory name strictly same as mentioned here.
5. Execute command `source("run_analysis.R")`
6. Execute command `main()`
7. Processed output file name `tidy_data.txt` will be avaialable at same level as `run_analysis.R` file
