#############step 1###############
#read in testing data
x_test<-read.table(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\test\\X_test.txt")
subject_test<-read.table(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\test\\subject_test.txt")
y_test<-read.table(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\test\\y_test.txt")

#read in training data
x_train<-read.table(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\train\\X_train.txt")
subject_train<-read.table(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\train\\subject_train.txt")
y_train<-read.table(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\train\\y_train.txt")

#read in column names
feature<-read.table(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\features.txt")

#combine names with extra
a<-data.frame(V1=c('562', '563'), V2=c("Subject", "Activity"))
features<-rbind(feature, a)

#combine testing data
test<-cbind(x_test,subject_test, y_test)
#combine training data
train<-cbind(x_train,subject_train, y_train)
#combine testing with training
original.data<-rbind(test, train)
#assign names
names(original.data)<-features$V2

#create data frame
data<-data.frame(original.data)

#############step 2###############
library("gdata")
library(dplyr)
#columns<-matchcols(data, with=c("Subject", "Activity", ".*-mean\\(.*", "std"), method = "or")
pattern=c("mean\\(")
text=features$V2
columns<-c(grep(pattern, text), grep('std', text, fixed = TRUE),
           grep('Activity', text, fixed = TRUE), grep('Subject', text, fixed = TRUE))
sub.data<-data[, columns]

#############step 3###############
sub.bck<-sub.data
library("car")
sub.data$Activity<-recode(sub.data$Activity, "1='WALKING'; 2='WALKING_UPSTAIRS'; 3='WALKING_DOWNSTAIRS'
; 4='SITTING'; 5='STANDING'; 6='LAYING'" )

#############step 4###############
#have already got the descriptive names from features in step 1 at the beginning.
names(sub.data)

#############step 5###############
#get the mean of variables by Activity and Subject
dt2<-aggregate(. ~ Activity + Subject, sub.data, mean)
dt2<-edit(dt2)
write.table(dt2, ".\\data\\clean_dataset.txt", row.name=FALSE)




