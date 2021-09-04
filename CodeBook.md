## Code book
This is a code book that describes the variables, the data, and any transformations or work that I have performed to clean up the data. `run_analysis.R` script for performing the analysis that does the folloing

1. Merges the training and the test sets to create one data set.
     * Downloading dataset and packages.
     * Reading txt files in table format.
     * Assigning each table to a variable and merging data into `merged_data`.
     
Variable name | Description
-- | --
`train_set` | `train/X_train.txt` Training set.
`train_label` | `train/y_train.txt` Training labels.
`train_subject` | `train/subject_train.txt` Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
`test_set` | `test/X_test.txt` Test set.
`test_label` | `test/y_test.txt` Test labels.
`test_subject` | `test/subject_test.txt` Each row identifies the class label associated with the activity name.
`set_names` | `features.txt` List of all features.
`activity_label` | `activity_labels.txt` Links the class labels with their activity name.
`set` | merging `train_set` and `test_set`
`label` | merging `train_label` and `test_label`
`subject` | merging `train_subject` and `test_subject`

2. Extracts only the measurements on the mean and standard deviation for each measurement.
     * Extracting the column indices with mean or std in the column names.
     * Creating a table `extracted_data`.
3. Uses descriptive activity names to name the activities in the data set.
     * Replacing data in `Activity` column with corresponding activity from `activity_label`. 
4. Appropriately labels the data set with descriptive variable names.
     * Replacing acronyms with descriptive names. 
5. From the data set in a previous step, creates a second, independent tidy data set `TidyData.txt` with the average of each variable for each activity and each subject.