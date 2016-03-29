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


