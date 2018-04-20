#load the required packages
library("dplyr","reshape2","markdown","data.table")

#setting path 
setwd("C:/Users/nkamal2/Downloads/DS_training/course3_R/UCI HAR Dataset_project")


#reading all the tests and train text files
subject_test <-fread("./test/subject_test.txt")
x_test <-fread("./test/X_test.txt")
y_test <-fread("./test/y_test.txt")


subject_train<-fread("./train/subject_train.txt")
x_train <-fread("./train/X_train.txt")
y_train <-fread("./train/y_train.txt")

#merging x_train and x_test
x_data <- rbind(x_train,x_test)

#merging y_train and y_test
y_data <- rbind(y_train,y_test)

#merging subject_train and subject_test
subject_data <- rbind(subject_train,subject_test)

################# step 2 ##############
#Extracts only the measurements on the mean and standard deviation for each measurement

feature_df <-read.table("features.txt")
mean_std_feature <- grep("-(mean|std)\\(\\)", feature_df[, 2])
x_data <- x_data[,mean_std_feature,with=FALSE]

################# step 3 ##############
names(x_data) <- as.character(feature_df[mean_std_feature,2])

################# step 4 ##############
#Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("activity_labels.txt")
setnames(activity_labels,names(activity_labels),c("activityNum", "activityName"))
setnames(y_data,names(y_data),c("activityNum"))

names(subject_data) <- "subject"
all_data <- cbind(x_data,y_data,subject_data)
all_data <- merge(all_data, activity_labels, by = "activityNum", all.x = TRUE)


################# step 5 ##############
avg_data <- ddply(all_data, .(subject, activityName), function(x) colMeans(x[, 1:66]))
write.table(avg_data, "avg_data.txt", row.name=FALSE)


