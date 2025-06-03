base_path <- file.path("Data", "UCI HAR Dataset")

merge_train_test_set <- function() {
  feature_names <- read.table(file.path(base_path, "features.txt"), header = FALSE)[[2]]
  feature_names <- c("subject_id", feature_names, "activity_id")
  
  train_path <- file.path(base_path, "train")
  subject_train <- read.table(file.path(train_path, "subject_train.txt"), header = FALSE)
  x_train <- read.table(file.path(train_path, "X_train.txt"), header = FALSE)
  y_train <- read.table(file.path(train_path, "y_train.txt"), header = FALSE)
  merged_train <- cbind(subject_train, x_train, y_train)
  
  test_path <- file.path(base_path, "test")
  subject_test <- read.table(file.path(test_path, "subject_test.txt"), header = FALSE)
  x_test <- read.table(file.path(test_path, "X_test.txt"), header = FALSE)
  y_test <- read.table(file.path(test_path, "y_test.txt"), header = FALSE)
  merged_test <- cbind(subject_test, x_test, y_test)
  
  merged_data <- rbind(merged_train, merged_test)
  colnames(merged_data) <- feature_names
  
  merged_data
}

extract_data_with_required_variables <- function(merged_data) {
  req_cols <- grep("subject_id|mean|std|activity_id", names(merged_data), value = TRUE)
  mean_std_data <- merged_data[, req_cols]
  
  mean_std_data
}

mean_by_activity_subject <- function(mean_std_data) {
  library(dplyr)
  mean_std_data <- as_tibble(mean_std_data)
  mean_std_data %>%
    group_by(activity_id, subject_id) %>%
    mutate(across(-activity_name, mean))
}

main <- function() {
  merged_data <- merge_train_test_set()
  mean_std_data <- extract_data_with_required_variables(merged_data)
  
  activity_labels <- read.table(file.path(base_path, "activity_labels.txt"), header = FALSE, col.names = c("activity_id", "activity_name"))
  mean_std_data <- merge(mean_std_data, activity_labels, by = "activity_id", all.x = TRUE)
  
  mean_by_activity_subject(mean_std_data)
}
