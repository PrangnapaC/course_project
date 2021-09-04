# Merges the training and the test sets to create one data set
library(dplyr)

train_set <- read.table("UCI HAR Dataset/train/X_train.txt")
train_label <- read.table("UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")

test_set <- read.table("UCI HAR Dataset/test/X_test.txt")
test_label <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")

set <- rbind(train_set, test_set)
label <- rbind(train_label, test_label)
subject <- rbind(train_subject, test_subject)

set_names <- read.table("UCI HAR Dataset/features.txt")
activity_label <- read.table("UCI HAR Dataset/activity_labels.txt")

colnames(set) <- t(set_names[2])
colnames(label) <- "Activity"
colnames(subject) <- "Subject"

merged_data <- cbind(set, Activity, Subject)

# Extracts only the measurements 
# on the mean and standard deviation for each measurement
mean_std <- grep(".*Mean.*|.*Std.*", names(merged_data), ignore.case=TRUE)
extracted_data <- merged_data[,mean_std]
extracted_data <- cbind(extracted_data, merged_data[,562:563])

# Uses descriptive activity names to name the activities in the data set
extracted_data$Activity <- activity_label[extracted_data$Activity,2]

# Appropriately labels the data set with descriptive variable names
names(extracted_data)
names(extracted_data) <- gsub("^t", "Time", names(extracted_data))
names(extracted_data) <- gsub("Acc", "Accelerometer", names(extracted_data))
names(extracted_data) <- gsub("-mean", "Mean", names(extracted_data))
names(extracted_data) <- gsub("-std", "STD", names(extracted_data))
names(extracted_data) <- gsub("Gyro", "Gyroscope", names(extracted_data))
names(extracted_data) <- gsub("^f", "Frequency", names(extracted_data))
names(extracted_data) <- gsub("Freq", "Frequency", names(extracted_data))
names(extracted_data) <- gsub("Mag", "Magnitude", names(extracted_data))
names(extracted_data) <- gsub("angle", "Angle", names(extracted_data))
names(extracted_data) <- gsub("tBody", "TimeBody", names(extracted_data))
names(extracted_data) <- gsub("gravity", "Gravity", names(extracted_data))

# Create a second, independent tidy data set
# with the average of each variable for each activity and each subject
tidy_data <- aggregate(. ~Subject + Activity, extracted_data, mean)
tidy_data <- tidy_data[order(tidy_data$Subject),]
write.table(tidy_data, file = "TidyData.txt", row.names = FALSE)