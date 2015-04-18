1.	Download data set : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2.	Ran run_analysis.R script which does the following steps:
        - set a working directory
	-Read X_train.txt, y_train.txt and subject_train.txt from train folder and stored each in variables.
	-Read X_test.txt, y_test.txt and subject_test.txt from test folder in my working directory and stored in data frame.
	-Concatenated test data to train data to generate required data frame, join data; concatenated test label to train label to generate required data frame, 
         join label;concatenated test subject to train subject to generate required data frame etc.
	-Read the features.txt file from my working folder and stored data in a variable called features. Extracted measurements on the mean and standard deviation.
	-Cleaned column names of the subset. Removed "()" and "-" symbols in the names. Also made sure the first letter of "mean" and "std" to capital letter "M" and "S".
	-Read the activity_labels.txt file from my working folder and store it in data frame.
	-Cleaup performed on activity names in the second column of activity. 
         Also if the name has an underscore between letters, removed underscore and made the letter next to a capitalized letter.
	-Transformed values of join label according to the activity data frame.
	-Combined join subject, join label and join data by column to get a new clean data frame. Properly name the first two columns, "subject" and "activity".

