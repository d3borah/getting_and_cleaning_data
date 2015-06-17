library(data.table)
setwd("./getting_and_cleaning_data")

#download the file, unzip it, and examine contents
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/tempfile.zip", method = "curl")
unzip("./data/tempfile.zip", exdir="./data/")
#list.files("./data/UCI HAR Dataset/")

#read the feature and activity labels into data tables
feature_labels_df <- read.table("./data/UCI HAR Dataset/features.txt", header=FALSE, col.names=c("feature_id","feature_name"))
activity_labels_df <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header=FALSE, col.names=c("activity_id","activity_type"))
feature_labels_df

#edit the column names to remove parentheses
feature_labels_df$feature_name <- gsub("\\(\\)", "", feature_labels_df[,2], ignore.case = FALSE,fixed = FALSE)
feature_labels_df$feature_name <- gsub("," , ".", feature_labels_df[,2], ignore.case = FALSE,fixed = FALSE)
feature_labels_df$feature_name <- gsub("-" , ".", feature_labels_df[,2], ignore.case = FALSE,fixed = FALSE)
feature_labels_df$feature_name <- gsub("\\(" , "", feature_labels_df[,2], ignore.case = FALSE,fixed = FALSE)
feature_labels_df$feature_name <- gsub("\\)" , "", feature_labels_df[,2], ignore.case = FALSE,fixed = FALSE)

#make the column (feature) names 
feature_labels <- paste(feature_labels_df$feature_name)

#read the test and train data into data frames
X_test_df <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header=FALSE,col.names=feature_labels)
head(X_test_df)
y_test_df <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header=FALSE, col.names=c("activity_id"))
subject_test_df <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header=FALSE, col.names=c("subject_id"))
table(subject_test_df)
X_train_df <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header=FALSE, col.names=feature_labels)
y_train_df <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header=FALSE, col.names=c("activity_id"))
subject_train_df <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header=FALSE, col.names=c("subject_id"))
table(subject_train_df)

#convert to data tables
X_test <- data.table(X_test_df)
y_test <- data.table(y_test_df)
subject_test <- data.table(subject_test_df)
X_train <- data.table(X_train_df)
y_train<- data.table(y_train_df)
subject_train <- data.table(subject_train_df)
activity_labels <- data.table(activity_labels_df)
rm(X_test_df,y_test_df,subject_test_df,X_train_df,y_train_df,subject_train_df,feature_labels_df,activity_labels_df)

#add the feature and activity label markers into the measurement data
X_test_with_y_and_subjects_and_y <- cbind(X_test, y_test,subject_test)
X_train_with_y_and_subjects <- cbind(X_train, y_train,subject_train)
rm(X_test, y_test,subject_test,X_train, y_train,subject_train)

#combine the completed train and test data
Test_and_Train <- rbind(X_test_with_y_and_subjects_and_y,X_train_with_y_and_subjects)
rm(X_test_with_y_and_subjects_and_y,X_train_with_y_and_subjects)

#combine the activity labels by the activity_id key
setkey(Test_and_Train,activity_id)
setkey(activity_labels,activity_id)
merged_data <- merge(Test_and_Train,activity_labels)
rm(Test_and_Train,activity_labels)

#subset only mean and std columns, along with the subject and activity
selectedcolumns <- paste(feature_labels[grep("\\.[mM]ean\\.*[^F]*$|\\.std\\.*[^F]*$|^subject|^activity", feature_labels)])
selectedcolumns<- append(selectedcolumns,c("subject_id","activity_type"))
merged_data_mean_std <- merged_data[,selectedcolumns, with=FALSE]
rm(merged_data,feature_labels,selectedcolumns)

#create new tidy data set of the averages of the selected features per subject per activity
ag <- merged_data_mean_std[,lapply(.SD,mean),by=list(subject_id,activity_type)]
#table(ag$subject_id)
#table(ag$activity_type)

#write results table to file
write.table(ag,"tidy_aggregated_data.txt", row.name=FALSE)
