library(data.table)
library(dplyr)
library(tidyr)

#### Download File ####

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dir.create("temp")
course_project_zip <- download.file(fileURL, "course_project.zip", method = "curl")
unzip("./course_project.zip", exdir="temp")

#### load training and test sets ####
training_set <- read.table("./temp/UCI HAR Dataset/train/X_train.txt")
training_labels <- read.table("./temp/UCI HAR Dataset/train/y_train.txt")
training_subjects <- read.table("./temp/UCI HAR Dataset/train/subject_train.txt")

test_set <- read.table("./temp/UCI HAR Dataset/test/X_test.txt")
test_labels <- read.table("./temp/UCI HAR Dataset/test/y_test.txt")
test_subjects <- read.table("./temp/UCI HAR Dataset/test/subject_test.txt")

features <- read.table("./temp/UCI HAR Dataset/features.txt")

#### rename columns and merge data sets ####
training_labels <- rename(training_labels, activity_name = V1)
training_subjects <- rename(training_subjects, subject_id = V1)
training_set_agg <- data.frame(training_subjects, training_labels, training_set)
training_set_agg$data_set <- "train"


test_labels <- rename(test_labels, activity_name = V1)
test_subjects <- rename(test_subjects, subject_id = V1)
test_set_agg <- data.frame(test_subjects, test_labels, test_set)
test_set_agg$data_set <- "test"

data_set_agg <- rbind(training_set_agg, test_set_agg)

mean_indices <- grep("\\bmean()\\b", features$V2)
std_indices <- grep("\\bstd()\\b", features$V2)
features_indices <- c(mean_indices, std_indices)

data_set_mean_std <- data_set_agg[,c(1, 2, features_indices + 2)]
features <- features[features_indices, ]
features <- arrange(features, V1)

data_set_mean_std <- setnames(data_set_mean_std, names(data_set_mean_std)[3:68], as.character(features$V2))

data_set_gathered <- gather(data_set_mean_std, key = signal_axis_statistic, value = measurement, -activity_name, -subject_id)

data_set_separated <- separate(data_set_gathered, signal_axis_statistic, c("signal", "axis", "statistic"))

#### name activities ####
data_set_separated <- data_set_separated %>% 
  mutate(activity_name = gsub(1, "WALKING", activity_name)) %>%
           mutate(activity_name = gsub(2, "WALKING_UPSTAIRS", activity_name)) %>%
                    mutate(activity_name = gsub(3, "WALKING_DOWNSTAIRS", activity_name)) %>%
                             mutate(activity_name = gsub(4, "SITTING", activity_name)) %>%
                                      mutate(activity_name = gsub(5, "STANDING", activity_name)) %>%
                                               mutate(activity_name = gsub(6, "LAYING", activity_name))

#### group and summarize data ####
data_set_grouped <- group_by(data_set_separated, subject_id, activity_name, signal, axis, statistic)

data_set_summarized <- summarize(data_set_grouped, mean(measurement))