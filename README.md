This is the course project for the coursera course 
Getting and Cleaning Data 

For the project, I wrote an R script, run_analysis.R, which will injest and munge several raw data files from the /data directory and turn them into one complete tidy data table. It will then run an aggregation on the complete tidy data table and produce a tidy data table result, which will then be written into a file called tidy_aggregated_data.txt

For the complete tidy data table the script will:

1) read data from url
2) unzip files
3) read activity labels and feature labels files into data frames
4) fix the feature labels data frame by removing extraneous parenthesis and converting dashes to periods
5) read the data files for X_ test and X_train, while using the feature labels as column names.
6) read the y and subject files, giving them column names of activity_id and subject_id respectively. 
7) convert everything to data tables as this is much more efficient for the remaining steps
8) add the X_test, y_test, and subject_test data together using cbind (and doing same for train data)
9) rbind the test and train data together
9) use a common key (activity_id) to merge the activity labels onto the merged data

For the aggreated tidy data table the script will:
1) subset only mean and std columns (66) using regular expressions
2) create a new data table with the averages of the measurements by subject and activity
3) write the resulting table to file






