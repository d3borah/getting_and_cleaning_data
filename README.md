#This is the course project for the coursera course [Getting and Cleaning Data](https://www.coursera.org/course/getdata)

This project presents an R script, run_analysis.R, which obtains data from the web, injests and munges several raw data files and transforms them into one complete tidy data table. Tidy data is data which follows these [principles](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0CB4QFjAA&url=http%3A%2F%2Fvita.had.co.nz%2Fpapers%2Ftidy-data.pdf&ei=bviGVbWiJZCDoQTO5IaoAQ&usg=AFQjCNFUAQr-w_87XpPhfEDoDYQw5-G5zg&sig2=zHw3WZmP8Z49c8Kl34vY-Q&bvm=bv.96339352,d.cGU) as expressed by Hadley Wickham.

Additionally, the script aggregates on the complete tidy data table and produce a tidy data table result, which is then written into a file called tidy_aggregated_data.txt

##For the complete tidy data table the script will:

1. Read data from url.
2. Unzip files.
3. Read activity labels and feature labels files into data frames.
4. Fix the feature labels data frame by removing extraneous parenthesis and converting dashes to periods.
5. Read the data files for X_ test and X_train, while using the feature labels as column names.
6. Read the y and subject files, giving them column names of activity_id and subject_id respectively. 
7. Convert everything to data tables as this is much more efficient for the remaining steps.
8. Add the X_test, y_test, and subject_test data together using cbind (and doing same for train data).
9. Rbind the test and train data together.
10. Use a common key (activity_id) to merge the activity labels onto the merged data.

##For the aggreated tidy data table the script will:

1. Subset only the mean and std columns (66) using regular expressions.
2. Create a new data table with the averages of the subset of measurements by subject and activity.
3. Write the resulting table to file.






