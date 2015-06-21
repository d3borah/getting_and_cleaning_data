#Codebook

---
##Complete Tidy Data Set
---

###Description of the Data and Variables:

The complete tidy data set contains 561 different columns representing normalized measurements from the accelerometers of a Samsung Galaxy S smartphone. There are two additional columns containing one of 30 subject ids, and one of 6 activity types. 

The rows contain the data for 30 different people (9 of whom are test subjects, 21 of whom are train subjects), with a time series for each subject over the set of 6 different activities. There are 2947 total observations (row) split between 6 activities over the 9 test subjects, and 7352 observations (rows) split between 6 activities over the 21 train subjects. 

###Description of the Transformations:

The feature labels are transformed by removing extraneous parenthesis and converting dashes to periods, and then used as labels for the columns of the data. The X_test, y_test, and subject_test data are bound together, and the same is done for the training data. Then the test and train data are row bound together. A common key is used to merge the activity labels onto the merged data based on the activity id’s. 

---
##Aggregated Tidy Data Set
---

###Description of the Data and Variables:

The data set is an aggregation (average) of 66 selected features which are either means or standard deviations in themselves. The features were selected using regular expressions on the original 561 features to match those with plain mean (33) or std (33). Excluded were those which contained meanFreq or gravityMean.

Thus this data set consists of 6 values for each subject (6*30 = 180 observations).

###Description of the Transformations:

We subset only mean and std columns (66) using regular expressions. Then create a new data table with the averages of the measurements by subject and activity and write the resulting table to file.