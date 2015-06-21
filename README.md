#############step 1###############
I read in testing all the data that needed according to the project separately for x_test, subject_test, y_test,
x_train, subject_train, y_train and features. Then I create a data frame with row numbers and column names (Subject, Activity). 
I use rbind function to merge the features with this new data frame to get a full list of column names.
Column bind function is used to merge x_test, subject_test and y_test. Same step for training data sets.
After all, I use row bind function to merge testing data and training data. Then I assign the descriptive names in updated features
to this full data set in order to have a data frame.
#############step 2###############
In step 2, I use grep function to match the pattern ('Activity', 'Subject', 'mean(', 'std') in the column names and assign it to
a new data set.

#############step 3###############
Recode function in car is used to recode the values in column Activity.

#############step 4###############
this part has been done in step 1. I think the names in features is descriptive. Otherwise it is subjective.

#############step 5###############
Aggretation is used to create this new data frame with means for each Activity and Subject.


