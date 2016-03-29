#1.  Merge the training and test sets to create one dataset

library(RCurl)

if(!file.exists('./uci_smartphone_dataset/Dataset.zip')){
  dir.create('./uci_smartphone_dataset')
  dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(dataUrl, destfile = "./uci_smartphone_dataset/Dataset.zip", method = "libcurl")
  unzip('./uci_smartphone_dataset/Dataset.zip');
}

x_train <- read.table('UCI HAR Dataset/train/X_train.txt')
x_test <- read.table('UCI HAR Dataset/test/X_test.txt')
x_bind <- rbind(x_train, x_test)

subject_train <- read.table('UCI HAR Dataset/train/subject_train.txt')
subject_test <- read.table('UCI HAR Dataset/test/subject_test.txt')
subject_bind <- rbind(subject_train, subject_test)

y_train <- read.table('UCI HAR Dataset/train/y_train.txt')
y_test <- read.table('UCI HAR Dataset/test/y_test.txt')
y_bind <- rbind(y_train, y_test)

names(subject_bind) <- c("subject")
names(y_bind) <- c("activity")
x_names <- read.table('UCI HAR Dataset/features.txt', head=FALSE)
names(x_bind) <- x_names$V2

merged_data <- cbind(x_bind, cbind(subject_bind, y_bind))



#2. Extract only the measurements on mean and standard deviation for each measurement
feature_mean_sd <- x_names$V2[grep("mean\\(\\)|std\\(\\)", x_names$V2)]
subset_data <- c(as.character(feature_mean_sd),"subject","activity")
merged_data <- subset( merged_data, select=subset_data)

#3. Use descriptive activity names to name the activities in the data set
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt",head = FALSE)
merged_data$activity<-factor(merged_data$activity);
merged_data$activity<- factor(merged_data$activity,labels=as.character(activityLabels$V2))


#4. Appropriately labels the data sets with descriptive variable names
names(merged_data)<-gsub("^t", "time", names(merged_data))
names(merged_data)<-gsub("^f", "frequency", names(merged_data))
names(merged_data)<-gsub("Acc", "Accelerometer", names(merged_data))
names(merged_data)<-gsub("Gyro", "Gyroscope", names(merged_data))
names(merged_data)<-gsub("Mag", "Magnitude", names(merged_data))
names(merged_data)<-gsub("BodyBody", "Body", names(merged_data))


#5. Create a second independent tidy data set with the average of each acvitivty and each subject
library(plyr)
merged_data2<-aggregate(. ~subject + activity, merged_data, mean)
merged_data2<-merged_data2[order(merged_data2$subject,merged_data2$activity),]
write.table(merged_data2, file = "merged_tidy_data.txt",row.name=FALSE)

