#1.  Merge the training and test sets to create one dataset
library(RCurl)

if(!file.exists('./uci_smartphone_dataset')){
 dir.create('./uci_smartphone_dataset')
}
dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataUrl, destfile = "./uci_smartphone_dataset/Dataset.zip", method = "libcurl")

